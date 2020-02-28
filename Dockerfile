FROM nginx

COPY . /usr/share/nginx/html/
COPY ./vhost.nginx.conf /etc/nginx/conf.d/yuuki-wang.info

EXPOSE 80