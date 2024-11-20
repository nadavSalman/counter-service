FROM python:3.10.12-slim
WORKDIR /app
COPY counter-service/requirements.txt /app/
COPY counter-service/ /app/

RUN pip install -r requirements.txt
COPY counter-service/ /app
# ENV FLASK_APP=app.py
CMD [ "python3", "-m" , "flask", "run", "--app" , "app.py" , "--host=0.0.0.0"]