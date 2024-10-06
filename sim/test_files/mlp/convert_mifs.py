import os

# Function to convert decimal data in each file to hexadecimal format without spaces
def convert_to_hex(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            # Split the line into individual numbers (assuming they are space-separated)
            numbers = line.strip().split()
            
            # Convert each number to an 8-bit hexadecimal representation
            hex_values = [
                format((int(num) & 0xFF), '02x')  # Convert to hex and format with 2 digits
                for num in numbers
            ]
            
            # Join all hexadecimal values together without spaces and write to output
            outfile.write(''.join(hex_values) + '\n')

# Main function to delete old converted files and process all .mif files in the current directory
def convert_all_mif_files():
    current_directory = os.getcwd()

    # Delete all previously converted files
    for filename in os.listdir(current_directory):
        if filename.endswith("_converted.mif"):
            os.remove(os.path.join(current_directory, filename))
            print(f"Deleted {filename}")

    # Loop through each file in the current directory to convert
    for filename in os.listdir(current_directory):
        if filename.endswith(".mif"):
            input_file_path = os.path.join(current_directory, filename)
            output_file_path = os.path.join(current_directory, filename.replace(".mif", "_converted.mif"))
            
            # Convert the file
            convert_to_hex(input_file_path, output_file_path)
            print(f"Converted {filename} to {output_file_path}")

# Execute the main function
if __name__ == "__main__":
    convert_all_mif_files()
