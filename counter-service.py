#!flask/bin/python
from flask import Flask, request, request_started

app = Flask(__name__)
counter = 0
@app.before_request
def before_request():
    """Hmmm, Plus 1 please"""
    global counter
    if request.method=='POST':
        counter+=1
@app.route('/')
def index():
     """Our counter is..."""   
     return str(counter)
if __name__ == '__main__':
    app.run(debug=True,port=80)
