Automated Gerrit install using Vagrant

Automatically downloads a CentOS VM image, starts it up using VirtualBox and runs a shell script which installs and configures Gerrit
(requires x64 host machine)

Install Oracle VirtualBox for your host operating system

https://www.virtualbox.org/wiki/Downloads

Install Vagrant for your host operating system

http://downloads.vagrantup.com/

Run the example:

# Download the Vagrant and configuration files from my repository
git clone https://github.com/mattcoffey/vagrant.git

cd vagrant
# Download and startup the CentOS x64 VM and run puppet manifest
vagrant up

# Gerrit should now be running - check access to http://172.28.128.2:8080/
# Click Become (top right)
# Click New Account (bottom)
# Enter full name, register an email and click Save Changes
# Enter your local operating system username for the Administrator/Developer test account
# Copy your ssh public key to clipboard:

pbcopy < ~/.ssh/id_rsa.pub

# Paste it into Add SSH Public Key
# Click Add

# Add Verified Label to All-Projects
./addVerifiedLabel.sh

# Give Non Interactive Users to score the Verified Label
# Click Projects -> All-Projects -> Access -> Click Edit
# In the box headed "Reference: refs/heads/*" Click Add Permission and select Label Verified
# Under the new Label Verified Click Add Group select Non-Interactive Users
# Click Save Changes at the bottom

Gerrit
Log:
/home/gerrit2/gerrit/logs/error_log

Config:
/home/gerrit2/gerrit/etc/gerrit.config

Jenkins
Log:
/var/log/jenkins/jenkins.log

Config:
/etc/sysconfig/jenkins 

# Ssh into the newly started VM and see custom welcome message
vagrant ssh
