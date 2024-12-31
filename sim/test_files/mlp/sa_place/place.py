import numpy as np
import sys
import random

def manhattan_distance(pos1, pos2):
    """Calculate the Manhattan distance between two points."""
    return abs(pos1[0] - pos2[0]) + abs(pos1[1] - pos2[1])

def position_to_router_id(pos, grid_size):
    """Convert a grid position to a router ID (row-major order)."""
    return pos[0] * grid_size[1] + pos[1] + 1

def compute_cost(placement, mlps, layer_sizes, num_mvms):
    """
    Compute the total cost for a placement with penalties for non-compact placements
    and weight-sharing costs.

    Args:
        placement: Dictionary mapping MLPs to positions.
        mlps: List of MLPs.
        layer_sizes: Dictionary mapping MLPs to their layer sizes.
        num_mvms: Dictionary mapping MLPs to number of MVMs per layer.

    Returns:
        Total cost (communication + weight sharing + compactness penalty).
    """
    total_cost = 0

    for i, mlp in enumerate(mlps):
        comm_cost = 0
        weight_share_cost = 0
        compactness_penalty = 0

        # Calculate communication cost for the MLP layers
        positions = placement[mlp]
        for l in range(len(positions) - 1):
            layer1_positions = positions[l]
            layer2_positions = positions[l + 1]
            layer_distances = [
                manhattan_distance(p1, p2)
                for p1 in layer1_positions for p2 in layer2_positions
            ]
            comm_cost += sum(layer_distances)  # Sum all pairwise distances

        # Calculate compactness penalty for each layer
        for layer_positions in positions:
            if len(layer_positions) > 1:
                for i, pos1 in enumerate(layer_positions):
                    for pos2 in layer_positions[i + 1:]:
                        dist = manhattan_distance(pos1, pos2)
                        if dist > 1:  # Penalize non-adjacent placements
                            compactness_penalty += dist - 1

                        # Additional penalty for diagonal placements
                        if abs(pos1[0] - pos2[0]) == 1 and abs(pos1[1] - pos2[1]) == 1:
                            compactness_penalty += 2  # Heavier penalty for diagonals

        # Calculate weight sharing cost
        for j in range(i):  # Compare with previously placed MLPs
            shared_weights = 0
            shared_weight_penalty = 0
            for layer_idx, layer_size in enumerate(layer_sizes[mlp][1:-1]):
                if layer_idx < len(layer_sizes[mlps[j]][1:-1]):
                    shared_size = min(layer_size, layer_sizes[mlps[j]][layer_idx + 1])
                    overlap_factor = min(num_mvms[mlp][layer_idx + 1], num_mvms[mlps[j]][layer_idx + 1])
                    
                    # Compute weight-sharing penalty based on distances
                    layer_distances = [
                        manhattan_distance(p1, p2)
                        for p1 in positions[layer_idx + 1]
                        for p2 in placement[mlps[j]][layer_idx + 1]
                    ]
                    shared_weights += shared_size * overlap_factor
                    shared_weight_penalty += sum(layer_distances) * shared_size * overlap_factor

            weight_share_cost += shared_weights + shared_weight_penalty

        total_cost += comm_cost + weight_share_cost + compactness_penalty

    return total_cost

def format_placement(placement, num_mvms, grid_size):
    """Format placement as a mapping from layer to router IDs."""
    formatted = {}
    for layer_idx, pos in enumerate(placement):
        if isinstance(pos, tuple):  # Ensure the position is a tuple
            router_ids = [position_to_router_id(pos, grid_size)]
        elif isinstance(pos, list):  # Handle a list of tuples
            router_ids = [position_to_router_id(p, grid_size) for p in pos]
        else:
            raise TypeError(f"Unexpected position type: {type(pos)}")
        formatted[layer_idx + 1] = router_ids
    return formatted

def initialize_placement(mlps, grid_size, layer_sizes, num_mvms):
    total_mvms = grid_size[0] * grid_size[1]
    all_positions = [(i // grid_size[1], i % grid_size[1]) for i in range(total_mvms)]
    
    # Exclude specific routers (e.g., 1 and 9)
    excluded_routers = [1, 9]
    available_positions = [
        pos for pos in all_positions
        if position_to_router_id(pos, grid_size) not in excluded_routers
    ]
    
    placement = {}
    global_used_positions = set()  # Tracks all used positions globally

    for mlp in mlps:
        print(f"Placing {mlp}...")
        placement[mlp] = []

        for layer_idx in range(len(layer_sizes[mlp])):
            required_mvms = num_mvms[mlp][layer_idx]
            # Exclude globally used positions
            available_choices = [
                pos for pos in available_positions if pos not in global_used_positions
            ]

            if len(available_choices) < required_mvms:
                raise ValueError(f"Not enough MVMs for {mlp} layer {layer_idx + 1} with grid size {grid_size}.")

            # Assign positions for the MVMs of this layer
            # Prioritize compact placements by sorting available choices
            sorted_choices = sorted(
                available_choices,
                key=lambda pos: sum(manhattan_distance(pos, p) for p in global_used_positions)
            )
            assigned_positions = sorted_choices[:required_mvms]
            placement[mlp].append(assigned_positions)

            # Mark these positions as used globally
            global_used_positions.update(assigned_positions)

    return placement

def simulated_annealing(mlps, grid_size, layer_sizes, num_mvms, initial_temp, cooling_rate, max_iterations):
    """
    Perform simulated annealing to find the optimal placement for each MLP independently.

    Args:
        mlps: List of MLPs.
        grid_size: Tuple (rows, cols) representing the NoC dimensions.
        layer_sizes: Dictionary mapping MLPs to their layer sizes.
        num_mvms: Dictionary mapping MLPs to number of MVMs per layer.
        initial_temp: Initial temperature for simulated annealing.
        cooling_rate: Cooling rate for annealing.
        max_iterations: Maximum iterations for the process.

    Returns:
        Dictionary with the best placement and cost for each MLP.
    """
    best_results = {}
    global_placement = {}  # Track the best placement for all MLPs

    # Generate all possible MVM positions, excluding routers 1 and 9
    all_positions = [(i // grid_size[1], i % grid_size[1]) for i in range(grid_size[0] * grid_size[1])]
    excluded_routers = [1, 9]
    available_positions = [
        pos for pos in all_positions
        if position_to_router_id(pos, grid_size) not in excluded_routers
    ]

    global_used_positions = set()  # Track globally used positions across all MLPs

    for mlp in mlps:
        print(f"\nOptimizing placement for {mlp}...")
        # Initialize placement randomly for this MLP
        placement = initialize_placement([mlp], grid_size, layer_sizes, num_mvms)
        for layer in placement[mlp]:
            global_used_positions.update(layer)  # Track globally used positions

        current_cost = compute_cost(placement, [mlp], layer_sizes, num_mvms)

        best_placement = placement.copy()
        best_cost = current_cost

        temperature = initial_temp

        for iteration in range(max_iterations):
            print(f"\nIteration {iteration + 1}: Current Cost = {current_cost}, Temperature = {temperature}")

            # Select a random layer to move
            layer_to_move = random.randint(0, len(layer_sizes[mlp]) - 1)
            required_mvms = num_mvms[mlp][layer_to_move]

            # Release previously used positions for the selected layer
            for pos in best_placement[mlp][layer_to_move]:
                global_used_positions.discard(pos)

            # Get dynamically available positions
            available_choices = [
                pos for pos in available_positions if pos not in global_used_positions
            ]

            if len(available_choices) < required_mvms:
                raise ValueError(f"Not enough MVMs for layer {layer_to_move + 1} of {mlp}.")

            # Propose new positions for the layer
            new_positions = random.sample(available_choices, required_mvms)

            # Update global usage
            for pos in new_positions:
                global_used_positions.add(pos)

            # Create new placement proposal
            new_placement = best_placement.copy()
            new_placement[mlp][layer_to_move] = new_positions

            # Recalculate costs
            comm_cost = 0
            weight_share_cost = 0

            # Calculate communication cost for the MLP layers
            positions = new_placement[mlp]
            for l in range(len(positions) - 1):
                layer1_positions = positions[l]
                layer2_positions = positions[l + 1]
                layer_distances = [
                    manhattan_distance(p1, p2)
                    for p1 in layer1_positions for p2 in layer2_positions
                ]
                comm_cost += sum(layer_distances)  # Sum all pairwise distances

            for prev_mlp, prev_placement in global_placement.items():  # Compare with already optimized MLPs
                for layer_idx, layer_size in enumerate(layer_sizes[mlp][1:-1]):
                    if layer_idx < len(layer_sizes[prev_mlp][1:-1]):
                        shared_size = min(layer_size, layer_sizes[prev_mlp][layer_idx + 1])
                        overlap_factor = min(num_mvms[mlp][layer_idx + 1], num_mvms[prev_mlp][layer_idx + 1])
                        
                        # Use the latest placement of the current MLP
                        layer_distances = [
                            manhattan_distance(p1, p2)
                            for p1 in new_placement[mlp][layer_idx] for p2 in prev_placement[layer_idx + 1]
                        ]
                        weight_share_cost += (
                            shared_size * overlap_factor * sum(layer_distances) /
                            max(num_mvms[mlp][layer_idx + 1], num_mvms[prev_mlp][layer_idx + 1])
                        )

            # Compute the new total cost
            new_cost = comm_cost + weight_share_cost

            # Detailed cost breakdown
            print(f"Proposed Placement for Layer {layer_to_move + 1}: {new_positions}")
            print(f"Communication Cost: {comm_cost}")
            print(f"Weight Sharing Cost: {weight_share_cost}")
            print(f"Total Cost: {new_cost}")

            # Accept or reject the new placement based on simulated annealing criteria
            if new_cost < current_cost or random.random() < np.exp((current_cost - new_cost) / temperature):
                best_placement = new_placement
                current_cost = new_cost

                if current_cost < best_cost:
                    best_cost = current_cost

            # Cool down
            temperature *= cooling_rate

            if temperature < 1e-3:  # Early stopping condition
                print(f"Temperature too low for {mlp}, stopping early.")
                break

        # Save the best placement for this MLP
        best_results[mlp] = {"placement": best_placement[mlp], "cost": best_cost}
        global_placement[mlp] = best_placement[mlp]  # Save placement for weight sharing calculations
        print(f"Completed optimization for {mlp}: Best Cost = {best_cost}")

    return best_results

def read_mlp_file(file_path):
    """
    Read MLP parameters from a file.

    Args:
        file_path: Path to the input file.

    Returns:
        mlps: List of MLP names.
        layer_sizes: Dictionary mapping MLPs to their layer sizes.
        num_mvms: Dictionary mapping MLPs to number of MVMs per layer.
    """
    with open(file_path, 'r') as file:
        lines = file.readlines()

    num_mlps = int(lines[0].strip())
    mlps = []
    layer_sizes = {}
    num_mvms = {}

    for i in range(1, num_mlps + 1):
        params = list(map(int, lines[i].strip().split()))
        num_layers = params[0]
        sizes = params[1:num_layers + 1]
        mvms = params[num_layers + 1:]

        mlp_name = f"MLP{i}"
        mlps.append(mlp_name)
        layer_sizes[mlp_name] = sizes
        num_mvms[mlp_name] = mvms

    print("Read MLP parameters:")
    print(f"Number of MLPs: {num_mlps}")
    for mlp in mlps:
        print(f"  {mlp}: Layer Sizes = {layer_sizes[mlp]}, Num MVMs = {num_mvms[mlp]}")

    return mlps, layer_sizes, num_mvms

import sys

if __name__ == "__main__":
    # Read MLP parameters from a file
    input_file = "mlp_parameters.txt"  # Replace with your file path
    mlps, layer_sizes, num_mvms = read_mlp_file(input_file)

    # Log file path
    log_file = "run_log.txt"

    # Open the log file and redirect stdout
    with open(log_file, "w") as log:
        # Redirect stdout to the log file
        sys.stdout = log

        # The rest of your script will now print to the file
        print("Validated MLP Parameters:")
        print(f"MLPs: {mlps}")
        print(f"Layer Sizes: {layer_sizes}")
        print(f"Number of MVMs: {num_mvms}")

        grid_size = (3, 3)  # Define NoC grid size
        initial_temp = 10000000
        cooling_rate = 0.99
        max_iterations = 10000

        # Run simulated annealing for independent MLP placement
        results = simulated_annealing(mlps, grid_size, layer_sizes, num_mvms, initial_temp, cooling_rate, max_iterations)

        print("\nFinal Results:")
        for mlp, result in results.items():
            placement = result["placement"]
            cost = result["cost"]
            router_mapping = [
                [position_to_router_id(pos, grid_size) for pos in layer_positions]
                for layer_positions in placement
            ]
            print(f"{mlp}: Placement = {router_mapping}, Cost = {cost}")

    # Reset stdout to its original value
    sys.stdout = sys.__stdout__

    # Print confirmation to the terminal
    print(f"Results and logs written to {log_file}")


# Debugging 

# remove cost function  
# do a simple approach 
# remove initial random placement 