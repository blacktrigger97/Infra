FROM rockylinux:latest

RUN yum install java-11-openjdk java-11-openjdk-devel -y

RUN yum install openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel -y \
    && yum install net-tools wget gcc git -y

RUN yum install openssh-server openssh-clients -y

RUN cd /usr/src \
    && wget https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tgz \
    && tar -xzf Python-3.11.2.tgz \
    && cd Python-3.11.2 \
    && ./configure --enable-optimizations \
    && make install

RUN pip3 install --upgrade pip

RUN pip3 install numpy pandas matplotlib seaborn statsmodels    

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN /usr/sbin/sshd

EXPOSE 22
