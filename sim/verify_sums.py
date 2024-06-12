def read_input_file(file_path):
    inputs = []
    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith("Input: "):
                hex_value = line.strip().split("Input: ")[1]
                inputs.append(int(hex_value, 16))
    return inputs

def read_output_file(file_path):
    outputs = []
    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith("Sum: "):
                hex_value = line.strip().split("Sum: ")[1]
                outputs.append(int(hex_value, 16))
    return outputs

def verify_sums(input1, input2, output):
    verification_results = []
    for i, (in1, in2, out) in enumerate(zip(input1, input2, output)):
        expected_sum = in1 + in2
        if expected_sum == out:
            verification_results.append(f"SUM {i + 1}: PASS")
        else:
            verification_results.append(f"SUM {i + 1}: FAIL (expected {hex(expected_sum)}, got {hex(out)})")
    return verification_results

def main():
    input1_file = 'input1.in'
    input2_file = 'input2.in'
    output_file = 'output.out'
    
    input1 = read_input_file(input1_file)
    input2 = read_input_file(input2_file)
    output = read_output_file(output_file)
    
    if len(input1) != len(input2) or len(input1) != len(output):
        print("Error: Input and output files have different lengths.")
        return
    
    verification_results = verify_sums(input1, input2, output)
    
    for result in verification_results:
        print(result)

if __name__ == "__main__":
    main()
