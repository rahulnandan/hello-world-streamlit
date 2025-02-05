FROM --platform=linux/amd64 python:3.11-slim-bullseye AS build
WORKDIR /app
COPY start.py requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt
ENV OTEL_EXPORTER_OTLP_ENDPOINT=${OTEL_EXPORTER_OTLP_ENDPOINT}
ENV OTEL_SERVICE_NAME=${OTEL_SERVICE_NAME}
RUN opentelemetry-bootstrap -a install
EXPOSE 8501
ENTRYPOINT ["opentelemetry-instrument", "streamlit", "run", "start.py"]


