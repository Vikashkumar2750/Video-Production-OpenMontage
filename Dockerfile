FROM nikolaik/python-nodejs:python3.10-nodejs20

RUN apt-get update && apt-get install -y ffmpeg chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install piper-tts

COPY remotion-composer/package*.json ./remotion-composer/
RUN cd remotion-composer && npm install

COPY . .

# एनवायरनमेंट फाइल को एक्टिवेट करके सीधे मुख्य वेब इंटरफेस को होस्ट बाइंडिंग के साथ पोर्ट पर रन करना
CMD cp .env.example .env && cd remotion-composer && npx remotion preview --host 0.0.0.0 --port 8080
