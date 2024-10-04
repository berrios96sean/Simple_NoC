import torch
import sys
import torch.nn as nn

num_inputs = int(sys.argv[1])
hid_inputs = int(sys.argv[2])
num_outputs = int(sys.argv[3])
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
            # Split the line into decimal values and convert each to float
            weight_row = [float(val) for val in line.strip().split()]
            weights.append(weight_row)
    return weights

# File paths
input_file = 'input_mifs/inputs_mvm0.mif'
hidden_weights_file = 'weight_mifs/layer0_mvm0.mif'
output_weights_file = 'weight_mifs/layer1_mvm0.mif'
golden_output_file = 'golden_outputs.mif'

# Read the weights from files
input_values = read_weights_from_file(input_file)[0][:num_inputs]  # Get the first 'num_inputs' values from the first line
print(input_values)

# Read the hidden weights, ensuring it has the correct shape
hidden_weights = [line[:num_inputs] for line in read_weights_from_file(hidden_weights_file)[:hid_inputs]]  # Get the first 'hid_inputs' lines and 'num_inputs' values from each line
print(hidden_weights)

# Read output weights and ensure correct number of values
output_weights = [val for line in read_weights_from_file(output_weights_file)[:num_outputs] for val in line[:hid_inputs]]  # Flatten the first 'num_outputs' lines and get 'hid_inputs' values from each line
print(output_weights)

gold_values = read_weights_from_file(golden_output_file)[0][:num_outputs]

# Define a simple MLP class
class SimpleMLP(nn.Module):
    def __init__(self, num_inputs, hid_inputs, num_outputs):
        super(SimpleMLP, self).__init__()
        # Define layers: 3 inputs -> 2 hidden units -> 1 output
        self.hidden = nn.Linear(num_inputs, hid_inputs)  # 3 inputs to 2 hidden units
        self.output = nn.Linear(hid_inputs, num_outputs)  # 2 hidden units to 1 output

    def forward(self, x):
        # Forward pass through the network
        x = self.hidden(x)
        #x = torch.relu(x)
        x = self.output(x)
        return x

# Instantiate the MLP model with different layer sizes
mlp = SimpleMLP(num_inputs=num_inputs, hid_inputs=hid_inputs, num_outputs=num_outputs)


# Convert input and weights to torch tensors
# Convert input and weights to torch tensors
input_tensor = torch.tensor(input_values, dtype=torch.float).view(1, num_inputs)  # Ensure input is of shape (batch_size, num_inputs)

# Ensure hidden_weights has shape (hid_inputs, num_inputs)
hidden_weights_tensor = torch.tensor(hidden_weights, dtype=torch.float).view(hid_inputs, num_inputs)

# Ensure output_weights has shape (num_outputs, hid_inputs)
output_weights_tensor = torch.tensor(output_weights, dtype=torch.float).view(num_outputs, hid_inputs)

# Set specific weights manually
with torch.no_grad():
    mlp.hidden.weight.copy_(hidden_weights_tensor)
    mlp.output.weight.copy_(output_weights_tensor)
    mlp.hidden.bias.fill_(0)
    mlp.output.bias.fill_(0)

# Forward pass with modified weights
# Forward pass with modified weights
output = mlp(input_tensor)

# Convert each output value to int, then to 8-bit signed hex
output_values = output.squeeze().tolist()  # Remove batch dimension and convert to list

# If there's only one output, convert to a single value instead of a list
if isinstance(output_values, float) or isinstance(output_values, int):
    output_values = [output_values]

# Convert each output value to an 8-bit signed integer and then to hex
output_hex_values = []
int_value_list = []
print(output_values)
# Convert to 8-bit signed values
signed_8bit_values = []

for value in output_values:
    # Round the value to nearest integer
    int_value = int(round(value))
    
    # Convert to signed 8-bit integer (-128 to 127)
    int_value = int_value % 256  # Wrap within 0-255 range
    if int_value >= 128:
        int_value -= 256  # Convert to two's complement for signed values
    
    signed_8bit_values.append(int_value)

# print('printing signed conversion')
# print(signed_8bit_values)
# print()

# print(signed_8bit_values)
for value in output_values:
    int_value = int(round(value))
    # Convert values that are out of the signed 8-bit range
    if int_value > 127:
        int_value -= 256  # Convert to negative two's complement if value > 127
    elif int_value < -128:
        int_value += 256 # Clamp to the minimum value for an 8-bit signed integer

    int_value_list.append(int_value)
    output_hex_values.append(hex(int_value))

# Print output values based on number of outputs
print('---------------------------------------------------------------------------')
print('output values: ')
if num_outputs == 1:
    print(f"Output (in dec): {signed_8bit_values[0]}, (in hex): {output_hex_values[0]}")
else:
    print(f"Outputs (in dec): {signed_8bit_values}")
    # print(f"Outputs (in hex): {output_hex_values}")

# Convert gold_values from hex to signed integers
# gold_values = [gold_values]  # Ensure gold values are integers

# # Ensure the gold values are in the signed 8-bit range (-128 to 127)
# gold_signed_values = []
# for value in gold_values:
#     if value > 127:
#         value -= 256
#     elif value < -128:
#         value = -128  # Clamp if out of range
#     gold_signed_values.append(value)

# Convert gold_values and int_value_list to float for comparison
gold_values_float = [float(val) for val in gold_values]
int_value_list_float = [float(val) for val in int_value_list]
print('---------------------------------------------------------------------------')

# Compare gold_values with int_value_list
if gold_values_float == signed_8bit_values:
    print('pass')
else:
    print('fail')
    print(f"Expected: {gold_values_float}")
    print(f"Got: {int_value_list_float}")

