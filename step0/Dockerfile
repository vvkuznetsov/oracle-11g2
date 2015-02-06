FROM vvkuznetsov/centos7-ssh
#FROM vvkuznetsov/centos7-ssh
MAINTAINER Valentin Kuznetsov <valentin.kuznetsov@start-i.ru>

ADD linux.x64_11gR2_database_1of2.zip /app/setup/linux.x64_11gR2_database_1of2.zip
ADD linux.x64_11gR2_database_2of2.zip /app/setup/linux.x64_11gR2_database_2of2.zip
RUN yum -y install unzip
RUN cd /app/setup && unzip linux.x64_11gR2_database_1of2.zip && unzip linux.x64_11gR2_database_2of2.zip && rm *.zip