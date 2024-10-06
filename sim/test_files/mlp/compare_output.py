def compare_first_line(file1, file2, output_file):
    """Compare the first lines of two files ignoring case and write the result to an output file."""
    try:
        with open(file1, 'r') as f1, open(file2, 'r') as f2:
            first_line_f1 = f1.readline().strip().lower()
            first_line_f2 = f2.readline().strip().lower()

            if first_line_f1 == first_line_f2:
                result = "pass"
            else:
                result = "fail"

        with open(output_file, 'w') as out_f:
            out_f.write(result)
            print(f"Comparison result written to '{output_file}': {result}")

    except FileNotFoundError as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    file1 = "output.out"
    file2 = "golden_outputs_converted.mif"
    output_file = "results.txt"

    compare_first_line(file1, file2, output_file)
