"""import os
import socket
host_name = socket.gethostname()
print("I am from", host_name)"""
# an object of WSGI application
from flask import Flask    
app = Flask(__name__)   # Flask constructor
  
# A decorator used to tell the application
# which URL is associated function
@app.route('/')      
def hello():
    return 'HELLO This is Test'
  
if __name__=='__main__':
   app.debug = True
   app.run(host="0.0.0.0")