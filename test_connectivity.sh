#!/usr/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # abort on pipe failures

echo "Testing connection to ZeroTier network, by pinging a connected host"
ping -c 5 emrys.home.zt.ibidem.no
