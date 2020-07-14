FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /app/index.html
COPY style.css /app/style.css
EXPOSE 8080
CMD [ "nginx", "-g", "daemon off;" ]