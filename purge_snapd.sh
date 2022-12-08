#!/bin/bash

# check if snapd is already installed
echo "Checking if snapd is installed"
if [ -x "$(command -v snap)" ]; then
  # stop the snapd service
echo "Stopping snapd service"
  sudo systemctl stop snapd.service

  # remove the snapd package
echo "purging snapd from system"
 sudo apt-get purge -y snapd

  # remove the snapd directories and files
echo "Purching snapd directories"
  sudo rm -rf /snap /var/snap /var/lib/snapd
  # create a file to block snapd from being installed
  echo "Blocking snapd from being installed"
touch /etc/apt/preferences.d/snapd
sudo cat <<'EOF' >> /etc/apt/preferences.d/snapd
Package: snapd
Pin: version *
Pin-Priority: -1
EOF
echo "Snapd has been purged and blocked from re-installation"
else
  echo "snapd is not installed on this system"
fi
done
