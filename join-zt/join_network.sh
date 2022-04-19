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

for i in $(seq 60 -1 1); do
  if [[ $(sudo zerotier-cli -j info | jq -r .online) == "true" && $(sudo zerotierl-cli get "${NETWORK_ID}" status) == "OK" ]]; then
    ip=$(sudo zerotier-cli get "${NETWORK_ID}" ip)
    echo "ZeroTier online. You are ${node_id} on ${NETWORK_ID} with ip ${ip}."
    exit 0
  fi
  echo "Waiting for ZeroTier connection ... ($i seconds remaining)"
  sleep 1
done

exit 1