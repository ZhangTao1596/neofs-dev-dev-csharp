#!/bin/bash

echo "start neo-cli"
cd /neo-cli
screen -dmS neo-cli dotnet neo-cli.dll

echo "deploy contracts"
cd /
export TERM='screen'
expect deploy.expect
