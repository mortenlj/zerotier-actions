#!/usr/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # abort on pipe failures

echo "Deleting node"

url="${API_URL}/api/v1/network/${NETWORK_ID}/member/${NODE_ID}"

curl --oauth2-bearer "${API_ACCESSTOKEN}" \
     --output /dev/null \
     --silent \
     --show-error \
     --request DELETE \
     "${url}"

echo "Leaving network"
sudo zerotier-cli leave "${NETWORK_ID}"
