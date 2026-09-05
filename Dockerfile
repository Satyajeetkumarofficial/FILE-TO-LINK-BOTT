FROM python:3.12-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt
RUN python -m pip install --upgrade pip && python -m pip install -r /requirements.txt

WORKDIR /rexbots
COPY . /rexbots

RUN ffmpeg -version >/dev/null 2>&1 && ffprobe -version >/dev/null 2>&1

CMD ["python", "bot.py"]
