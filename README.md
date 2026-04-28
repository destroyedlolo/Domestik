![Domestik's Logo](Images/Domestik.png)

**Domestik** is a complete suite for **smart home automation and data collection**.  
It consists of a collection of independent, lightweight, and agnostic daemons
(meaning any of them can be replaced by another tool, as long as they communicate via MQTT) that interact through an MQTT bus.
The key components of the suite include:

- **[Marcel](https://github.com/destroyedlolo/Marcel)** : Handles low-level communication
- **[Majordome](https://github.com/destroyedlolo/Majordome)** :
    - Manages automation processes
    - Oversees data lifecycle management
    - Facilitates dashboard creation
- additional standandalone **data sources** like [TeleInfod](https://github.com/destroyedlolo/TeleInfod) or ESP32/ESP8266 probes
- **Database** (PostgreSQL): Used to store and historize data
- **Web-based dashboard** (Grafana): Provides visualization of the collected data

# Targeted hardware

This project is optimized for **low-resource environments**. You don't need a powerful PC; it’s designed to run perfectly
on **budget-friendly Single Board Computers** (SBCs).

Our Test Bench:
- **Device**: Banana Pi M1
- **Processor**: Allwinner A20 (Dual-core ARMv7)
- **Memory**: 1GB RAM
- **Storage**: Native SATA (as you know, hosting a database on a SD cart lead to problems)

# Use-Cases

| Where | What | Keywords | Domestik's components |
|-------|------|----------|-----------------------|
| [DisplayZigbeeData/](./DisplayZigbeeData/) | Display measurements from a Zigbee sensor on an inexpensive character LCD display | **TaHoma**, **ZigBee**, **I2C LCD** | [Marcel](https://github.com/destroyedlolo/Marcel), [Majordome](https://github.com/destroyedlolo/Majordome) |
