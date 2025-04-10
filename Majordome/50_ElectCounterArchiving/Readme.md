select 
        date_trunc('hour', sample_time) as st,
        counter, figure,
        MAX(value)-MIN(value) AS val
from domestik2.electricity_counter 
where sample_time < current_date 
group by st, counter, figure
order by st desc;

