#--builder---
FROM python:3.11-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

#system deps (for psycopg2-binary build or other packages)
RUN apt-get update && apt-get install -y build-essential libpq-dev

#Install poetry
RUN pip install --upgrade pip && pip install poetry

#Export a requirements.txt without hashes (works for poetry>=1.2)
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

#Install runtime dependencies into the image
RUN pip install -r requirements.txt

#--final image--
FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

#Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages

COPY . /app

#collect static in production flow, here we just expose run command
EXPOSE 8000

CMD ["gunicorn","config.wsgi:application", "--bind", "0.0.0.0:8000"]
