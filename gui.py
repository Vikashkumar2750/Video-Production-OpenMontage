import streamlit as st
import os
import subprocess

st.set_page_config(page_title="OpenMontage AI Generator", page_icon="🎬", layout="centered")

st.title("🎬 OpenMontage AI Video Generator")
st.write("24 GB Railway Server पर बिना API Key के बिल्कुल फ्री वीडियो बनाएं।")

# User Input Form
with st.form("video_form"):
    prompt = st.text_area("अपना वीडियो प्रॉम्प्ट यहाँ लिखें:", 
                          value="Make a 60-second documentary montage about space exploration. Use NASA and Archive.org footage only, with music, narration yes.")
    
    pipeline = st.selectbox("वीडियो का प्रकार (Pipeline):", 
                            ["documentary_montage", "animated_explainer", "animation", "cinematic"])
    
    submit_button = st.form_submit_button(label="🚀 Generate AI Video")

if submit_button:
    if prompt:
        st.info("🤖 AI Agent ने काम शुरू कर दिया है! बैकग्राउंड में रिसर्च और वीडियो क्लिप्स डाउनलोड हो रही हैं...")
        
        # बैकग्राउंड में AI स्क्रिप्ट को रन करने की कमांड
        cmd = f"python -m pipelines.run --pipeline {pipeline} --prompt \"{prompt}\""
        
        # इसे बैकग्राउंड में चलाएंगे ताकि UI हैंग न हो
        subprocess.Popen(cmd, shell=True)
        
        st.success("✅ स्क्रिप्ट ट्रिगर हो गई है! 5-7 मिनट बाद अपने Remotion एडिटिंग रूम (Port 8080) पर जाकर पेज रिफ्रेश करें।")
    else:
        st.error("कृपया पहले एक प्रॉम्प्ट लिखें!")
