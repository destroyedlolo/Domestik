![Calibration](Images/Illustration.png)

I have two solar installations at home:

- **Rooftop solar** : Monitored directly via my grid's smart meter.
- **Ground-mounted solar** : Operated by a standalone inverter with no local
communication capabilities.

The goal of this project is to collect and store production statistics from
both systems. By analyzing this data, I aim to build a predictive model that
estimates the ground-mounted system's output based solely on the real-time
data from the rooftop installation.

# Data Collection

Since the efficiency of photovoltaic panels is directly affected by ambient temperature, the following datasets have been identified for collection and analysis :

## Rooftop Feed-in Tariff (OA) Solar Panels

### Attic Temperature

This information is provided by a 1-Wire temperature sensor installed in the attic. Measurements are recorded and transmitted every five minutes.

### Generated Power

Instantaneous production data is retrieved directly from the **production Linky meter** through its TIC (Télé-Information Client) interface : 
The **INSTI** metric is published every second by [TeleInfod](https://github.com/destroyedlolo/TeleInfod).

## Self-Consumption Solar Panels ( "AutoConso" )

### Outdoor temperature

Also monitored using a 1-Wire temperature sensor, with measurements published every five minutes.  

It should be noted that this sensor is installed in the shade and sheltered from the wind. As a result, it measures a **standardized ambient air temperature** rather than 
the temperature actually experienced by the solar panels as exposed to direct sunlight.

### Generated Power

Unfortunately, my inverter only communicates with its own proprietary cloud platform, and there is no practical way to automatically retrieve its 
data (*quite frustrating, to say the least !*).

To overcome this limitation, I built a homemade monitoring solution called **Frankenstein**, assembled from spare hardware I already had available :
- My old **CBE energy meter**
- An ESP8266 flashed with Tasmota firmware, which reads the meter and publishes the measured apparent power (**PAPP**) every second.

![Calibration](Images/Frankenstein.jpeg)

## Automation

## Result

Data were collected over several days and under a wide range of meteorological conditions, allowing for improved modeling and prediction of heat-related performance losses.

![Result](Images/result.png)

All photovoltaic panels gradually lose a small fraction of their efficiency over time, typically between 0.5% and 0.8% per year. After 16 years of operation,
the theoretical peak output of my feed-in tariff (OA) installation is therefore estimated to be between 1,650 Wp and 1,710 Wp. In addition, During heatwaves,
temperatures beneath the roof tiles can exceed 60°C and even reach 70°C, resulting in a theoretical performance loss of approximately 15% to 18%.  
The measured peak output was **1,310 W**, which is consistent with the model and therefore validates the assumptions used.  

The same conclusions apply to the self-consumption panels, which, due to their much more recent installation, are not yet affected by significant age-related degradation.
The analysis also takes into account the following factors:
- The "AutoConso" panels are ground-mounted and are occasionally affected by partial shading.
- Their orientation is slightly shifted toward the west to optimize production while mitigating these shading constraints.

