## Data definition
- Lateness is measured at calendar-day granularity: an order is late only when it is delivered on a later date than estimated. Delivery on the estimated day counts as on time, whatever the hour.
- The estimated date is stored at midnight, so a raw timestamp comparison wrongly flags same-day afternoon deliveries as late. That mismatch between an earlier SQL version (timestamp) and the Power BI model (calendar day) produced a ~1.2 point gap in the late rate. Standardizing every query on the calendar-day rule reconciled both tools.
- Findings 1-3 reflect the calendar-day definition. Findings 4-5 still show the earlier timestamp figures and are flagged for refresh.
## Late delivery rate (monthly)
- Late rate worsens over time as order volume grows
- Worst month: Mar 2018 at 18.96% (nearly 1 in 5 orders late)
- Nov 2017 plus a Feb–Mar 2018 cluster (12–19%) suggests sustained operational strain, not a blip
- Order volume ~2.7x from Mar 2017 to Mar 2018 capacity didn't scale with demand
- Hypothesis upgraded: late delivery is a structural problem, not an anomaly
## Review score: late vs on-time
- Late orders average 2.27 stars vs 4.29 for on-time
- 2.02-star penalty late delivery flips a "great" order into a "poor" one
- 6,410 late orders (~6.7%) vs 89,949 on-time robust sample
- Strongest confirmation yet: delivery experience drives reviews
## Review score by delay severity (dose-response)
- early/on-time: 4.29 | 1-3d: 3.29 | 4-7d: 2.10 | 8-15d: 1.68 | 16+d: 1.73
- Clear monotonic decline review damage scales with delay length
- Biggest cliff: 1-3d → 4-7d (loses a full star), crossing below midpoint
- Floor effect at 8+ days: score bottoms ~1.7, can't go lower (min is 1)
- Recommendation seed: keeping misses under 3 days materially limits review damage
## Repeat purchase rate by first-order delivery (retention)
- Late first order: 2.51% return | On-time: 3.04% return
- ~17% relative drop in repeat rate after a late first order
- Absolute gap small (0.53pp); CIs barely separate borderline significant
- Olist baseline retention is very low (~3%), so signal is inherently faint
- Honest framing: directionally supports hypothesis; review-score effect is the stronger lever
- PENDING REFRESH: figures use the earlier timestamp definition. Re-run the updated query; day-level moves borderline first orders from late to on-time, so expect the gap to narrow slightly. Direction should hold.
## State-level delivery performance
- Worst: AL (23.9%), MA (19.7%), PI (16.0%) all Nordeste region
- Best: RO (2.9%), AM (4.1%), SP (5.9% despite 40k orders / highest volume)
- Main driver: distance from São Paulo seller hub (local stays fast)
- Anomaly 1: RJ 13.5%  close to SP but 2x its rate; last-mile complexity, not distance
- Anomaly 2: AM 4.1% remote but excellent; concentrated Manaus footprint
- Refined conclusion: distance-from-hub explains most variance, but logistics complexity (RJ) is an independent factor
- PENDING REFRESH: rates use the earlier timestamp definition. Day-level rates run a few points lower across the board; the ranking (Nordeste worst, RO/AM/SP best) is expected to hold.
