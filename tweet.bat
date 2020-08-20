REM REM is used for commenting in batch file


REM The Below commands given are used to get the data from tweepy and save it in the current project folder
cd /d "D:\Big Data Online\Project1_Twitter-Sentiment-Analysis\"
"C:\ProgramData\Anaconda3\python.exe" "D:\Big Data Online\Project1_Twitter-Sentiment-Analysis\project_py_3.py"

REM These commands will send the file from windows to Linux. Make sure to turn the VM on.
REM Note that the *.json means all files with .json extension
pscp -pw "XXXXXXX" "D:\Big Data Online\Project1_Twitter-Sentiment-Analysis\*.json" root@192.168.XX.XXX:/root/tweets/recieved && move "D:\Big Data Online\Project1_Twitter-Sentiment-Analysis\*.json" "D:\Big Data Online\Project1_Twitter-Sentiment-Analysis\processed"

