Store my electricity's in Domestik's database.

> [!NOTE]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky.

# Principles :

## Counters

- `ConsCounterHC.topic` Consumer *Heures Creuses* counter
- `ConsCounterHP.topic` Consumer *Heures Plaines* counter
- `ProdCounter.topic` Production counter
- `Feed*Counter*.lua` Every 5 minutes, feed the database with counters' values (for the ones that changed)

## Power's

- `ConsPower.topic` Real time consumer power
- `ProdPower.topic` Real time producer power

- `ConsOptTarif.topic` Actual Consumer pricing contract

- the Linky sent every seconds the power in VA
- we take the average 5 minutes
- So Sum (VA/5m) / 12 = VAh 
