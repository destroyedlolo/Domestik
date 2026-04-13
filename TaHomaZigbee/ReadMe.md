The goal of this procedure is to calibrate a 1-wire humidity sensor using data from a Zigbee multi-sensor as a reference.  
We will use **Marcel** to access the values of the sensor through a **TaHoma gateway**, then store the data in the **PostgreSQL database** using **Majordome**.
Finally, a graphical comparison will be performed in **Grafana**.

# Pair the sensor with the TaHoma

The first step is to detect and pair the sensor. Please follow the pairing procedure provided in the TaHoma mobile application.

Below are the results of the discovery of my Zigbee multi-sensor, named "Test Air," as displayed within the TaHoma mobile application.
![Sensor discovered](Images/tel1.jpeg)
![Sensor detail](Images/tel2.jpeg)

# How the sensor is exposed in the TaHoma

## Discovering the TaHoma

Follow the [TaHomaCtl installation guide](https://github.com/destroyedlolo/TaHomaCtl) to:

- Enable the **developer mode** in your TaHoma (and get the **bearer code**) 
- Install **TaHomaCtl**.
- Enable developer mode on the TaHoma hub, ensuring you apply the bearer code.
- Discover your gateway.

> [!TIP]
> Instead of hardcoding the bearer token directly into the configuration, store it in a file and
> use `TaHoma_token @/path/to/file` to load it into TaHomaCtl.
> This file will then be reused accordingly in Marcel.
>
> In my case it will be stored in `/home/laurent/.tahomatoken`


## Discovering the probe

```
$ ./TaHomaCtl -Uv
*W* SSL chaine not enforced (unsafe mode)
TaHomaCtl > scan_Devices 
*I* 15 devices
TaHomaCtl > Device
test_air : zigbee://xxxx-xxxx-xxxx/58849/1#1
test_air : zigbee://xxxx-xxxx-xxxx/58849/1#2
test_air : zigbee://xxxx-xxxx-xxxx/58849/3
test_air : zigbee://xxxx-xxxx-xxxx/58849/1#4
Deco : io://xxxx-xxxx-xxxx/5335270
Porte_Chat : rts://xxxx-xxxx-xxxx/16774417
IO_(10069463) : io://xxxx-xxxx-xxxx/10069463
test_air : zigbee://xxxx-xxxx-xxxx/58849/0
ZIGBEE_(0/0) : zigbee://xxxx-xxxx-xxxx/0/0
Boiboite : internal://xxxx-xxxx-xxxx/pod/0
INTERNAL_(wifi/0) : internal://xxxx-xxxx-xxxx/wifi/0
test_air : zigbee://xxxx-xxxx-xxxx/58849/1#3
ZIGBEE_(0/242) : zigbee://xxxx-xxxx-xxxx/0/242
ZIGBEE_(0/1) : zigbee://xxxx-xxxx-xxxx/0/1
ZIGBEE_(65535) : zigbee://xxxx-xxxx-xxxx/65535
```

As shown above, "test_air" is displayed as several devices, with each corresponding
to a specific sensor (and possibly more). By using the 'Device' or 'Status' commands,
you can explore further and retrieve the data you are looking for.

# Configure Marcel to retrieve the probe's figures

# Create database dedicated tables

# Configure Majordome to feed the database

# Get the result in Grafana
