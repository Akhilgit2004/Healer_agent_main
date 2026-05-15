# 🚨 AI Healer Agent: The Autonomous SRE

**AI Healer Agent** is an autonomous "Self-Healing" CLI tool designed to bridge the gap between CI/CD failures and developer intervention. It monitors build logs, identifies the root cause of crashes across multiple languages, and applies verified code fixes using a local LLM and Vector Memory.

Unlike simple "fix-it" scripts, this agent uses a **Disciplined Orchestration** loop: it won't just suggest a fix—it will attempt to compile and verify the fix before ever marking a build as "Healed."

---

## ✨ Key Features

* **Polyglot Repair Engine:** Supports Python, JavaScript (Node.js),C++ and Java out of the box.
* **Smart Dispatcher:** Parses raw Jenkins/CI logs to isolate only the files responsible for the crash.
* **Vector Memory (RAG):** Uses **ChromaDB** and **Sentence-Transformers** to remember successful past fixes and avoid repeating mistakes.
* **Health Check Interceptor:** Automatically verifies proposed fixes using local compilers (`g++`, `node`, `pytest`) to prevent regressions.
* **Privacy First:** Runs locally via **Ollama**, ensuring your source code never leaves your infrastructure.

---

## 🛠️ Prerequisites

Before installing the agent, ensure your environment has the following:

1.  **Python 3.10+**
2.  **Ollama:** [Download and install Ollama](https://ollama.com/).
3.  **Local LLM:** Pull the required model (default is Llama 3):
    ```bash
    ollama pull llama3
    ```
4.  **System Compilers:** (Optional, for verification)
    * `gcc` / `g++` for C++ fixes.
    * `nodejs` / `npm` for JavaScript fixes.

---

## 📦 Installation

You can install the Healer Agent directly from the source repository:

```bash
pip install git+https://github.com/Akhilgit2004/Healer_agent_main.git
```
For Developers (Editable Mode)
If you want to modify the agent's logic:

```bash
git clone [https://github.com/Akhilgit2004/Healer_agent_main.git](https://github.com/Akhilgit2004/Healer_agent_main.git)
cd Healer_agent_main
pip install -e .
```
## 🚀 Usage


### 1. Basic CLI Usage
Run the agent against any local build log:
```bash
healer --log_file path/to/your/build.log
```
### 2. Docker Execution
If you prefer to run the agent in a containerized environment (which includes all necessary compilers):
```bash
docker build -t healer-agent .
docker run -v $(pwd):/app healer-agent --log_file /app/build.log
```
## 🤖 CI/CD Integration

To automate the healing process, add the agent to the `post-failure` block of your pipeline.

### Jenkins Example:
```groovy
post {
    failure {
        script {
            echo "🚨 Build failed. Summoning the Healer Agent..."
            sh "healer --log_file ${WORKSPACE}/build.log"
        }
    }
}
```
## 📂 Project Structure

```text
cicd_agent/
├── src/
│   └── healer_agent/
│       ├── __init__.py
│       └── healer.py      # Core Agent Logic
├── agent_memory/          # Local ChromaDB Vector Store
├── pyproject.toml         # Build System & Dependencies
├── Dockerfile             # Containerized SRE Environment
└── Jenkinsfile            # Agent's own CI pipeline
```
## 🧠 How it Works: The Remediation Loop

1.  **Analysis:** The agent parses the provided log file using Regex to find filenames and error types.
2.  **Context Loading:** It reads the target source code and queries the Vector Database for similar past bugs.
3.  **LLM Generation:** The LLM proposes a surgical fix (e.g., adding `try-except` blocks or fixing logic).
4.  **Verification:** The agent runs a "Health Check" (compilation or test execution).
5.  **Commitment:** If the check passes, the file is updated. If it fails, the agent tries a different approach or exits safely.

---

## ⚠️ Disclaimer

*This tool is intended for use in development and staging environments. Always review AI-generated code before merging into production branches.*

---

**Happy Healing!** If this agent saved your weekend, consider giving it a ⭐ on GitHub.
