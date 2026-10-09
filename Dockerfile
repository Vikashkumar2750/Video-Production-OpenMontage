FROM nikolaik/python-nodejs:python3.10-nodejs20

# यहाँ chromium-browser की जगह सिर्फ chromium कर दिया है
RUN apt-get update && apt-get install -y ffmpeg chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Dependency files copy करें
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install piper-tts

# Remotion setup
COPY remotion-composer/package*.json ./remotion-composer/
RUN cd remotion-composer && npm install

# बाकी सारा कोड copy करें
COPY . .

CMD ["python", "-m", "backlot", "serve", "--host", "0.0.0.0", "--port", "8080"]


