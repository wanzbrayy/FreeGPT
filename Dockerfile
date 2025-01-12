FROM python:3.10-slim-buster  

WORKDIR /app  

COPY requirements.txt requirements.txt  

RUN python -m venv venv  
ENV PATH="/app/venv/bin:$PATH"  

# Update repositori dan instal dependensi dengan pengecekan error
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    cmake \
    libcurl4-openssl-dev \
    libpq-dev \
    libmysqlclient-dev || { echo 'apt-get failed'; exit 1; } && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel  

RUN pip install --no-cache-dir -r requirements.txt  

COPY . .  

RUN chmod -R 777 translations  

CMD ["python", "./run.py"]
