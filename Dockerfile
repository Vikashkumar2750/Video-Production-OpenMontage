FROM nikolaik/python-nodejs:python3.10-nodejs20

RUN apt-get update && apt-get install -y ffmpeg chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install piper-tts

COPY remotion-composer/package*.json ./remotion-composer/
RUN cd remotion-composer && npm install

COPY . .

# एनवायरनमेंट सेट करें, प्रॉम्प्टिंग UI को बैकग्राउंड में 8501 पर चलाएं, और मुख्य रेंडरर को 8080 पर चालू रखें
CMD cp .env.example .env && \
    (streamlit run gui.py --server.port 8501 --server.address 0.0.0.0 &) && \
    cd remotion-composer && npx remotion preview --host 0.0.0.0 --port 8080
