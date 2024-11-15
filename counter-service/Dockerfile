FROM python:3.10.12-slim
WORKDIR /app
COPY counter-service/Dockerfile /app
RUN pip install -r requirements.txt
COPY counter-service/ /app
EXPOSE 5000
ENV FLASK_APP=app.py
CMD ["flask", "run", "--host", "0.0.0.0"]