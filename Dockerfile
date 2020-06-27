FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y libssl-dev gcc make wget tar

RUN wget https://github.com/nginx/nginx/archive/release-1.4.0.tar.gz && tar xfv release-1.4.0.tar.gz
RUN cd nginx-release-1.4.0 && ./auto/configure --without-http_rewrite_module --without-http_gzip_module && make install

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]