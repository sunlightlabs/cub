DROP TABLE IF EXISTS "skedb";

CREATE TABLE "skedb" (
    committee_name VARCHAR(200),
    filing_number INTEGER NOT NULL,
    form_type VARCHAR(8) NOT NULL,
    line_type VARCHAR(8) NOT NULL,
    superseded_by_amendment BOOLEAN NOT NULL,
    filer_committee_id_number VARCHAR(9) NOT NULL,
    transaction_id VARCHAR(20) NOT NULL,
    back_reference_tran_id_number VARCHAR(20),
    back_reference_sched_name VARCHAR(8),
    entity_type VARCHAR(3) NOT NULL,
    payee_name VARCHAR(100),
    payee_organization_name VARCHAR(200),
    payee_last_name VARCHAR(30),
    payee_first_name VARCHAR(20),
    payee_middle_name VARCHAR(20),
    payee_prefix VARCHAR(10),
    payee_suffix VARCHAR(10),
    payee_street_1 VARCHAR(34),
    payee_street_2 VARCHAR(34),
    payee_city VARCHAR(30),
    payee_state VARCHAR(4),
    payee_zip VARCHAR(15),
    election_code VARCHAR(5),
    election_other_description VARCHAR(20),
    expenditure_date VARCHAR(9),
    expenditure_date_formatted DATE,
    expenditure_amount FLOAT,
    semi_annual_refunded_bundled_amt FLOAT,
    expenditure_purpose_code VARCHAR(32),
    expenditure_purpose_descrip VARCHAR(100),
    category_code VARCHAR(4),
    beneficiary_committee_fec_id VARCHAR(9),
    beneficiary_committee_name VARCHAR(200),
    beneficiary_candidate_fec_id VARCHAR(9),
    beneficiary_candidate_name VARCHAR(100),
    beneficiary_candidate_last_name VARCHAR(30),
    beneficiary_candidate_first_name VARCHAR(20),
    beneficiary_candidate_middle_name VARCHAR(20),
    beneficiary_candidate_prefix VARCHAR(10),
    beneficiary_candidate_suffix VARCHAR(10),
    beneficiary_candidate_office VARCHAR(2),
    beneficiary_candidate_state VARCHAR(4),
    beneficiary_candidate_district VARCHAR(4),
    conduit_name VARCHAR(200),
    conduit_street_1 VARCHAR(34),
    conduit_street_2 VARCHAR(34),
    conduit_city VARCHAR(30),
    conduit_state VARCHAR(2),
    conduit_zip VARCHAR(15),
    memo_code VARCHAR(4),
    memo_text_description VARCHAR(100),
    ref_to_sys_code_ids_acct VARCHAR(9),
    refund_or_disposal_of_excess VARCHAR(20),
    communication_date VARCHAR(9)
);

-- This is just a renamed version of the download from here: http://assets.realtime.influenceexplorer.com.s3.amazonaws.com/bulk/skedb.csv.gz

COPY skedb FROM '../slacklight_data/skedb_2016.csv' WITH CSV HEADER;

ALTER TABLE skedb ADD COLUMN exp_date_d date;
UPDATE skedb SET  exp_date_d = to_date(text(expenditure_date),'YYYYMMDD');
ALTER TABLE skedb ADD COLUMN comm_date_d date;
UPDATE skedb SET comm_date_d = to_date(text(communication_date),'YYYYMMDD');

--  Now go back and add skede

DROP TABLE IF EXISTS "skede";

CREATE TABLE "skede" (
    committee_name VARCHAR(200) NOT NULL,
    filing_number INTEGER NOT NULL,
    form_type VARCHAR(8) NOT NULL,
    line_type VARCHAR(7) NOT NULL,
    superseded_by_amendment BOOLEAN NOT NULL,
    candidate_id_checked VARCHAR(9),
    candidate_party_checked VARCHAR(4),
    candidate_name_checked VARCHAR(34),
    candidate_office_checked VARCHAR(4),
    candidate_state_checked VARCHAR(4),
    candidate_district_checked VARCHAR(4),
    support_oppose_checked VARCHAR(4),
    committee_name2 VARCHAR(200) NOT NULL,
    filer_committee_id_number VARCHAR(9) NOT NULL,
    transaction_id VARCHAR(20) NOT NULL,
    back_reference_tran_id_number VARCHAR(32),
    back_reference_sched_name VARCHAR(32),
    entity_type VARCHAR(4),
    payee_name VARCHAR(40),
    payee_organization_name VARCHAR(200),
    payee_last_name VARCHAR(30),
    payee_first_name VARCHAR(20),
    payee_middle_name VARCHAR(20),
    payee_prefix VARCHAR(10),
    payee_suffix VARCHAR(32),
    payee_street_1 VARCHAR(34),
    payee_street_2 VARCHAR(34),
    payee_city VARCHAR(30),
    payee_state VARCHAR(4),
    payee_zip VARCHAR(9),
    election_code VARCHAR(5) NOT NULL,
    election_other_description VARCHAR(20),
    effective_date DATE,
    dissemination_date INTEGER,
    expenditure_date INTEGER,
    expenditure_amount FLOAT NOT NULL,
    calendar_y_t_d_per_election_office FLOAT,
    expenditure_purpose_code VARCHAR(32),
    expenditure_purpose_descrip VARCHAR(100),
    category_code VARCHAR(4),
    payee_cmtte_fec_id_number VARCHAR(9),
    support_oppose_code VARCHAR(1),
    candidate_id_number VARCHAR(9),
    candidate_name VARCHAR(32),
    candidate_last_name VARCHAR(30) NOT NULL,
    candidate_first_name VARCHAR(20) NOT NULL,
    candidate_middle_name VARCHAR(20),
    candidate_prefix VARCHAR(10),
    candidate_suffix VARCHAR(10),
    candidate_office VARCHAR(10),
    candidate_state VARCHAR(6),
    candidate_district VARCHAR(4),
    completing_last_name VARCHAR(30),
    completing_first_name VARCHAR(20),
    completing_middle_name VARCHAR(20),
    completing_prefix VARCHAR(10),
    completing_suffix VARCHAR(10),
    date_signed INTEGER,
    date_signed_formatted INTEGER,
    memo_code VARCHAR(4),
    memo_text_description VARCHAR(100)
);

COPY skede
FROM '../statewatch/slacklight_data/skede_2016.csv' WITH CSV HEADER QUOTE '"' DELIMITER ',';

ALTER TABLE skede ADD COLUMN date_signed_d date;
UPDATE skede SET date_signed_d = to_date(text(date_signed),'YYYYMMDD');
ALTER TABLE skede ADD COLUMN eff_date_d date;
UPDATE skede SET eff_date_d = to_date(text(effective_date),'YYYYMMDD');
ALTER TABLE skede ADD COLUMN dissem_date_d date;
UPDATE skede SET dissem_date_d = to_date(text(dissemination_date),'YYYYMMDD');
ALTER TABLE skede ADD COLUMN exp_date_d date;
UPDATE skede SET exp_date_d = to_date(text(expenditure_date),'YYYYMMDD');

-- now go back and add skeda

DROP TABLE IF EXISTS "skeda" CASCADE;

CREATE TABLE skeda (
	committee_name VARCHAR(200), 
	filing_number INTEGER NOT NULL, 
	form_type VARCHAR(8) NOT NULL, 
	line_type VARCHAR(8) NOT NULL, 
	superseded_by_amendment BOOLEAN NOT NULL, 
	filer_committee_id_number VARCHAR(9) NOT NULL, 
	transaction_id VARCHAR(20) NOT NULL, 
	back_reference_tran_id_number VARCHAR(20), 
	back_reference_sched_name VARCHAR(8), 
	entity_type VARCHAR(3) NOT NULL, 
	contributor_name VARCHAR(200), 
	contributor_organization_name VARCHAR(200), 
	contributor_last_name VARCHAR(30), 
	contributor_first_name VARCHAR(20), 
	contributor_middle_name VARCHAR(20), 
	contributor_prefix VARCHAR(10), 
	contributor_suffix VARCHAR(10), 
	contributor_street_1 VARCHAR(34), 
	contributor_street_2 VARCHAR(34), 
	contributor_city VARCHAR(30), 
	contributor_state VARCHAR(4), 
	contributor_zip VARCHAR(15), 
	election_code VARCHAR(5), 
	election_other_description VARCHAR(20), 
	contribution_date VARCHAR(9), 
	contribution_date_formatted DATE, 
	contribution_amount FLOAT, 
	contribution_aggregate FLOAT, 
	contribution_purpose_code VARCHAR(32), 
	contribution_purpose_descrip VARCHAR(100), 
	contributor_employer VARCHAR(200), 
	contributor_occupation VARCHAR(200), 
	donor_committee_fec_id VARCHAR(9), 
	donor_committee_name VARCHAR(200), 
	donor_candidate_fec_id VARCHAR(9), 
	donor_candidate_name VARCHAR(100), 
	donor_candidate_last_name VARCHAR(30), 
	donor_candidate_first_name VARCHAR(20), 
	donor_candidate_middle_name VARCHAR(20), 
	donor_candidate_prefix VARCHAR(10), 
	donor_candidate_suffix VARCHAR(10), 
	donor_candidate_office VARCHAR(2), 
	donor_candidate_state VARCHAR(4), 
	donor_candidate_district VARCHAR(4), 
	conduit_name VARCHAR(200), 
	conduit_street1 VARCHAR(34), 
	conduit_street2 VARCHAR(34), 
	conduit_city VARCHAR(30), 
	conduit_state VARCHAR(2), 
	conduit_zip VARCHAR(15), 
	memo_code VARCHAR(4), 
	memo_text_description VARCHAR(100), 
	reference_code VARCHAR(20)
);

COPY skeda
FROM '../statewatch/slacklight_data/skeda_2016.csv' WITH CSV HEADER QUOTE '"' DELIMITER ',';

CREATE INDEX skede_sd ON skede (date_signed_d);
CREATE INDEX skede_ed ON skede (eff_date_d);
CREATE INDEX skede_payee ON skede (payee_name);
CREATE INDEX skedb_expd ON skedb (exp_date_d);
CREATE INDEX skedb_cmteid ON skedb (filer_committee_id_number);
CREATE INDEX skeda_zip ON skeda (contributor_zip);
CREATE INDEX skeda_emp ON skeda (contributor_employer);
CREATE INDEX skeda_filer_num ON skeda (filer_committee_id_number);
CREATE INDEX skeda_elex ON skeda (election_code);
CREATE INDEX skeda_date ON skeda (contribution_date_formatted);

VACUUM ANALYZE skede;
VACUUM ANALYZE skedb;
VACUUM ANALYZE skeda;

