
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
SELECT * FROM raw_tweets LIMIT 10;












-- Create the table for dictionary, and load the given dictionary.tsv file in the path. this table will be created in default database
CREATE EXTERNAL TABLE my_dictionary (
    type string,
    length int,
    word string,
    pos string,
    stemmed string,
    polarity string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE

--Following will load data from HDFS directory into Hive table.
LOAD DATA INPATH '/tmp/dictionary/' OVERWRITE INTO TABLE default.my_dictionary;













-- All views will be available when the default database is selected and then type: show tables;

-- Layer-1 
create or replace view default.Layer1 AS
select
created_at,
substr(created_at,27,4) as years,
substr(created_at,5,3) as months,
substr(created_at,9,2) as days,
substr(created_at,12,8) as times,
id,
lower(regexp_replace(text,'\n','')) as text
from default.raw_tweets;






--Layer-2
create or replace view default.Layer2 AS
select id, words
from default.Layer1
lateral view explode(split(text,'\\W+')) text as words;








--Layer-3
Create or Replace view default.Layer3 AS
select
id, L2.words,
case d.polarity
when 'negative' then -1
when 'positive' then 1
else 0 end
as polarity
from Layer2 L2 left outer join my_dictionary d
on L2.words=d.word;











--Layer-4
create or replace view default.sentiment as
select
 id,
 case
 when sum( polarity ) > 0 then 'positive'
 when sum( polarity ) < 0 then 'negative'
 else 'neutral' end as sentiment
from layer3 l3 group by id;








-- Combine the sentiment view with the main table
SELECT
 L1.*, s.sentiment
FROM layer1 L1 LEFT OUTER JOIN sentiment s on L1.id = s.id
;