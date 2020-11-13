#!/usr/bin/bash

config=(["64"]="Config_64" ["32"]="config_32" ["16"]="config_16")

for cores in "${!config[@]}"; do 
	echo "$cores - ${config[$cores]}";
done
