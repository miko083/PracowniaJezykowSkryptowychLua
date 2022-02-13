FROM openresty/openresty:latest

VOLUME /var/source-code
RUN mkdir /var/app
COPY categories.csv /tmp/
COPY products.csv /tmp/

RUN apt -y update && apt install -y lua5.4 luarocks libssl-dev postgresql git && luarocks install lapis && luarocks install luabitop && luarocks install moonscript
USER postgres
RUN  /etc/init.d/postgresql start && psql --command "CREATE USER lapis WITH SUPERUSER PASSWORD 'lapis123';" && createdb -O lapis lapis-db && psql --dbname lapis-db --command "CREATE TABLE categories (name varchar(255) PRIMARY KEY);" && psql --dbname lapis-db --command "CREATE TABLE products ( id SERIAL PRIMARY KEY, name varchar(255), price int, categoryName varchar(255), FOREIGN KEY (categoryName) REFERENCES categories(name));" && psql --dbname lapis-db --command " COPY categories(name) FROM '/tmp/categories.csv' DELIMITERS ',' CSV header;" && psql --dbname lapis-db --command " COPY products(name, price, categoryName) FROM '/tmp/products.csv' DELIMITERS ',' CSV header;"  

USER root
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD update.sh /usr/local/bin/update.sh

RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/update.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
