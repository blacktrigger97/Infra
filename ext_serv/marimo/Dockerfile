FROM ghcr.io/marimo-team/marimo:latest

# Install uv for fast package management
COPY --from=ghcr.io/astral-sh/uv:0.4.20 /uv /bin/uv
ENV UV_SYSTEM_PYTHON=1

# Copy requirements file
COPY --link requirements.txt .

# Install the requirements using uv
RUN uv pip install -r requirements.txt

RUN apt update && apt upgrade -y && apt-get -y install wget

RUN mkdir /root/notebooks

WORKDIR /root/notebooks

CMD ["marimo", "edit", "--no-token", "-p", "8091", "--host", "marimo"]
