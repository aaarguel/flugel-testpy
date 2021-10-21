# Use the Python3.7.8-stretch
FROM python:3.7.8-stretch

# Set the working directory to /app
WORKDIR /app

ADD requirements.txt /app

# Install the dependencies
RUN pip --default-timeout=200  install -r requirements.txt
# Install the dependencies
RUN pip install waitress

#Add all files 
ADD . /app

#Expose port 
EXPOSE 5000

# run the command to start uWSGI
RUN chmod +x /app/start.sh
RUN chmod +x /app/app.py
RUN cd app
CMD ["/app/app.py"]
