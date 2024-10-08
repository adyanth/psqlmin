ARG PG_VERSION="17-bullseye"

FROM postgres:${PG_VERSION}

RUN apt update && apt install -y curl
RUN bash -c "yes | sh - <(curl -o- https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh)"
RUN apt install -y webmin libdbd-pg-perl --install-recommends
RUN sed -i -e 's/ssl=.*/ssl=0/' /etc/webmin/miniserv.conf && \
    sed -i -e 's/no_testing_cookie=.*/no_testing_cookie=1/' \
        /etc/webmin/miniserv.conf
COPY start.sh .
ENTRYPOINT ["./start.sh"]
CMD ["postgres"]
