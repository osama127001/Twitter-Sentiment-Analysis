# coding: utf-8
# In[26]:
# importing the required libraries.
import tweepy
import json
import time
import datetime
# Authentication details. Enter your own twitter app keys here.
consumer_key = "3FwdSlqB00UpH30tD0KdZ3XcP"
consumer_secret = "K3ur7wRP9wgSiwAICK4QKOwjOdO9EmiPRrTqdsXf7HntXEEYvF"
access_key = "714150910331654144-gjQnf1lYQS6RXwMOKb7gwwg7ONlUCs9"
access_secret = "lfh2Du1YAvYCBJrhPROwqASTTNEoH2R11UbY2wpvgCDPR"
# Enter the hashtag you want to search for here.
accountvar = "Football"
# getting the current date and time.
t = datetime.datetime.now()
# sorting the acquired date and time into the format we want as Windows   # doesn't allow us to include : in file names.
a = t.strftime('%Y-%m-%d-%H-%M')
# specifying the output file name.
outputfilejson = accountvar+"_"+str(a)+".json"
# This is the listener, resposible for receiving data.
class StdOutListener(tweepy.StreamListener):
    # this class will be called before any of the others once the connection with the Twitter API is made.
    def __init__(self, time_limit=60):
        # setting current time as start time.
        self.start_time = time.time()
        # setting time limiter to pause stream. Current time limit is 60 seconds as specified in the function definition.
        self.limit = time_limit
        super(StdOutListener, self).__init__()
    # defining the on_data function. This will tell the compiler what to do whenever new data is received.
    def on_data(self, data):
        # setting the time limit checker. It will let the stream fetch data as long as the time limit has not been reached.
        if (time.time() - self.start_time) < self.limit:
            # loading the fetched encoded json tweet into the decoded variable.
            decoded = json.loads(data)
            #print('here i am in the start of try')
            try:
            #print('here i am inside try')
                if isinstance(decoded, dict):    
                    #print(decoded)
                    #print('here i am inside try in if')
                    # decoding the json tweet and loading it in decoded.
                    decoded = json.dumps(decoded).encode('utf-8')
                    # writing the decoded tweet into the output file.
                    outfile.write(decoded)
                    # adding a new line after the tweet into the output file.
                    outfile.write(b'\n')
                    # printing the stuff we are writing into the output file.
                    decoded = json.loads(decoded.decode('utf-8'))
                    print (decoded)
                    print('\n')
            # handling exceptions in case there is some error
            except (NameError, KeyError,AttributeError):
            #    print('here i am inside catch')
                pass
            #return True
        # code will go here once the time limit is reached. The following lines will disconnect the stream.
        else:
            time.sleep(10) 
            stream.disconnect()
            return False
    # code will go here if there is any error while making connection with the Twitter API.
    def on_error(self, status):
        # printing the received error.
        print (status)
# specifying the main method. This method is always called first when the code starts so we do all the initializing here.
if __name__ == '__main__':
    # calling the listener class.
    l = StdOutListener()
    # specifying the authorization handler of the Twitter API and giving it the variables we defined at the start.
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    # setting the access token with the tokens of our Twitter API.
    auth.set_access_token(access_key, access_secret)
    # creating a new output file and opening it in write back mode.
    with open(outputfilejson, 'wb') as outfile:
        print ("Showing all new tweets for " + accountvar)
        # initializing the stream with the Twitter API authorization keys.
        stream = tweepy.Stream(auth, l)
        # searching for the required hashtag.
        stream.filter(track=[str("#" + accountvar)])
