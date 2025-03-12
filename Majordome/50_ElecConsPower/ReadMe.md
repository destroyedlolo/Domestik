# Store consumer power

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Counters

- `ConsPower.topic` power consumer (VA)
- `DomestikAvgConsPower.topic` Topic to publish average consumer power

### Injectors

- `ConsPower.minmax` Generates statistics on real time consumer power
- `ConsPowerCollector.namefeed` Collect consumer power statistic every 5 minutes
