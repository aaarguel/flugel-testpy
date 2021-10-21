#!/bin/sh
sudo apt-get update -y
cd /home/ubuntu
mkdir service-flugel
cd service-flugel
sudo apt install python3-pip -y
sudo apt install python3-waitress -y
sudo apt install gunicorn -y
pip install flask

sudo echo '
from flask import Flask
import json
import os
import threading
app = Flask(__name__)

@app.route("/tags")
def tags():
    tagged = {}
    tagged["Name"] = "Flugel"
    tagged["Owner"] = "InfraTeam"
    return tagged

@app.route("/shutdown")
def shutdown():
    response = {}
    response["Message"] = "It shut down properly after 5 seconds..."
    start_func = threading.Timer(5,execShutDown)
    start_func.start()        
    return response

def execShutDown():    
    os.system("init 0")
    
#Run a simple service
if __name__ == "__main__":
    from waitress import serve
    serve(app, host="0.0.0.0", port=8080)

def create_app():
   return app
' > service.py

sudo echo "
waitress-serve --port=8080 --call service:create_app
" > exec.sh
sudo nohup sh exec.sh & > log.txt