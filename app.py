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
    serve(app, host="0.0.0.0", port=5000)

def create_app():
   return app
