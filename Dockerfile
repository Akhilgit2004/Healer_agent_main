# 1. Use Python as the base
FROM python:3.11-slim

# 2. Install SYSTEM DEPENDENCIES (Critical for "verify_fix")
# We need GCC for C++, Node for JS, and Git for pushing fixes.
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 3. Set the working directory
WORKDIR /app

# 4. Copy the package files
COPY pyproject.toml .
COPY requirements.txt .
COPY src/ ./src/
#COPY README.md . 

# 5. Install the Healer Agent as a CLI
RUN pip install --no-cache-dir .

# 6. Define where the logs will live
# We use a Volume so the container can see the logs on your host machine
VOLUME /logs

# 7. The Entrypoint
# This turns the container into the "healer" command itself.
ENTRYPOINT ["healer"]

# Default argument if the user provides nothing
CMD ["--help"]