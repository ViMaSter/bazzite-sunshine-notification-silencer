# bazzite-deskflow-autostart

Starts Deskflow as a client as a system service.

> [!WARNING]
> This allows the configured server to control the machine even when it is locked or no user is logged in.


## Install

1. Install and configure Deskflow normally using flakpak. You should be able to control this client with your server.
2. Close Deskflow. Make sure this instance of Deskflow doesn't autostart on login.

3. Run these commands:
```bash
sudo mkdir -p /etc/Deskflow # create a system-available directory that will hold both binary and config
sudo cp -r ~/.config/Deskflow/* /opt/deskflow # copy the config
sudo cp /var/lib/flatpak/app/io.deskflow.Deskflow/current/active/files/bin/deskflow-core /opt/deskflow # copy the binary
```
  Whenever you need to make changes to how your Deskflow client is configured, run Deskflow as a user, make and test your changes, then copy the new configuration using the commands above.

4. Clone this repository:
```bash
git clone https://github.com/ViMaSter/deskflow-from-login.git
cd deskflow-from-login
```

5. Install the systemd service:
```bash
sudo cp "$(pwd)/deskflow-from-login.service" /etc/systemd/system/deskflow-from-login.service

sudo systemctl daemon-reload

# ensures deskflow client starts automatically after every reboot
sudo systemctl enable deskflow-from-login.service
```

6. Test without restarting: 
```bash
sudo systemctl start deskflow-from-login.service
```
  Deskflow should now be able to control the machine even when it is locked or no user is logged in.

## Troubleshooting
- If you have issues with the service, check the logs with:
```bash
sudo journalctl -u deskflow-from-login.service
```

## Uninstall

```bash
sudo systemctl disable deskflow-from-login.service
sudo rm /etc/systemd/system/deskflow-from-login.service
sudo systemctl daemon-reload

sudo rm -rf /opt/deskflow
```