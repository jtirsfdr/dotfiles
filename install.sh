chmod +x ./commands.sh
sudo ./commands.sh $USER 2>&1 | tee full_log
chmod -x ./commands.sh
trash-put ./log
trash-put ./full_log
