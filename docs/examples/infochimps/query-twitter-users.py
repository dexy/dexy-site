### @export "imports"
from pprint import pprint
import csv
import json
import os
import urllib

### @export "base"
BASE = "http://api.infochimps.com"
API_KEY = os.environ['CHIMP_API_KEY']

### @export "fetch-chimp-data"
def fetch_chimp_data(path, args):
    args['apikey'] = API_KEY
    encoded_data = urllib.urlencode(args, doseq=True)
    handle = urllib.urlopen(BASE + path + "?" + encoded_data)
    returned_data = handle.read()
    return json.loads(returned_data)

### @export "call"
path = "/social/network/tw/influence/metrics"

twitter_names = [
    'ananelson', 'dexyit', 'hmason', 'kaythaney', 'mrflip', 'wattsteve'
]

twitter_data = {}
for name in twitter_names:
    user_data = fetch_chimp_data(path, {"screen_name" : name})
    twitter_data[name] = user_data


### @export "pprint"
pprint(twitter_data['ananelson'])

### @export "save-csv"
csv_file = open("dexy--twitter-data.csv", "wb")
data_writer = csv.writer(csv_file)

keys = sorted(twitter_data['ananelson'].keys())
data_writer.writerow(keys)
for n, d in twitter_data.iteritems():
    data_writer.writerow([d[k] for k in keys])

csv_file.close()

