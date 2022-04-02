#!/usr/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # abort on pipe failures

echo "Downloading ZeroTier install script"
installer="$(mktemp -t zerotier-installer.XXXXX)"
curl --output "${installer}" --silent https://install.zerotier.com

echo "Executing installer"
chmod +x "${installer}"

sudo bash "${installer}"
