import psycopg2
import psycopg2.extras
from datetime import datetime
import pandas as pd

def get_expenditures(get_since,not_after,db,user):
    
    conn = psycopg2.connect(database=db,user=user)
    dict_cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    dict_cur.execute("SELECT committee_name, candidate_name_checked, support_oppose_checked, expenditure_amount, payee_organization_name, expenditure_purpose_code, exp_date_d FROM skede WHERE exp_date_d > to_date(%s,'YYYY-MM-DD') AND exp_date_d < to_date(%s,'YYYY-MM-DD') ORDER BY exp_date_d DESC;", (get_since,not_after))

    results = dict_cur.fetchall()
    conn.commit()
    dict_cur.close()
    conn.close()

    if len(results) > 0:
        df = pd.DataFrame(results)
        summary = df.groupby(['committee_name','candidate_name_checked','exp_date_d']).agg({ 'expenditure_amount': 'sum','support_oppose_checked': 'max' })
        n_exps = len(summary)
        top = summary.ix[summary['expenditure_amount'] == summary['expenditure_amount'].max()]
    else:
        return False

    return n_exps, top, summary
