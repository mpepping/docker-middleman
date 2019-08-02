FROM ruby:2.5-alpine3.9 as builder

LABEL mainainer "Martijn Pepping <martijn.pepping@automiq.nl>"

RUN apk --update add alpine-sdk nodejs && \
    gem install middleman

FROM ruby:2.5-alpine3.9

RUN apk --update add nodejs
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

EXPOSE 4567

ENTRYPOINT ["middleman"]
CMD ["--help"]
