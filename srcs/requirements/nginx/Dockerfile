FROM debian:11.9

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

# # Copy SSL certificates
# COPY certs/your_certificate.crt /etc/ssl/certs/
# COPY private/your_certificate.key /etc/ssl/private/

EXPOSE 443 80

CMD ["nginx", "-g", "daemon off;"]