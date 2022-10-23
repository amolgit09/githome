"""import os
import socket
host_name = socket.gethostname()
print("I am from", host_name)"""
# an object of WSGI application
from flask import Flask    
app = Flask(__name__)   # Flask constructor Need to update
  
# A decorator used to tell the application
# which URL is associated function
@app.route('/')      
def hello():
    j = 1 + 2
    print ("",j)
    print("This is Test for Jenkins with Github is working great now re run for demo 4")
    return 'HELLO This is Test for Jenkins with Github is working great let we try with K8s automation %d',j
  
if __name__=='__main__':
   app.debug = True
   app.run(host="0.0.0.0")