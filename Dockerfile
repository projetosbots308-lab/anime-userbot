FROM python:3.11-slim

# Evita buffer de log e problemas de locale
ENV PYTHONUNBUFFERED=1
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    ffmpeg \
    gcc \
    libffi-dev \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar requirements primeiro (melhora cache)
COPY requirements.txt .

# Instalar dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# 🔥 GARANTE yt-dlp ATUALIZADO
RUN pip install --no-cache-dir -U yt-dlp

# Copiar resto do projeto
COPY . .

CMD ["python", "main.py"]
