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


# Configure Marcel to retrieve the probe's figures

# Create database dedicated tables

# Configure Majordome to feed the database

# Get the result in Grafana
