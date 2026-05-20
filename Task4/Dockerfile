FROM nginx:1.25-alpine
ENV DEVOPS=Diana
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
