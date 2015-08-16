# coding: utf-8
import requests
import json
from datetime import date,datetime
from time import sleep

def send_alert(msg,the_url,username,icon_emoji):
    text = msg
    the_payload = { 'text' : text, 'username' : username, \
                    'icon_emoji' : icon_emoji }
    r = requests.post(the_url, json=the_payload)
    
class apiRequest(object):

    its_today = date.strftime(date.today(),'%Y-%m-%d')
    
    def knock(self,url,some_params):
        try:
            r = requests.get(url,params=some_params)
            if r.status_code == requests.codes.ok:
                json_content = r.json()
            else:
                json_content = False
                print 'API call returned status code %s' % str(r.status_code)
        except requests.exceptions.ConnectionError, ce:
            print 'Connection error: %s' % ce
            json_content = False
        return json_content

    def __init__(self,url,params,n_tries=3):
        print 'API request: %s,%s' % (url,self.its_today)
        while n_tries > 0:
            print 'Attempting API call ...'
            json_content = self.knock(url,params)
            self.json_content = json_content
            if self.json_content:
                print 'Request returned results.'
                n_tries = 0
            else:
                n_tries -= 1
                sleep(15)
        if not self.json_content:
            print 'Request returned no results.'

class sunlightApiRequest(apiRequest):

    def __init__(self,sunkey,url,params,n_tries=3):

        the_params = params
        the_params['apikey'] = sunkey
        
        print 'API request: %s,%s' % (url,self.its_today)
        
        while n_tries > 0:
            print 'Attempting API call ...'
            json_content = self.knock(url,the_params)
            self.json_content = json_content
            if self.json_content:
                print 'Request returned results.'
                n_tries = 0
            else:
                n_tries -= 1
                sleep(15)
        if not self.json_content:
            print 'Request returned no results.'
