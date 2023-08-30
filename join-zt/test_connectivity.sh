#!/usr/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # abort on pipe failures

if [[ -n "${PING_TARGET}" ]]; then
  echo "Testing connection to ZeroTier network, by pinging ${PING_TARGET}"

  for i in $(seq 10 -1 1); do
    if ping -q -c 1 -W 5 "${PING_TARGET}"; then

      echo "${PING_TARGET} is online and reachable."
      exit 0
    fi
    echo "Waiting for ZeroTier connection ... ($i attempts remaining)"
  done

  exit 1
fi
