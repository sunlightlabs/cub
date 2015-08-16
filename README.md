# Cub
**Slack integrations for Sunlight's campaign finance data**

Cub is designed to poll a variety of Sunlight Foundation tools -- Political Ad Sleuth, Realtime Influence Explorer, and Openstates -- to deliver a bundle of raw intelligence about noteworthy movement in the world of politics, campaigns, and the state legislature.

When configured and connected to a Postgres database to keep its own copy of certain campaign finance information pulled from Realtime, Cub pushes alerts to a Slack channel on demand using Slack's webhook functionality.

## Configuration

* There is a conf.json file. Edit it to include your Sunlight API key (free!) and your Slack Webhooks URL.
* There are shell scripts and SQL statements in `admin/` and `sql/`. Edit them to point to the directories and databases you want. *Note that the SQL statements currently use relative paths in a `COPY FROM` statement. This is almost certainly a terrible idea that will not work for you. Change those to absolute paths.* 

Cub is designed to run on the same computer as a Postgres server that houses its own copy of some campaign finance information pulled from Realtime. The Realtime app completes a variety of data cleaning and standardization tasks that make it a desirable source for campaign finance data as opposed to working with the raw FEC data. If you want to run Cub from one computer and host a database on another, or if you don't want to store your own data in Postgres, you'll have to do more work on the code.

## Running Cub

The scripts that make all the magic happen are shell scripts in `admin/` and `run.py` in the repository root. 

There are more elegant ways to run Cub, for example, you could modify it to run as a service. However, a straightforward way that works is to run it as a cronjob.

On a *nix system, type:
`crontab -e`

to edit your cron.

For folks running Cub from a virtualenv, you'll want lines in cron that look like this:

`SHELL=/bin/bash`

`30 03 * * * cd $HOME/cub_path/admin && ./build_sked_tables.sh > /home/your_user_name/path_to_logfile.log`

`30 04 * * * source $HOME/.bash_profile && workon cub_virtualenv && python run.py  > home/your_user_name/path_to_other_logfile.log`
