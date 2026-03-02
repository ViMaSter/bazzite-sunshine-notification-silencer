# bazzite-deskflow-autostart

Starts Deskflow as a client as a system service.

> [!WARNING]
> This allows the configured server to control the machine even when it is locked or no user is logged in.


## Install

Install and configure Deskflow normally using flakpak. You should be able to control this client with your server.
Close Deskflow. Make sure this instance of Deskflow doesn't autostart on login.

Run these commands:
```bash
sudo mkdir -p /etc/Deskflow
sudo cp -r ~/.config/Deskflow/* /etc/Deskflow
```

Whenever you need to make changes to how your Deskflow client is configured, run Deskflow as a user, make and test your changes, then copy the new configuration using the commands above.

Clone this repository:
```bash
git clone https://github.com/ViMaSter/deskflow-from-login.git
cd deskflow-from-login
```

Change `ExecStart` in `deskflow-from-login.service` to point to the `deskflow-core` binary in your system. If you installed Deskflow using flatpak, the path should be `/var/lib/flatpak/app/io.deskflow.Deskflow/current/active/files/bin/deskflow-core`

```bash
chmod +x deskflow-from-login.sh

sudo cp "$(pwd)/deskflow-from-login.service" /etc/systemd/system/deskflow-from-login.service

sudo chcon -t bin_t $PATH_TO_DESKFLOW$/deskflow-core

sudo systemctl daemon-reload

# ensures deskflow client starts automatically after every reboot
sudo systemctl enable deskflow-from-login.service

# start the service immediately; you should be able to control this client with your server now, even if no user is logged in or the machine is locked
sudo systemctl start deskflow-from-login.service
```

## Uninstall

```bash
sudo systemctl disable deskflow-from-login.service

sudo rm /etc/systemd/system/deskflow-from-login.service

sudo systemctl daemon-reload

# (Optional) Remove the cloned repo
# rm -rf /path/to/deskflow-from-login
```