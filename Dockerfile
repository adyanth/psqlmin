FROM postgres:${PG_VERSION:-17-bullseye}

RUN apt update && apt install -y curl
RUN bash -c "yes | sh - <(curl -o- https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh)"
RUN apt install -y webmin libdbd-pg-perl --install-recommends
RUN sed -i -e 's/ssl=.*/ssl=0/' /etc/webmin/miniserv.conf && \
    sed -i -e 's|hba_conf=.*|hba_conf=/var/lib/postgresql/data/pg_hba.conf|' \
        /etc/webmin/postgresql/config && \
    echo OK
COPY start.sh .
ENTRYPOINT ["./start.sh"]
CMD ["postgres"]
