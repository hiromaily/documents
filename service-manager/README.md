## Service manager

[systemd](https://en.wikipedia.org/wiki/Systemd)
Systemd (stylized as systemd) is a software suite that provides fundamental building blocks for a Linux operating syste. Among other features, it includes the systemd "System and [Service Manager](https://en.wikipedia.org/wiki/Operating_system_service_management)", an init system used to bootstrap the user space and to manage system processes after booting.

[Difference between systemctl init.d and service](https://askubuntu.com/questions/911525/difference-between-systemctl-init-d-and-service)

```
sudo /etc/init.d/apache2 status
sudo systemctl status apache2.service
sudo service apache2 status
```

1. `sudo systemctl status apache2.service`  
   This is the new SystemD approach to handling services. Moving forward, applications on Linux are designed to uses the systemd method, not any other. So this command is recommended.

2. `sudo /etc/init.d/apache2 status`  
   This is the original SysVInit method of calling on a service. Init scripts would be written for a service and placed into this directory. While this method is still used by many, service was the command that replaced this method of calling on services in SysVInit. There's some legacy functionality for this on newer systems with SystemD, but most newer programs don't include this, and not all older application init scripts work with it.

3. `sudo service apache2 status`
   This was the primary tool used on SysVInit systems for services. In some cases it just linked to the /etc/init.d/ scripts, but in other cases it went to an init script stored elsewhere. It was intended to provide a smoother transition into service dependency handling.

`systemctl` is newer than `init.d` and `systemctl` is the new SystemD approach to handling services.

## .profile, .bashrc etc

1. `/etc/profile`  
   This file is applied for all users

- something which should be set only once when login

2. `~/.bash_profile`  
   If this file is exsiting, is loaded

- environmental variable should be set here(or .profile), not .bashrc

3. `~/.bash_login`  
   After login, this file will be loaded as long as .bash_profile is not exsiting

4. `~/.profile`  
   After login, this file will be loaded as long as .bash_profile and .bash_login are not exsiting

5. `~/.bashrc`  
   After login by shell, this file is loaded each time

- something which requires to be set anytime after login by bash

6. `~/.bash_logout`  
   After logout by shell, this file is loaded each time
