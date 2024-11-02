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

### Todo
- `ConsOptTarif.topic` Actual Consumer pricing contract


listen les 2 topics
require_topic sur les 2 topics
A la fin, les mettre à NIL pour les invalidées.

- the Linky sent every seconds the power in VA
- we take the average 5 minutes
- So Sum (VA/5m) / 12 = VAh 
