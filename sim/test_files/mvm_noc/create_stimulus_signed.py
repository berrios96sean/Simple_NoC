import random

def int_to_hex(val):
    """Convert a signed 8-bit integer to a two's complement hexadecimal representation."""
    # Convert to two's complement if negative
    if val < 0:
        val = (1 << 8) + val  # Add 256 to negative numbers to get two's complement
    return f'{val:02X}'  # Return the hex value as a 2-character string

def generate_signed_hex_values(num_columns, num_rows):
    """Generate a list of signed hex values with the specified number of columns and rows."""
    hex_values = []
    for _ in range(num_rows):
        row = ''.join(int_to_hex(random.randint(-128, 127)) for _ in range(num_columns // 2))  # Each column is 2 hex digits
        hex_values.append(row)
    return hex_values

def write_to_file(hex_values, output_file):
    """Write the list of hex values to the specified output file."""
    with open(output_file, 'w') as f:
        for line in hex_values:
            f.write(line + '\n')

def create_hex_file(num_columns, num_rows, output_file):
    """Create a .in file with signed hex values."""
    hex_values = generate_signed_hex_values(num_columns, num_rows)
    write_to_file(hex_values, output_file)
    print(f"File '{output_file}' created with {num_rows} rows of {num_columns // 2} signed 8-bit hex values each.")

def main(file_specs):
    """
    Main function to create multiple .in files.

    Parameters:
    file_specs (list of dict): List of specifications for each file. 
                               Each dict should contain 'num_columns', 'num_rows', and 'output_file' keys.
    """
    for spec in file_specs:
        num_columns = spec['num_columns']
        num_rows = spec['num_rows']
        output_file = spec['output_file']
        create_hex_file(num_columns, num_rows, output_file)

if __name__ == "__main__":
    # Input/output file names
    input_vec = "test_files/mvm_noc/input_vec_signed.in"
    rf_weights = "test_files/mvm_noc/rf_weights_signed.in"

    # Example usage
    file_specs = [
        {'num_columns': 256, 'num_rows': 1, 'output_file': input_vec},   # 256 hex digits (128 bytes)
        {'num_columns': 256, 'num_rows': 128, 'output_file': rf_weights} # 128 rows of 256 hex digits each (128 bytes per row)
    ]
    main(file_specs)
