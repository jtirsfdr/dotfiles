#!/bin/bash
chmod +x ./commands.sh
sudo ./commands.sh $USER 2>&1 | tee full_log
chmod -x ./commands.sh
#make work with rm zsh alias
#rm ./log
#rm ./full_log
