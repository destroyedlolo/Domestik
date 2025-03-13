# Store Consumption counter

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

> [!NOTE]
>  This is only an **estimation** of the photovoltaic saving based on 
> 5 minutes integration sampling, with is close to the reality.
> Smaller sampling window or even real-time doesn't worth it.

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

### Injectors

- `ElectricitySaving.namedfeed`
- `ElectricityInjection.namedfeed`
