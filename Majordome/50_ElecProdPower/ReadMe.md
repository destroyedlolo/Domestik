# Store producer power

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Database tables

`electricity_power`

### Counters

- `ProdPower.topic` producer power (VA)
- `DomestikAvgProdPower.topic` Topic to publish average producer power

### Injectors

- `ProdPower.namedminmax` Generates statistics on real time producer power (it's a named as electricity_power stores both consumption and production)
- `ProdPowerCollector.namefeed` Collects producer power statistic every 5 minutes
