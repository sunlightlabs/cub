from slacklight.core import *
from slacklight.get_bills import get_bills
from slacklight.get_ads import get_ads
from slacklight.get_expenditures import get_expenditures
from datetime import date, datetime, timedelta

def do_bills(get_since, opens_search_terms):
    new_bills = get_bills(get_since,opens_search_terms)
    if new_bills:
        out_url = 'http://openstates.org/all/bills/?search_text='
        outgoing_urls = ['<' + out_url + term +'|here>' for term in opens_search_terms]
        bills = len(new_bills)
        states = set([x['state'] for x in new_bills])
        opens_msg_string = ('There have been {0} new bills updated in {1}'.format( \
            bills, len(states))
            + ' states since {0}  related to the terms: {1} '.format(\
            get_since, ', '.join(opens_search_terms))
            + '\n links: {0}'.format(','.join(outgoing_urls)))
    else:
        opens_msg_string = ('There have been no bills updated since {0}'.format(get_since)
            + 'related to the terms: {0}'.format(','.join(opens_search_terms)))

    send_alert(opens_msg_string)

def do_ads(get_since):
    new_ads = get_ads(get_since)
    if new_ads.json_content:
        the_ads = new_ads.json_content['objects']
        n_ads = len(the_ads)
        n_dmas = len(set([ad['nielsen_dma_id'] for ad in the_ads]))
        kinds = list(set([ad['candidate_type'] for ad in the_ads]))
        ads_msg_string = ('Political Ad Sleuth has {0} new ad records in '.format(n_ads)
                          + '{0} marketing areas. '.format(n_dmas))
        if len(kinds) > 0:
            ads_msg_string += 'Ads are of type: {0}. \n'.format(', '.join(kinds))
        if n_dmas > 0 and n_dmas < 5:
            dmas = list(set([ad['nielsen_dma'] for ad in the_ads]))
            ads_msg_string += 'These are the DMAs:\n{0}\n'.format('; '.join(dmas))
        ads_msg_string += 'These updates since {0}.'.format(get_since)
        ads_msg_string += ('\n Latest ads '
            + '<http://politicaladsleuth.com/political-files/most-recent/|here>.')
    else:
        ads_msg_string = 'There have been no new ad records since {0}.'.format(get_since)
        
    send_alert(ads_msg_string)

def do_expenditures(get_since,not_after):
    new_expenditures = get_expenditures(get_since,not_after)
    if new_expenditures:
        n_exps, top, summary = new_expenditures
        exps_msg_string = ('There have been {0} sets of new expenditures '.format(str(n_exps))
                           + 'since {0}. The largest aggregate outlay is: \n'.format(get_since)
                           + str(top)
                           + '\n\n View '
                           + '<http://realtime.influenceexplorer.com/outside-spending/#?ordering=-expenditure_date_formatted|here>.')
    else:
        exps_msg_string = 'There have been no new expenditures since {0}.'.format(get_since)

    send_alert(exps_msg_string)

    
    

        
if __name__ == '__main__':

    its_today = date.strftime(date.today(),'%Y-%m-%d')
    yesterday = date.strftime(date.today() - timedelta(days=2),'%Y-%m-%d')
    tomorrow = date.strftime(date.today() + timedelta(days=1),'%Y-%m-%d')

    opens_search_terms = ['"education"']

    try:
        do_bills(yesterday,opens_search_terms)
    except:
        print 'Could not get bills.'
    try:
        do_ads(yesterday)
    except:
        print 'Could not get ads.'
    try:
        do_expenditures(yesterday,tomorrow)
    except:
        print 'Could not get expenditures.'

