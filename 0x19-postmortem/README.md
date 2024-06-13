# POSTMORTEM REPORT
# Issue Summary
## Duration of Outage: 
Start: June 12, 2024, 10:30 AM UTC  
End: June 12, 2024, 1:45 PM UTC

## Impact: 
Our online transaction processing system experienced significant delays, with some transactions failing completely. Approximately 65% of users were affected, resulting in a mixture of mild annoyance, deep frustration, and a few existential crises.

## Root Cause:
A memory leak in the database connection pool led to the exhaustion of available connections, causing the service degradation. Think of it as our database trying to hold too many groceries and dropping them all over the place.

![Database Connection Pool Issue](https://dummyimage.com/600x400/000/fff&text=Database+Connection+Pool+Issue)

## Timeline:

- 10:35 AM UTC: Issue detected via automated monitoring alert—like a fire alarm but less noisy.
- 10:40 AM UTC: Initial investigation by on-call engineer; no immediate issues found on the application server.
- 11:00 AM UTC: Escalation to the database team, who were just starting their second cup of coffee.
- 11:20 AM UTC: Database team noticed a high number of active, unresponsive connections—akin to a traffic jam during rush hour.
- 11:30 AM UTC: Assumption that the database server was under a DDoS attack; cue the dramatic music.
- 12:00 PM UTC: Further investigation ruled out DDoS attack; focus shifted to the connection pool behavior.
- 12:30 PM UTC: Misleading path included investigating firewall and network configurations; it was a wild goose chase.
- 1:00 PM UTC: Root cause identified as a memory leak in the connection pool—imagine a leaky faucet, but worse.
- 1:15 PM UTC: Temporary fix applied by restarting the database server and reducing connection pool size.
- 1:45 PM UTC: Permanent fix deployed by patching the connection pool library, and we lived happily ever after (until the next bug).

# Root Cause and Resolution
## Root Cause:
The core issue was a memory leak within the database connection pool library. Over time, this caused a gradual increase in memory usage, leading to the exhaustion of all available connections. It was like a never-ending buffet, but our database just couldn't handle it anymore.

## Resolution:
Once we identified the memory leak, we restarted the database server and temporarily reduced the connection pool size to keep things running. The permanent resolution was to patch the connection pool library. We tested this patch in a staging environment before deploying it to production—no more leaks!


# Corrective and Preventative Measures
## Improvements:
1. Enhance monitoring to detect abnormal memory usage patterns in connection pools. 
2. Implement more granular alerts to distinguish between different types of connection-related issues—let's catch the small fires before they become infernos.
3. Conduct regular audits of third-party libraries for known issues and timely updates.

## Tasks:
1. Patch the connection pool library to the latest version.
2. Add detailed monitoring for memory usage and connection counts in the database connection pool.
3. Implement automated alerts for unusual spikes in database connections—because surprises are only fun at birthday parties.
4. Review and update incident response protocols to include more detailed investigation steps for connection issues.
5. Schedule regular training sessions for the engineering team on identifying and resolving memory leaks—because knowledge is power.

By implementing these corrective measures, we aim to prevent similar incidents in the future and improve the overall resilience and reliability of our transaction processing system. And remember, the only memory leak we should have is in our recall of bad jokes!

