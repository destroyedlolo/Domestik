The goal of this procedure is to calibrate a 1-wire humidity sensor using data from a Zigbee multi-sensor as a reference.  
We will use **Marcel** to access the values of the sensor through a **TaHoma gateway**, then store the data in the **PostgreSQL database** using **Majordome**.
Finally, a graphical comparison will be performed in **Grafana**.

# Pair the sensor with the TaHoma

The first step is to detect and pair the sensor. Please follow the pairing procedure provided in the TaHoma mobile application.

# How the sensor is exposed in the TaHoma

Follow the [TaHomaCtl installation guide](https://github.com/destroyedlolo/TaHomaCtl) to:

- Install **TaHomaCtl**.
- Enable developer mode on the TaHoma hub, ensuring you apply the bearer code.
- Discover your gateway.
