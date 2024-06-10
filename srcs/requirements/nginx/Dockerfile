#base image
FROM debian:11.9

#install dependencies
RUN apt update && apt install -y nginx openssl

RUN mkdir -p /run/nginx

#copy the actual file in the image during the building process
COPY conf/nginx.conf /etc/nginx/nginx.conf 

#DOCUMENT (not actually expose yet) the port the container listens on at runtime.
EXPOSE 80 443

#command to run the container
CMD ["nginx", "-g", "daemon off;"]