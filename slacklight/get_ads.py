import requests
from core import *

def get_ads(apikey,get_since):
    adsleuth_payload = { 'order_by':'-updated_at', \
                         'updated_since':get_since, \
                         'format':'json', 'limit':500 }
    ads_url = 'http://politicaladsleuth.com/api/v1/politicalfile'
    new_ads = sunlightApiRequest(apikey,ads_url,adsleuth_payload)
    return new_ads
