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
    # Use hex_to_signed_int8 to convert hexadecimal to signed integers (int8)
    input_vector = [hex_to_signed_int8(hex_data[i:i+2]) for i in range(0, len(hex_data), 2)]
    return np.array(input_vector, dtype=np.int8)

def hex_to_signed_int8(hex_str):
    """Convert a two-character hex string to a signed int8."""
    value = int(hex_str, 16)
    # If the value is greater than 127, treat it as a negative number (two's complement)
    if value > 127:
        value -= 256
    return np.int8(value)

# Modify to use hex_to_signed_int8
def read_weights_matrix_line(file):
    hex_data = file.readline().strip()
    row = [hex_to_signed_int8(hex_data[j*2:(j+1)*2]) for j in range(128)]
    return np.array(row, dtype=np.int8)


def write_output_vector(output_vector, file_path):
    with open(file_path, 'w') as file:
        hex_str = ''.join(bin_to_hex(bin(value & 0xFF)[2:].zfill(8)) for value in output_vector)
        file.write("Output Data: " + hex_str + '\n')

def relu(vector):
    """Apply ReLU activation function: replace negative values with 0."""
    return np.maximum(0, vector)

def matrix_vector_multiplication(input_vector, weights_matrix):
    # Perform signed matrix-vector multiplication
    result = np.dot(weights_matrix, input_vector)
    # Ensure values are in the signed 8-bit range (-128 to 127)
    result = np.clip(result, -128, 127)
    
    # Apply ReLU activation
    result_with_relu = relu(result)
    
    return result_with_relu

def main():
    # File paths
    input_vector_file = 'test_files/mvm_noc/input_vec.in'
    weights_matrix_file = 'test_files/mvm_noc/rf_weights.in'
    output_vector_file = 'test_files/mvm_noc/gold_output_vector_signed.out'

    # Read input data
    input_vector = read_input_vector(input_vector_file)

    # Initialize weights matrix with signed int8 type
    weights_matrix = np.zeros((128, 128), dtype=np.int8)

    # Process weights matrix line by line
    with open(weights_matrix_file, 'r') as file:
        for i in range(128):
            weight_row = read_weights_matrix_line(file)
            weights_matrix[i] = weight_row

    # Perform matrix-vector multiplication with ReLU
    output_vector = matrix_vector_multiplication(input_vector, weights_matrix)

    # Reverse the output vector to match LSB first order
    output_vector_reversed = output_vector[::-1]

    # Write output data in a single line hexadecimal format
    write_output_vector(output_vector_reversed, output_vector_file)

    # Convert the result to hexadecimal and print
    output_hex = [bin_to_hex(bin(value & 0xFF)[2:].zfill(8)) for value in output_vector_reversed]
    print(''.join(output_hex))

if __name__ == "__main__":
    main()
