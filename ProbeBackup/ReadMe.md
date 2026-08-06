![ProbeBackup](Images/Illustration.png)

# "Quick & Dirty" Hotfix: Temporarily Replacing a Dead 1-Wire Sensor with Zigbee

This is a classic emergency workaround—call it "quick and dirty," but it gets
the job done. While waiting to fix a faulty 1-Wire temperature probe, we rolled
out a temporary continuity plan using off-the-shelf gear lying around the
workbench.

## The Issue

The main monitoring system running on my Banana Pi BPI-M1 lost its feed from
a dead 1-Wire temperature sensor due to wiring issue. In any home automation
or telemetry setup, losing a core temperature input can disrupt climate control
or logging : in our case, it's the outdoor one that controle most of the automation.

## The Workaround

To minimize downtime, a Zigbee temperature sensor was deployed as a drop-in replacement.
Here is how the data flows:
- The wireless Zigbee sensor reads ambient temperature and
transmits it to a Somfy TaHoma gateway, which acts as the Zigbee-to-IP bridge.
- The TaHoma bridge passes the telemetry data over the local network to the
Banana Pi.
- "**Marcel**" polls the TaHoma API for the latest Zigbee temperature reading.
Spoofs the original sensor: Marcel publishes the new data using the exact same
target/topic as the dead 1-Wire probe.

## The Result

Total Abstraction in Action: Thanks to the **protocol-agnostic architecture** of
the setup and Domoticz components, this hardware swap is completely transparent
to all downstream automations, scripts, and dashboards.

