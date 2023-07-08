ARG OS_VER

FROM rockylinux:${OS_VER}

ARG JAVA_VER
ARG PY_VER


RUN yum install java-${JAVA_VER}-openjdk java-${JAVA_VER}-openjdk-devel -y

RUN yum install openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel crontabs cronie -y \
    && yum install net-tools wget gcc git rsync openssh-server openssh openssh-clients sshpass -y

RUN cd /usr/src \
    && wget https://www.python.org/ftp/python/${PY_VER}/Python-${PY_VER}.tgz \
    && tar -xzf Python-${PY_VER}.tgz \
    && cd Python-${PY_VER} \
    && ./configure --enable-optimizations \
    && make install

RUN pip3 install --upgrade pip
RUN pip3 install numpy pandas matplotlib seaborn statsmodels

