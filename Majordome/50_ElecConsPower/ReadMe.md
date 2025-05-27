# Store consumer power

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Database tables

`electricity_power`

### Counters

- `ConsPower.topic` Consumer power (VA)
- `DomestikAvgConsPower.topic` Topic to publish average consumer power

### Injectors

- `ConsPower.namedminmax` Generates statistics on real time consumer power (it's a named as electricity_power stores both consumption and production)
- `ConsPowerCollector.namefeed` Collect consumer power statistic every 5 minutes
