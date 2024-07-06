import numpy as np

def hex_to_bin(hex_str):
    """Convert a hex string to a binary string."""
    return bin(int(hex_str, 16))[2:].zfill(8)

def bin_to_hex(bin_str):
    """Convert a binary string to a hex string."""
    return hex(int(bin_str, 2))[2:].upper().zfill(2)

def read_input_vector(file_path):
    with open(file_path, 'r') as file:
        hex_data = file.readline().strip()
    # Convert hexadecimal string to integers
    input_vector = [int(hex_data[i:i+2], 16) for i in range(0, len(hex_data), 2)]
    return np.array(input_vector, dtype=np.uint8)

def read_weights_matrix_line(file):
    hex_data = file.readline().strip()
    row = [int(hex_data[j*2:(j+1)*2], 16) for j in range(64)]
    return np.array(row, dtype=np.uint8)

def write_output_vector(output_vector, file_path):
    with open(file_path, 'w') as file:
        hex_str = ''.join(bin_to_hex(bin(value)[2:].zfill(8)) for value in output_vector)
        file.write("Output Data: " + hex_str + '\n')

def matrix_vector_multiplication(input_vector, weights_matrix):
    result = np.dot(weights_matrix, input_vector)
    result = np.mod(result, 256)  # Ensure values are within 8-bit range
    return result

def main():
    # File paths
    input_vector_file = 'input_vec.in'
    weights_matrix_file = 'rf_weights.in'
    output_vector_file = 'gold_output_vector.out'

    # Read input data
    input_vector = read_input_vector(input_vector_file)

    # Initialize weights matrix
    weights_matrix = np.zeros((64, 64), dtype=np.uint8)

    # Process weights matrix line by line
    with open(weights_matrix_file, 'r') as file:
        for i in range(64):
            weight_row = read_weights_matrix_line(file)
            weights_matrix[i] = weight_row

    # Perform matrix-vector multiplication
    output_vector = matrix_vector_multiplication(input_vector, weights_matrix)

    # Reverse the output vector to match LSB first order
    output_vector_reversed = output_vector[::-1]

    # Write output data in a single line hexadecimal format
    write_output_vector(output_vector_reversed, output_vector_file)

    # Convert the result to hexadecimal and print
    output_hex = [bin_to_hex(bin(value)[2:].zfill(8)) for value in output_vector_reversed]
    print(''.join(output_hex))

if __name__ == "__main__":
    main()
