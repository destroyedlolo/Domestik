![Calibration](Images/Illustration.png)

Bridging TaHoma with your MQTT broker unlocks immense potential: it allows you to generate cross-referenced analytics,
leverage Majordome’s powerful automation engine, and—as we will explore here—significantly enhance your data visualization.  
We will now utilize data from a **Zigbee multi-sensor** (measuring temperature, humidity, and CO2) linked to the TaHoma to
display its figures on a **16x02 LCD** text screen — a classic, simple, and cost-effective solution widely used
in the DIY community.

# The Zigbee multi-sensor

For this setup, I am utilizing a commercial Zigbee 3.0 multi-sensor that monitors humidity, temperature, and CO2​ levels. A TaHoma gateway serves as the bridge between the Zigbee network and my MQTT broker.

## Pair the sensor with the TaHoma

The first step is to detect and pair the sensor. Please follow the pairing procedure provided in the TaHoma mobile application.

Below are the results of the discovery of my Zigbee multi-sensor, named "Test Air," as displayed within the TaHoma mobile application.

![Sensor discovered](Images/tel1.jpeg)
![Sensor detail](Images/tel2.jpeg)

## How the sensor is exposed in the TaHoma ?

### Discovering the TaHoma

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

### Discovering the probe

```
$ ./TaHomaCtl -Uv
*W* SSL chaine not enforced (unsafe mode)
TaHomaCtl > scan_Devices 
*I* 15 devices
TaHomaCtl > Device
... some other devices here ...
test_air : zigbee://2095-0445-1705/58849/1#1
test_air : zigbee://2095-0445-1705/58849/1#2
test_air : zigbee://2095-0445-1705/58849/3
test_air : zigbee://2095-0445-1705/58849/1#4
test_air : zigbee://2095-0445-1705/58849/0
test_air : zigbee://2095-0445-1705/58849/1#3
... some other devices here ...
```

As shown above, "**test_air**" is displayed as several devices, with each corresponding
to a specific sensor (and possibly more). By using the `Device` or `Status` commands,
you can explore further and retrieve the data you are looking for.  
This process can be automated by creating a temporary script as follows 

```bash
echo "scan_Devices" > /tmp/script
TaHomaCtl -U << eof | grep 'test_air : ' | awk -F' : ' '{print "Device " $2 }' >> /tmp/script
scan_Devices
Device
eof
```

> [!NOTE]
> Don't forget to change **test_air :** with the your probe's name.

Finally, run it :

```bash
TaHomaCtl -Utvf /tmp/script
```

The output will provide the known commands and states for each probe. As example

```
test_air : zigbee://2095-0445-1705/58849/1#3
	Commands
		ping (0 arg)
		advancedRefresh (1 arg)
		bind (2 args)
		stopIdentify (0 arg)
		identify (0 arg)
		unbind (2 args)
	States
		core:StatusState
		zigbee:PowerSourceState
		core:ProductModelNameState
		core:ManufacturerNameState
		zigbee:ZigbeeUpdateDownloadProgressState
		core:CO2ConcentrationState
		zigbee:LinkQualityIndicatorState
		zigbee:ZigbeeUpdateState
		core:RSSILevelState
		core:DiscreteRSSILevelState
		core:FirmwareRevisionState
```

Here, we discovered **core:CO2ConcentrationState** on **zigbee://2095-0445-1705/58849/1#3**

```
TaHomaCtl > States zigbee://2095-0445-1705/58849/1#3 core:CO2ConcentrationState
455
```

## Exposed multi-sensors figures

| ❓ What| 🔗 Device's URL | ⚙️ State | 💬 MQTT Topic |
|-----|--------------|-------|-------|
| Humidity | zigbee://2095-0445-1705/58849/1#2 | core:RelativeHumidityState | TestZigbee/RelativeHumidity |
| CO2 | zigbee://2095-0445-1705/58849/1#3 | core:CO2ConcentrationState | TestZigbee/CO2 |
| Temperature | zigbee://2095-0445-1705/58849/1#1 | core:TemperatureState | TestZigbee/Temperature |

# Configure Marcel to publish figures

Time to get that data published !  
**[Marcel](https://github.com/destroyedlolo/Marcel)** is a lightweight daemon 
designed to broadcast various metrics to our MQTT bus, including data exposed
by TaHoma. Configuration is available in the [/Marcel](Marcel) subdirectory.

![Zigbee related](Images/Zigbee.svg)

- `10_mod_TaHoma` : TaHoma module initialization.
- `30_MyTaHoma` : Configures the gateway based on TaHomaCtl discovery and defines event filters.
- `50_*`: Addresses infrequent event updates by implementing `Probes` that broadcast the last known sensor states upon startup.

> [!NOTE]
> **How Zigbee sensors Work**  
> In a typical event-driven architecture, you only receive data when a change occurs. This creates a *blind spot* when the daemon starts.
> `Probes` solve this by performing an active synchronization at launch.


