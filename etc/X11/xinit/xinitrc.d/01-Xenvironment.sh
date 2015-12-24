#!/bin/bash

# inhibit changing to $HOME in /etc/profile
export CHERE_INVOKING=true
# inhibit starting ssh-agent too
export SSH_AGENT_PID="-1"
