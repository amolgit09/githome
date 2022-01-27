"""import os
import socket
host_name = socket.gethostname()
print("I am from", host_name)"""
from flask import Flask
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast
app = Flask(__name__)
api = Api(app)