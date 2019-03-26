# Usage

Copy script to machine running A2. Make it executable. Run the script with:

`./a2_datatap.sh <event type> <how far back to query in minutes>`

For example, to get all the actions in the last 60 minutes:

`./a2_datatap.sh actions 60`

This will dump the results to stdout. You may want to pipe the stdout to a file for ingest with a tool like filebeat or splunk.

WARNING: Could result in a lot of data on large implementations.

Event types:
```
actions - any event on the Chef server
_doc - Compliance scans
converge - Chef run reports
```
We're going to dump large json objects, including elasticsearch metadata.
