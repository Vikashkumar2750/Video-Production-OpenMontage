FROM nikolaik/python-nodejs:python3.10-nodejs20

# System packages install करें (FFmpeg और Chromium आवश्यक हैं)
RUN apt-get update && apt-get install -y ffmpeg chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Python dependencies setup
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install piper-tts

# Remotion/React interface setup
COPY remotion-composer/package*.json ./remotion-composer/
RUN cd remotion-composer && npm install

# बाकी सारा प्रोजेक्ट कोड कॉपी करें
COPY . .

# एनवायरनमेंट सेट करें और रिमोशन वेब प्रीव्यू सर्वर को सही पोर्ट पर चालू करें
CMD cp .env.example .env && cd remotion-composer && npx remotion preview --host 0.0.0.0 --port 8080
