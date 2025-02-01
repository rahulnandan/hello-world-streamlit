FROM --platform=linux/amd64 python:slim-bullseye AS build
COPY streamlit.py .
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV OTEL_EXPORTER_OTLP_ENDPOINT=${OTEL_EXPORTER_OTLP_ENDPOINT}
ENV OTEL_SERVICE_NAME=${OTEL_SERVICE_NAME}
RUN opentelemetry-bootstrap -a install
ENTRYPOINT ["opentelemetry-instrument", "streamlit", "run", "streamlit.py"]
EXPOSE 8501

