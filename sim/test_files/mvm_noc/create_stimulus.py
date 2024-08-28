import random
import string

def generate_hex_values(num_columns, num_rows):
    """Generate a list of hex values with the specified number of columns and rows."""
    hex_values = []
    for _ in range(num_rows):
        row = ''.join(random.choice(string.hexdigits.upper()) for _ in range(num_columns))
        hex_values.append(row)
    return hex_values

def write_to_file(hex_values, output_file):
    """Write the list of hex values to the specified output file."""
    with open(output_file, 'w') as f:
        for line in hex_values:
            f.write(line + '\n')

def create_hex_file(num_columns, num_rows, output_file):
    """Create a .in file with hex values."""
    hex_values = generate_hex_values(num_columns, num_rows)
    write_to_file(hex_values, output_file)
    print(f"File '{output_file}' created with {num_rows} rows of {num_columns} hex digits each.")

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

    # input_vec = "test_files/mvm_noc/input_vec_test.in"
    # rf_weights = "test_files/mvm_noc/rf_weights_test.in"
    input_vec = "./input_vec_test.in"
    rf_weights = "./rf_weights_test.in"

    # Example usage
    file_specs = [
        {'num_columns': 256, 'num_rows': 1, 'output_file': input_vec},
        {'num_columns': 256, 'num_rows': 128, 'output_file': rf_weights}
    ]
    main(file_specs)
