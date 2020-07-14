FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /app/index.html
# RUN rm -Rf /var/cache/nginx
# USER 1001
EXPOSE 8080
CMD [ "nginx", "-g", "daemon off;" ]