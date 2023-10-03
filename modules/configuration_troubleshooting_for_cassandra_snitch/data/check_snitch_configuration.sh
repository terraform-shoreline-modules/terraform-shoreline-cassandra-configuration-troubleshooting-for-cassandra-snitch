

#!/bin/bash



# Set variables

SNITCH_CONFIG=${PATH_TO_SNITCH_CONFIG}



# Check if snitch configuration file exists

if [ ! -f "$SNITCH_CONFIG" ]; then

  echo "ERROR: Snitch configuration file not found at $SNITCH_CONFIG"

  exit 1

fi



# Check if snitch configuration is valid

if ! grep -q "endpoint_snitch" "$SNITCH_CONFIG"; then

  echo "ERROR: endpoint_snitch configuration not found in $SNITCH_CONFIG"

  exit 1

fi



# Check if snitch configuration is current

CURRENT_SNITCH=$(nodetool getendpoints system.local | awk '{print $NF}')

CONFIGURED_SNITCH=$(grep endpoint_snitch "$SNITCH_CONFIG" | awk '{print $NF}' | tr -d "'")

if [ "$CURRENT_SNITCH" != "$CONFIGURED_SNITCH" ]; then

  echo "ERROR: Current snitch ($CURRENT_SNITCH) does not match configured snitch ($CONFIGURED_SNITCH)"

  exit 1

fi



echo "Snitch configuration is correct"

exit 0