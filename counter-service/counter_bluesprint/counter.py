from flask import Blueprint, jsonify, Response,request
from flask import current_app
from counter_io_handler.handler import CounterIOHandler

counter_io = CounterIOHandler()
counter = counter_io.read()


def create_counter_bp() -> Blueprint:
    counter_bp = Blueprint("counter",__name__)
     
    @counter_bp.route("/",methods=["POST", "GET"])
    def index():
        global counter
        if request.method == "POST":
                current_app.logger.info(f"POST request - Our counter is: {counter} ")
                counter+=1 
                counter_io.write(counter)

                http_post_massage = "Hmm, Plus 1 please"
                current_app.logger.info(f"{http_post_massage}, state : {counter}")
                return f"{http_post_massage} ", 200
        else:
                current_app.logger.info(f"GET request - Our counter is: {counter} ")
                http_get_massage = str(f"Our counter is: {counter} ")
                current_app.logger.info(f"{http_get_massage}, state : {counter}")
                return http_get_massage, 200

    return counter_bp