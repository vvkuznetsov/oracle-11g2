FROM vvkuznetsov/oracle-11g2-assets
MAINTAINER Valentin Kuznetsov <valentin.kuznetsov@start-i.ru>

COPY assets/setup /app/setup

RUN yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33.i686 gcc gcc-c++ glibc.i686 glibc glibc-devel glibc-devel.i686 ksh libgcc.i686 libgcc libstdc++ libstdc++.i686 libstdc++-devel libstdc++-devel.i686 libaio libaio.i686 libaio-devel libaio-devel.i686 libXext libXext.i686 libXtst libXtst.i686 libX11 libX11.i686 libXau libXau.i686 libxcb libxcb.i686 libXi libXi.i686 make smartmontools

RUN groupadd -g 54321 oinstall && groupadd -g 54322 dba
RUN useradd -m -u 54321 -g oinstall -G dba oracle
RUN echo "oracle:oracle" | chpasswd

ENV ORACLE_SID ioss
ENV ORACLE_BASE /u01/app/oracle

RUN mkdir -p $ORACLE_BASE && chown -R oracle:oinstall $ORACLE_BASE && chmod -R 775 $ORACLE_BASE
RUN mkdir -p /u01/app/oraInventory && chown -R oracle:oinstall /u01/app/oraInventory && chmod -R 775 /u01/app/oraInventory

ADD assets/etc/oraInst.loc /etc/oraInst.loc
RUN chmod 664 /etc/oraInst.loc
ADD assets/etc/sysctl.conf /etc/sysctl.conf
RUN echo "oracle soft stack 10240" >> /etc/security/limits.conf

ENV CVUQDISK_GRP oinstall
RUN cd /app/setup/database/rpm && rpm -iv cvuqdisk-1.0.7-1.rpm


# Install
# RUN /app/setup/install && rm -rf /app/setup

ENV ORACLE_HOME $ORACLE_BASE/11.2.0/db1
ENV PATH $ORACLE_HOME/bin:$PATH

# Post install script
# RUN $ORACLE_HOME/root.sh


EXPOSE 1521

# VOLUME ["/u01/app/oracle"]
# VOLUME ["/u01/app/oraInventory"]

ADD assets/init /app/init
RUN chmod 755 /app/init

ENTRYPOINT ["/app/init"]