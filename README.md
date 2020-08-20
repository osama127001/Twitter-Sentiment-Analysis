# Twitter Sentiment Analysis

This projects download the tweets from twitter using tweepy library in python for a sentimental analysis.

### About Project and important stuff

* We are provided with a python file named "project_py_3.py" that uses tweepy to download the tweets in the current project folder.
* create a .bat file. Batch file executes each line at a time, so it's important to arrange the lines properly.
* A sample json file is uploaded with the repo.
* Transfer the json file with data manually by typing the commands in PuTTY terminal. keep a copy in NDFS and a copy in HDFS.
* After the data is downloaded and transfered to the processed folder in windows project folder. there is a folder in Linux called "tweet" and it again has 2 folders named "/tweets/processed" and "/tweets/processed". the batch file transfers the data to the "/tweets/recieved" folder. run the following command in the PuTTY terminal to transfer the file in HDFS and move the Data from "/tweets/recieved" to "/tweets/processed". 
* ** hdfs dfs -put ./tweets/recieved/* /tweets && mv ~/tweets/recieved/* /tweets/processed **