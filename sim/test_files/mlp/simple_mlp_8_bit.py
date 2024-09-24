import torch
import torch.nn as nn
import torch.optim as optim

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
        x = torch.relu(x)  # Apply ReLU non-linearity to hidden layer
        x = self.output(x)
        return x

# Initialize the MLP
mlp = SimpleMLP()

# Sample input (similar to the inputs from the diagram: [1, 2, 5])
inputs = torch.tensor([1.0, 2.0, 5.0])

# Set specific weights manually
with torch.no_grad():
    mlp.hidden.weight = nn.Parameter(torch.tensor([[1.0, 1.0, 1.0], [1.0, 1.0, 1.0]]))  # input to hidden
    mlp.output.weight = nn.Parameter(torch.tensor([[1.0, 1.0]]))  # hidden to output
    mlp.hidden.bias.fill_(0)  # Optionally set biases to zero if not needed
    mlp.output.bias.fill_(0)

# Forward pass with modified weights
output = mlp(inputs)

# Convert output to int, then to hex
output_value = int(output.item())  # Convert the output to an integer (assuming the output is an integer-like value)
output_hex = hex(output_value & 0xFF)  # Convert to hex and mask with 0xFF to ensure it's 8-bit
print(f"Output with modified weights (in hex): {output_hex}")
