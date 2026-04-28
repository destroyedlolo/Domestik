![Header](Images/Illustration.png)

This use case demonstrates how to efficiently manage the entire data lifecycle with minimal effort using [Majordom](../../../Majordome/).  
It covers the ingestion of measurements from a 1‑Wire multi‑sensor probe, their storage in a database, progressive transformation based on data
maturity, and the eventual cleanup of outdated data.

# A little talk about data maturity : From Raw Sensors to Golden Insights

## Storage

> [!Note]
> While a dedicated TSDB (like InfluxDB) is often preferred for time-series data, I opted for **PostgreSQL**.
> It provides robust performance for my current home automation scale and avoids the overhead of managing multiple database engines.

## Data maturity

In a modern data architecture, the primary goal is to transition from "**noise**" to "**value**". For environmental monitoring—such as tracking
temperature and humidity, this process ensures that a database does more than just archive raw numbers; it provides reliable, high-integrity information.  
When targeting low-profile SBCs (Single Board Computers), implementing an optimized Data Mart is not merely a "best practice"—it is a technical obligation :
Operating within the constraints of limited CPU, RAM, and storage requires a conservative data strategy.

While the example here focuses on environmental sensors, this framework is universal and can be applied to any data stream to ensure scalability and long-term stability.

> [!TIP]
> While the **BananaPi** provides native SATA support—effectively bypassing the high failure rates of SDCards and enabling high-capacity storage,
> this hardware advantage does not justify inefficient data management.  
> Optimizing our storage remains a priority for one critical reason: **Backups** (You are planning a backup strategy, aren't you?).
>
> By maintaining a lean, well-structured database, we ensure that backups are not only faster to execute but also significantly easier to
>  transport, verify, and restore. In the world of data, "*smaller*" translates directly to "*more resilient*".

### Raw Data (The Landing Zone) : The Bronze Layer

This is the entry point for raw sensor telemetry. In the Domestik ecosystem, we do not persist raw data to the database; doing so would be a needless waste of resources.
Instead, data is intercepted and handled in real-time by Marcel, ensuring the system remains lean from the very first byte.

### The Silver Layer: Cleansed & Standardized (The Quality Zone)

At this stage, data is validated and refined. For example, a 1-Wire reading of `85°C` (a classic sign of power failure) is rejected.
Calibration offsets are applied here to ensure accuracy.

> [!Note]
> **Technical Implementation:** Marcel performs this sanitization via Lua user functions and publishes the "Silver Data" to the MQTT bus.
> A Majordome flow then consumes this trustworthy stream for database storage.

### The Gold Layer: Aggregated & Optimized (The Value Zone)

The Gold layer represents the final stage of maturity. It represents the "truth" for the end-user. 
By removing redundant data points and calculating meaningful aggregates (averages, hourly/daily trends), we transform raw points into actionable insights.
This layer is what powers dashboards and long-term history, optimized for speed and minimal storage footprint.

> [!Note]
> **Technical Implementation:** Unlike other solutions that perform transformations "on the fly", the Gold transformation in our architecture is a decoupled, scheduled process.  
> Managed by Majordome, this task runs on a specific schedule to process data that is at least one week old. By delaying this transformation, we ensure that:
> * **System Load is Balanced**: High-intensity tasks are spread across distinct time windows to balance the load.
> * **Data Integrity**: We operate on a stabilized "Silver" dataset, allowing for more reliable deduplication and trend analysis.
> * **Efficiency**: Majordome handles the heavy lifting only once per data block, keeping the "Gold" tables ultra-lean and ready for fast querying.
