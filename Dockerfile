# Gunakan image python:3.10-slim-buster sebagai base image
FROM python:3.10-slim-buster  

# Set direktori kerja ke /app
WORKDIR /app  

# Salin requirements.txt ke dalam container
COPY requirements.txt requirements.txt  

# Buat virtual environment
RUN python -m venv venv  
ENV PATH="/app/venv/bin:$PATH"  

# Update apt-get dan instal dependensi
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    cmake \
    libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*  # Membersihkan cache apt untuk mengurangi ukuran image

# Instal dependensi Python dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt  

# Salin semua file ke dalam container
COPY . .  

# Berikan izin penuh untuk direktori translations
RUN chmod -R 777 translations  

# Perintah untuk menjalankan aplikasi
CMD ["python", "./run.py"]
