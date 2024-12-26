#!/bin/bash

# Update system and install Java 17
sudo yum upgrade -y
sudo dnf install java-17-amazon-corretto -y

# Verify Java installation
java -version

# Download and extract Nexus
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
ls -l
tar -xvf latest-unix.tar.gz

# Rename the extracted folder and set ownership
mv nexus-* nexus3
sudo chown -R ec2-user:ec2-user nexus3 sonatype-work

# Navigate to the Nexus binary directory
cd nexus3/bin/
ls -l

# Update the nexus.rc file to set the run user
echo "run_as_user=ec2-user" | sudo tee -a nexus.rc

# Create a symbolic link for Nexus service
sudo ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
ls -l

# Configure Nexus to start on boot and start the service
cd /etc/init.d/
ls -l
sudo chkconfig --add nexus
sudo chkconfig nexus on

# Start and check Nexus service status
sudo service nexus start
sudo service nexus status