lang en_US.UTF-8
keyboard us
timezone UTC
zerombr
clearpart --all --initlabel
autopart --type=plain --fstype=xfs --nohome
reboot
text
network --bootproto=dhcp --device=link --activate --onboot=on

ostreesetup --nogpg --osname=rhel-edge --remote=rhel-edge --url=file:///ostree/repo --ref=rhel/8/x86_64/edge

%post --log=/var/log/anaconda/post-install.log --erroronfail
# add user admin and ssh key
useradd -m -d /home/admin -G wheel admin
mkdir -p /home/admin/.ssh
chmod 755 /home/admin/.ssh
tee /home/admin/.ssh/authorized_keys > /dev/null << STOPHERE
[REPLACESSH]
STOPHERE
chmod 600 /home/admin/.ssh/authorized_keys
chown admin:admin /home/admin/.ssh/authorized_keys
# no sudo password for user admin
echo -e 'admin\tALL=(ALL)\tNOPASSWD: ALL' >> /etc/sudoers

%end

%post --log=/var/log/anaconda/insights-on-reboot-unit-install.log --interpreter=/usr/bin/bash --erroronfail
INSIGHTS_CLIENT_OVERRIDE_DIR=/etc/systemd/system/insights-client.service.d
INSIGHTS_CLIENT_OVERRIDE_FILE=$INSIGHTS_CLIENT_OVERRIDE_DIR/override.conf

if [ ! -f $INSIGHTS_CLIENT_OVERRIDE_FILE ]; then
    mkdir -p $INSIGHTS_CLIENT_OVERRIDE_DIR
    cat > $INSIGHTS_CLIENT_OVERRIDE_FILE << EOF 
[Unit]
Requisite=greenboot-healthcheck.service
After=network-online.target greenboot-healthcheck.service

[Install]
WantedBy=multi-user.target
EOF

    systemctl enable insights-client.service
fi

%end
