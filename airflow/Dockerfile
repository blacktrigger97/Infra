ARG AIRFLOW_IMAGE_NAME

FROM apache/airflow:${AIRFLOW_IMAGE_NAME}

ARG AIRFLOW_IMAGE_NAME

COPY requirements.txt .
RUN pip install --no-cache-dir apache-airflow==${AIRFLOW_IMAGE_NAME} -r requirements.txt