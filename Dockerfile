FROM python:3.11-slim

# 1. Install System Tools (Node, GCC, etc.)
RUN apt-get update && apt-get install -y \
    build-essential curl git \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 2. THE CACHE TRICK: Copy ONLY the requirement files first
COPY pyproject.toml requirements.txt ./

# 3. Download the "Heavy Stuff" here. 
# This layer will be CACHED and never run again unless you change pyproject.toml
RUN pip install --no-cache-dir -r requirements.txt

# 4. Now copy your source code (the stuff that changes often)
COPY src/ ./src/
COPY README.md . 

# 5. Install your agent without re-downloading anything
# --no-deps tells pip "I already downloaded the requirements, just install the script"
RUN pip install --no-deps .

ENTRYPOINT ["healer"]