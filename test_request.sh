curl -X POST \
     -H "ACTION: write_data" \
     -H "MD5: XXXXX" \
     -H "Content-Type: application/json" \
     --data '[{
"studyId":"",
"username":"",
"timestamp":"",
"deviceid":"",
"sensorname": "corsano_metric_ppg",
"ppg": [10]}]' \
     localhost:8888/api
