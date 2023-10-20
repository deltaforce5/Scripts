## Raspberry PI Fan Control

Adjust variables in fan_ctrl.py, then:

```
sudo apt install python3-rpi.gpio
sudo cp fan_ctrl.py /usr/sbin/
sudo cp fanctrl.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable fanctrl.service
sudo systemctl start fanctrl.service
```
