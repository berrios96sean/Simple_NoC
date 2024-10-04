import torch
import torch.nn as nn

# Helper function to convert a single hexadecimal string to a signed float
def hex_to_signed_float(hex_str):
    value = int(hex_str, 16)  # Convert hex to integer
    if value >= 0x80:  # If the value is greater than or equal to 128, it is negative in two's complement for 8-bit
        value -= 0x100  # Convert to signed 8-bit value
    return float(value)

# Helper function to read weights from a file and convert them
def read_weights_from_file(file_path):
    weights = []
    with open(file_path, 'r') as f:
        for line in f:
            # Split the line into hexadecimal values and convert each to float
            weight_row = [hex_to_signed_float(val) for val in line.strip().split()]
            weights.append(weight_row)
    return weights

# File paths
input_file = 'input_mifs/inputs_mvm0.mif'
hidden_weights_file = 'weight_mifs/layer0_mvm0.mif'
output_weights_file = 'weight_mifs/layer1_mvm0.mif'

# Read the weights from files
input_values = read_weights_from_file(input_file)[0][:3]  # Get the first three values from the first line
print(input_values)
# Read the first two lines from the hidden weights file and get the first three values from each line
hidden_weights = [line[:3] for line in read_weights_from_file(hidden_weights_file)[:2]]  # Get the first two lines and only the first three values of each
print(hidden_weights)
output_weights = read_weights_from_file(output_weights_file)[0][:2]  # Get the first line and only the first two values
print(output_weights)

# Define a simple MLP class
class SimpleMLP(nn.Module):
    def __init__(self):
        super(SimpleMLP, self).__init__()
        # Define layers: 3 inputs -> 2 hidden units -> 1 output
        self.hidden = nn.Linear(3, 2)  # 3 inputs to 2 hidden units
        self.output = nn.Linear(2, 1)  # 2 hidden units to 1 output

    def forward(self, x):
        # Forward pass through the network
        x = self.hidden(x)
        #x = torch.relu(x)
        x = self.output(x)
        return x

# Instantiate the MLP model
mlp = SimpleMLP()

# Convert input and weights to torch tensors
input_tensor = torch.tensor(input_values, dtype=torch.float).view(1, -1)  # Ensure input is of shape (batch_size, 3)
hidden_weights_tensor = torch.tensor(hidden_weights, dtype=torch.float)  # Should have shape (2, 3)
output_weights_tensor = torch.tensor(output_weights, dtype=torch.float).view(1, -1)  # Should have shape (1, 2)

# Set specific weights manually
with torch.no_grad():
    mlp.hidden.weight.copy_(hidden_weights_tensor)
    mlp.output.weight.copy_(output_weights_tensor)
    mlp.hidden.bias.fill_(0)
    mlp.output.bias.fill_(0)

# Forward pass with modified weights
output = mlp(input_tensor)

# Convert output to int, then to hex
output_value = int(round(output.item()))  # Round the floating-point output to the nearest integer
output_hex = hex(output_value & 0xFF)  # Convert to 8-bit hex representation
print(f"Output with modified weights (in dec): {output_value}")
