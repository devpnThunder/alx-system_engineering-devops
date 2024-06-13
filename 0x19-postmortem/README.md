# POSTMORTEM REPORT
## Issue Summary
### Duration of Outage:
Start: June 12, 2024, 10:30 AM UTC  
End: June 12, 2024, 1:45 PM UTC

### Impact:
The primary service affected was our online transaction processing system. Users experienced significant delays in transaction processing, with some transactions failing completely. Approximately 65% of users were affected, resulting in disrupted transactions and frustration among customers.

### Root Cause:  
The outage was caused by a memory leak in the database connection pool, leading to exhaustion of available connections and subsequent service degradation.

### Timeline:
- 10:35 AM UTC: Issue detected via automated monitoring alert indicating high transaction failure rates.
- 10:40 AM UTC: Initial investigation by on-call engineer focused on application server performance metrics.
- 11:00 AM UTC: Escalation to database team after no issues were found on the application server.
- 11:20 AM UTC: Database team identified a high number of active, unresponsive database connections.
- 11:30 AM UTC: Assumption that database server overload was due to an external DDoS attack.
- 12:00 PM UTC: Further investigation ruled out DDoS attack; focus shifted to connection pool behavior.
- 12:30 PM UTC: Misleading path included investigating firewall and network configurations.
- 1:00 PM UTC: Root cause identified as a memory leak in the connection pool.
- 1:15 PM UTC: Temporary fix applied by restarting the database server and reducing connection pool size.
- 1:45 PM UTC: Permanent fix deployed by patching the connection pool library.


# Root Cause and Resolution
## Root Cause:  
The core issue was a memory leak within the database connection pool library. Over time, the leak caused a gradual increase in memory usage, eventually exhausting all available connections. This exhaustion resulted in slow or failed transaction processing as the application could not establish new connections to the database.

## Resolution: 
Upon identifying the memory leak, the immediate action was to restart the database server and temporarily reduce the connection pool size to mitigate further impact. The permanent resolution involved patching the connection pool library to address the memory leak. This patch was thoroughly tested in a staging environment before being deployed to production.

# Corrective and Preventative Measures
## Improvements:
1. Enhance monitoring to detect abnormal memory usage patterns in connection pools.
2. Implement more granular alerts to distinguish between different types of connection-related issues.
3. Conduct regular audits of third-party libraries for known issues and timely updates.

## Tasks:
1. Patch the connection pool library to the latest version.
2. Add detailed monitoring for memory usage and connection counts in the database connection pool.
3. Implement automated alerts for unusual spikes in database connections.
4. Review and update incident response protocols to include more detailed investigation steps for connection issues.
5. Schedule regular training sessions for the engineering team on identifying and resolving memory leaks.

By implementing these corrective measures, we aim to prevent similar incidents in the future and improve the overall resilience and reliability of our transaction processing system.

