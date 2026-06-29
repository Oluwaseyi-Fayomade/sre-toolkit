import boto3
from datetime import datetime

print ("================================================")
print  (     "SRE TOOLKIT — S3 Bucket Check")
print ("================================================")

current_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

s3 = boto3.client("s3")
response = s3.list_buckets()
buckets = response["Buckets"]

print (f"Checked   : {current_date}")
print ("-------------------------------------------------")
print(f"Number of buckets: {len(buckets)}")

for bucket in buckets:
    print(bucket["Name"])

print ("-------------------------------------------------")

if len(buckets) == 0:
    print("STATUS    : No buckets found (fresh account)")
else:
    print("STATUS    : Buckets exist — review above")

print ("================================================")
