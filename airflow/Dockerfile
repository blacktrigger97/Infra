ARG AIRFLOW_IMAGE_NAME

FROM apache/airflow:${AIRFLOW_IMAGE_NAME}

COPY requirements.txt .
RUN pip install --no-cache-dir -r apache-airflow==${AIRFLOW_IMAGE_NAME} requirements.txt