#!/usr/bin/env bash

# Simple test file for the basic cyberdream theme
cat > /tmp/basic_test.py << 'EOF'
#!/usr/bin/env python3

# This comment should be PURPLE text on GREEN background
# Testing the basic cyberdream setup

def hello_world():
    """Simple function to test syntax highlighting"""
    # Another comment - should be purple on green
    message = "Hello, Space Age!"  # Inline comment
    print(message)
    
    # More comments for testing
    numbers = [1, 2, 3, 4, 5]
    for num in numbers:  # Comment in loop
        print(f"Number: {num}")  # Print each number

if __name__ == "__main__":
    hello_world()  # Run the function
EOF

echo "🧪 Basic theme test created!"
echo "Testing basic cyberdream functionality..."
echo ""
echo "To test:"
echo "1. Run: nix run . /tmp/basic_test.py"
echo "2. Check if:"
echo "   - Comments are PURPLE text on GREEN background"
echo "   - Theme loads without UIEnter errors"
echo "   - Basic cyberdream colors are working"
echo "   - No Scratch panel errors"
echo ""
echo "If this works, we'll gradually add space-age features!"