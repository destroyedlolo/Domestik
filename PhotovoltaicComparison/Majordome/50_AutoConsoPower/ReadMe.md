# Store producer "autoconso" power

> [!WARNING]  
> Use this code only as example.<br>
> You have to modify and customize it as per your needs : 
> here, it's relying on data provided by French Linky meter.

## Principles

### Database tables

`electricity_power`

### Counters

- `AutoConsoPower.topic` AutoConso power (VA)
- `DomestikAvgAutoConsoPower.topic` Topic to publish average AutoConso power

### Injectors

- `AutoConsoPower.minmax` Generates statistics on real time AutoConso power
- `AutoConsoPowerCollector.namefeed` Collects AutoConso power statistic every 5 minutes
