# Store my electricity's in Domestik's database.

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles :

### Counters
#### Consummer
- `ConsCounterHC.topic` Consumer *Heures Creuses* counter
- `ConsCounterHP.topic` Consumer *Heures Plaines* counter

#### Producer
- `ProdCounter.topic` Production counter
- `ProdCounter.lua` Every 5 minutes, feed the database if the counters changed. As we need to insert 2 keys, we need to run the SQL query ourself.

### Consumer Power's

- `ConsPower.topic` Real time consumer power
- `ConsPower.minmax` Generates statistics on real time consumer power
- `DomestikAvgConsPower.topic` Topic to publish average consummer power
- `ConsPowerCollector.namefeed` Collect consummer power statistic every 5 minutes

### Producer Power's
- `ProdPower.topic` Real time producer power
- `ProdPower.minmax` Generates statistics on real time producer power
- `DomestikAvgProdPower.topic` Topic to publish average producer power
- `ProdPowerCollector.namefeed` Collect producer power statistic every 5 minutes

### Billing
#### Storage
- `electricity_powersaving` VA produced by the photovoltaic
  - `Saving` how many VA saved by the photovoltaic
  - `Injection` production not consumed, re-injected to the network, surplus.
- `electricity_billing` how many € were saved
  - `Saving` cost saved by the *self production*
  - `Injection` billing to the energy producer

#### Objects
##### Balance
- `ElectricityBalance.topic`
- `CalcBalance.lua` publishes balance between consumption and production

- `ConsOptTarif.topic` Actual Consumer pricing contract (as of Linky standard, we got only an index to the counter to use ; anything different to 1 is considered as "*Heure Creuse*")

- `ProdSaving.topic' how many VA saved by the photovoltaic
- `ProdInjection.topic` production not consumed, re-injected to the network, surplus
- `ProdSaving.namedfeed` feed the database with production saving
  
- `SavingCollector.lua` Calculate and feed the database with power saving
