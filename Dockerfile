FROM python:3.9-slim

# Install iptables
RUN apt-get update && apt-get install -y iptables

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run fruitflies.py when the container launches
CMD ["python", "fruitflies.py"]