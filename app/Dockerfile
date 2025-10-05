FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11-slim
RUN groupadd -r appuser && useradd -r -g appuser -u 1001 appuser
WORKDIR /app
COPY --from=builder /root/.local /home/appuser/.local
COPY --chown=appuser:appuser app.py wsgi.py ./
ENV PATH=/home/appuser/.local/bin:$PATH
USER appuser
EXPOSE 5000
HEALTHCHECK --interval=30s CMD python -c "import requests; requests.get('http://localhost:5000/health', timeout=2)" || exit 1
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "wsgi:app"]