# download the latest version of ubuntu
FROM ubuntu:latest

WORKDIR /opt/bin

COPY cpu_count.sh .

RUN chmod u+x /opt/bin/cpu_count.sh

CMD ["/opt/bin/cpu_count.sh"]