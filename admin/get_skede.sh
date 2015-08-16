# Get the latest Schedule B and Schedule E files
rm ../slacklight_data/*.gz

wget http://assets.realtime.influenceexplorer.com.s3.amazonaws.com/bulk/skede_2016.csv.gz -P ../slacklight_data
gunzip -f ../slacklight_data/skede_2016.csv.gz

wget http://assets.realtime.influenceexplorer.com.s3.amazonaws.com/bulk/skedb_2016.csv.gz -P ../slacklight_data
gunzip -f ../slacklight_data/skedb_2016.csv.gz

wget http://assets.realtime.influenceexplorer.com.s3.amazonaws.com/bulk/skeda_2016.csv.gz -P ../slacklight_data
gunzip -f ../slacklight_data/skeda_2016.csv.gz
