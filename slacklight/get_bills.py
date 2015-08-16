import requests
from core import *

def get_bills(a_date,search_terms):
        
    the_url = 'http://openstates.org/api/v1/bills/'

    new_bills = []
    
    for term in search_terms:
        the_payload = { 'updated_since':a_date, \
                    'q':term }
        api_call = sunlightApiRequest(the_url,the_payload)
        if api_call.json_content:
            new_bills.extend(api_call.json_content)

    if len(new_bills) == 0:
        return False
    else:
        return new_bills
