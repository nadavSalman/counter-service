from flask import Flask
from counter_bluesprint.counter import create_counter_bp
from flask import current_app


app = Flask(__name__)
app.logger.info("Starting Counter Service")


app.register_blueprint(
    create_counter_bp()
)

if __name__ == '__main__':
    app.run(debug=True)
