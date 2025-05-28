# Simulate energy savings if we were to self-consume

Based on real-time power figures as provided by Linky smart counters. As I'm currently selling all my production :
- my 1st Linky provides the real power consumption, without needing to cheat
- my 2nd Linky provides the real production

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Database tables

`electricity_powersaving`

### Algorithm

`CalcBalance.lua` calculates the balance between the production and the consumption then publish to `ElectricityBalance`, `ElectricitySaving` and `ElectricityInjection` :

- if `ElectricityBalance` >= 0, we are producing more than our consumption
  - `ElectricitySaving` = consumption
  - `ElectricityInjection` = production - consumption
else we are producing less than our consumption
- if `ElectricityBalance` < 0, we are producing less than our consumption
  - `ElectricitySaving` = production
  - `ElectricityInjection` = 0
