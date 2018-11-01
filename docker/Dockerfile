FROM ubuntu

RUN apt-get update

RUN apt-get install -y curl
RUN curl -sSL https://get.haskellstack.org/ | sh
ENV PATH=/root/.local/bin:${PATH}
RUN stack install happy

COPY stack.yaml penrose.cabal /penrose/
WORKDIR /penrose
RUN stack --jobs 1 build --dependencies-only  # Without --jobs 1 this runs out of memory in a 2GB container.

COPY src /penrose/src
COPY test /penrose/test
COPY ChangeLog.md LICENSE README.md /penrose/
RUN stack install --ghc-options '-optl-static -fPIC'  # statically linked penrose executable

FROM alpine

COPY src /penrose/src
COPY --from=0 /root/.local/bin/penrose /usr/local/bin/penrose

# -- To use the alloy java library, change the `FROM alpine` line to this:
# FROM openjdk:8-alpine
# -- And uncomment the following:
# WORKDIR /penrose/src
# RUN apk add --update make
# RUN make -B

RUN apk add --update mini_httpd

EXPOSE 8000 9160

WORKDIR /penrose

COPY docker/entrypoint /penrose/entrypoint
ENTRYPOINT ["/penrose/entrypoint"]
CMD ["/penrose/src/linear-algebra-domain/vectorsAddition.sub", \
     "/penrose/src/linear-algebra-domain/linear-algebra.sty", \
     "/penrose/src/linear-algebra-domain/linear-algebra.dsl"]
