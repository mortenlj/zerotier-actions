#!/usr/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # abort on pipe failures

echo "Joining network"

sudo zerotier-cli join "${NETWORK_ID}"

echo "Extracting node id"
node_id=$(sudo zerotier-cli -j info | jq -r .address)
echo "::set-output name=node-id::${node_id}"

echo "Authorizing node"

url="${API_URL}/api/v1/network/${NETWORK_ID}/member/${node_id}"

curl --oauth2-bearer "${API_ACCESSTOKEN}" \
     --header "Content-Type: application/json" \
     --header "Accept: application/json" \
     --data '{"hidden": false, "config": {"authorized": true}}' \
     --output /dev/null \
     --silent \
     --show-error \
     "${url}"
