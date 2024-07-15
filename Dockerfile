# Iniciando o sistema operacional
FROM python:3.9-slim

WORKDIR /app

# Baixando Python, Pip, Git e outros
RUN apt-get update && apt-get install -y\
    python3.12 \
    python3-pip
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

#Baixando os arquivos
RUN git clone https://github.com/streamlit/streamlit-example.git .

# Baixando as bibliotecas
RUN pip3 install -r requirements.txt

#Abrindo a rede
EXPOSE 8501
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Entrypoint
ENTRYPOINT ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
