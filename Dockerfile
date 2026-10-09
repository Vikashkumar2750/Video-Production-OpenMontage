FROM nikolaik/python-nodejs:python3.10-nodejs20

# System tools install करें (FFmpeg बहुत ज़रूरी है)
RUN apt-get update && apt-get install -y ffmpeg chromium-browser --no-install-recommends && rm -rf /var/lib/apt/lists/*

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

# कंटेनर चालू रखने के लिए (चूंकि यह एक एजेंट टूल है)
CMD ["tail", "-f", "/dev/null"]
