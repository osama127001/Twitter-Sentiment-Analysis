-- the table that needs to be created when working with downloaded json data.
CREATE EXTERNAL TABLE IF NOT EXISTS raw_tweets
(
	created_at string,
	id string,
	id_str string,
	text string,
	source string,
	truncated string,
	user_tw struct
	<
		id:string,
		id_str:string,
		name:string,
		screen_name:string,
		location:string,
		url:string,
		description:string,
		translator_type:string,
		protected:string,
		verified:string,
		followers_count:string,
		friends_count:string,
		listed_count:string,
		favourites_count:string,
		created_at:string,
		utc_offset:string,
		time_zone:string
	>
)

ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
LOCATION '/apps/hive/warehouse/raw_tweets/';

-- the following query to check if the created table is working or not
SELECT * FROM raw_tweets LIMIT 10




