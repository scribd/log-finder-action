FROM alpine:3.10

WORKDIR /code

COPY entrypoint.sh .

ENTRYPOINT ["/code/entrypoint.sh"]