FROM ghcr.io/marimo-team/marimo:latest

# Install any additional dependencies here

WORKDIR /root

RUN mkdir notebooks

CMD ["marimo", "edit", "--no-token", "-p", "8091", "--host", "marimo.bdc.home"]