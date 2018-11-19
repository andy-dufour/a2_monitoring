#!/bin/bash

date_range="now-${2}m"
query_type="$1"

case "$query_type" in
        actions)
            date_field='recorded_at'
       	    ;;

        _doc)
            date_field='@timestamp'
            ;;

        converge)
            date_field='end_time'
            ;;
        *)
            echo $"Usage: $0 {actions|_doc|converge} time_in_minutes"
            exit 1
esac

curl -XGET -H 'content-type: application/json' 'localhost:10141/_search' -d"
{
        \"query\": {
          \"bool\": {
            \"must\": [
              { \"range\": { \"$date_field\": {\"gt\": \"$date_range\"}}},
              { \"match\": {\"_type\": \"$query_type\"}}
            ]
          }
        }
}"
