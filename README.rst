zerotier-actions
================

Github actions to use ZeroTier on runner

This repository contains two actions:

1. Join ZeroTier
   Installs zerotier-one on the runner, and joins a zerotier network as an authenticated node
2. Cleanup
   Leaves all networks, and removes any mention of the node

Typical use would be if you need your workflow to connect to a test-environment, or your deploy step needs
network access to a cluster that is not normally exposed on the internet.

Use ZeroTier to expose these endpoints in a secure manner, and use these actions in your workflow to connect.

Usage
-----

TBD
