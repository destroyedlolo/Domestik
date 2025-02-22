# Store my electricity's in Domestik's database.

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles :

### Counters

- `ConsCounterHC.topic` Consumer *Heures Creuses* counter
- `ConsCounterHP.topic` Consumer *Heures Plaines* counter
- `ProdCounter.topic` Production counter
- `Feed*Counter*.lua` Every 5 minutes, feed the database with counters' values (for the ones that changed)

### Consumer Power's

- `ConsPower.topic` Real time consumer power
- `ConsPower.minmax` Generates statistics on real time consumer power
- `DomestikAvgConsPower.topic` Topic to publish average consummer power
- `ConsPowerCollector.lua` Collect consummer power statistic every 5 minutes

### Producer Power's
- `ProdPower.topic` Real time producer power
- `ProdPower.minmax` Generates statistics on real time producer power
- `DomestikAvgProdPower.topic` Topic to publish average producer power
- `ProdPowerCollector.lua` Collect producer power statistic every 5 minutes

### Billing
- `ConsOptTarif.topic` Actual Consumer pricing contract (as of Linky standard, we got only an index to the counter to use ; anything different to 1 is considered as "*Heure Creuse*")
- `SavingCollector.lua` Calculate and feed the database with power saving
