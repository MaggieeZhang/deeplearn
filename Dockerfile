FROM centos:centos7

RUN yum install -y wget dos2unix unzip tmpwatch ntpdate graphviz ntp libaio-devel snappy-devel sendmail jemalloc cyrus-sasl-gssapi logrotate kexec-tools

COPY setuptools-39.0.1.zip /
RUN unzip setuptools-39.0.1.zip
WORKDIR /setuptools-39.0.1
RUN python setup.py install

WORKDIR /
ADD pip-10.0.0.tar.gz /
WORKDIR pip-10.0.0
RUN python setup.py install
 
RUN pip install tensorflow==1.1 -i https://pypi.douban.com/simple
WORKDIR /
COPY dl.py /
RUN dos2unix dl.py
#RUN python dl.py
ENV TF_NEED_CUDA=0
ENV TF_CPP_MIN_LOG_LEVEL=2 
CMD /bin/bash
