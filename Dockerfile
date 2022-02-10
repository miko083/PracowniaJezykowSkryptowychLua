FROM openresty/openresty:latest

VOLUME /var/source-code
RUN mkdir /var/app

RUN apt -y update && apt install -y lua5.4 luarocks libssl-dev && luarocks install lapis && luarocks install moonscript

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD update.sh /usr/local/bin/update.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/update.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
