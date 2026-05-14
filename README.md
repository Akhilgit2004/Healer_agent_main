# 🛠️ AI Healer Agent (CLI)

An autonomous Site Reliability Engineer (SRE) agent that monitors CI/CD logs, identifies build-breaking bugs across multiple languages, and applies surgical fixes using LLMs.

## 🚀 Features
- **Polyglot Repair**: Supports Python, Java, C++, and JavaScript.
- **Evidence-Based**: Only fixes files actually mentioned in error logs.
- **Hallucination Protection**: Verifies fixes via compilers and uses "Safe Exit" logic.
- **Persistent Memory**: Uses Vector DB (ChromaDB) to learn from past successful repairs.

## 📦 Installation
```bash
pip install git+[https://github.com/Akhilgit2004/Healer_agent_main.git](https://github.com/Akhilgit2004/Healer_agent_main.git)
