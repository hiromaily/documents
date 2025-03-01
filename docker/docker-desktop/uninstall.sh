#!/bin/bash

echo "Starting Docker uninstallation process..."

# Uninstall Docker Desktop if it exists
if [ -e "/Applications/Docker.app" ]; then
  echo "Uninstalling Docker Desktop..."
  /Applications/Docker.app/Contents/MacOS/uninstall
  rm -rf /Applications/Docker.app
fi

# Remove Docker from system launch services
echo "Removing Docker from system launch services..."
#sudo pkill -i docker
sudo launchctl bootout system /Library/LaunchDaemons/com.docker.vmnetd.plist 2>/dev/null
sudo launchctl bootout system /Library/LaunchDaemons/com.docker.socket.plist 2>/dev/null

# Remove Docker files and directories
echo "Removing Docker files and directories..."
sudo rm -rf /Library/PrivilegedHelperTools/com.docker.socket
sudo rm -rf /Library/PrivilegedHelperTools/com.docker.vmnetd
sudo rm -rf /Library/LaunchDaemons/com.docker.vmnetd.plist
sudo rm -rf /Library/LaunchDaemons/com.docker.socket.plist
rm -rf ~/Library/Group\ Containers/group.com.docker
rm -rf ~/Library/Containers/com.docker.docker
#rm -rf ~/.docker

# Remove Docker binaries
echo "Removing Docker binaries..."
sudo rm -rf /usr/local/bin/com.docker.cli
sudo rm -rf /usr/local/bin/docker
sudo rm -rf /usr/local/bin/docker-compose
sudo rm -rf /usr/local/bin/docker-compose-v1
sudo rm -rf /usr/local/bin/docker-credential-desktop
sudo rm -rf /usr/local/bin/docker-credential-osxkeychain
sudo rm -rf /usr/local/bin/docker-index
# com.docker.cli -> /Applications/Docker.app/Contents/Resources/bin/com.docker.cli
# docker -> /Applications/Docker.app/Contents/Resources/bin/docker
# docker-compose -> /Applications/Docker.app/Contents/Resources/bin/docker-compose
# docker-compose-v1 -> /Applications/Docker.app/Contents/Resources/bin/docker-compose-v1/docker-compose
# docker-credential-desktop -> /Applications/Docker.app/Contents/Resources/bin/docker-credential-desktop
# docker-credential-osxkeychain -> /Applications/Docker.app/Contents/Resources/bin/docker-credential-osxkeychain
# docker-index -> /Applications/Docker.app/Contents/Resources/bin/docker-index

# Clear Docker cache
echo "Clearing Docker cache..."
rm -rf ~/Library/Caches/com.docker.docker

echo "Docker uninstallation complete. Please restart your computer to ensure all changes take effect."
