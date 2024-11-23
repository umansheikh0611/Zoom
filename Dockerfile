# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Update system and install dependencies
RUN apt-get update -y && apt-get install -y \
    wget unzip libvulkan1 && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir selenium faker

# Download and install Google Chrome
RUN wget https://storage.googleapis.com/chrome-for-testing-public/131.0.6778.85/linux64/chrome-linux64.zip && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get install -f -y && \
    chmod +x /usr/bin/google-chrome && \
    rm -f google-chrome-stable_current_amd64.deb

# Download and set up ChromeDriver
RUN wget -q https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/bin/chromedriver && \
    chmod +x /usr/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Set PATH for ChromeDriver
ENV PATH="/usr/bin/chromedriver:${PATH}"

# Expose environment variables for dynamic inputs
ENV NUMBER=10
ENV MEETINGCODE=4242294841
ENV PASSCODE=sVrr27

# Command to run the Python script
CMD ["python", "main.py"]
