FROM python:3.10-slim-buster  

WORKDIR /app  

COPY requirements.txt requirements.txt  

RUN python -m venv venv  
ENV PATH="/app/venv/bin:$PATH"  

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    cmake \
    libcurl4-openssl-dev \
    libpq-dev \
    libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip setuptools wheel  

RUN cat requirements.txt  # Debugging untuk memastikan file di-copy

RUN pip install --no-cache-dir -r requirements.txt  

COPY . .  

RUN chmod -R 777 translations  

CMD ["python", "./run.py"]
