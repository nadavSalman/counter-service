#!flask/bin/python
from flask import Flask, request, request_started

app = Flask(__name__)
counter = 0
@app.before_request
def before_request():
    """handeling the request before the route path"""
    global counter
    if request.method=='POST':
        counter+=1
@app.route('/')
def index():
     """displaying the counter after converting it to a string"""   
     return str(counter)
if __name__ == '__main__':
#exposing the service on port 80
    app.run(debug=True,port=80)
