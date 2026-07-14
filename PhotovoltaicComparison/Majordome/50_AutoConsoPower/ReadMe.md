# Store producer "autoconso" power

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Database tables

`electricity_power`

### Counters

- `AutoConsoPower.topic` producer power (VA)
- `DomestikAvgAutoConsoPower.topic` Topic to publish average producer power

### Injectors

- `AutoConsoPower.minmax` Generates statistics on real time producer power
- `AutoConsoPowerCollector.namefeed` Collects producer power statistic every 5 minutes
