FROM ubuntu

RUN apt-get update

RUN apt-get install -y build-essential haskell-stack zlib1g-dev
RUN stack upgrade
ENV PATH=/root/.local/bin:${PATH}
RUN stack install happy

COPY stack.yaml penrose.cabal /penrose/
WORKDIR /penrose
RUN stack --jobs 1 build --dependencies-only  # Without --jobs 1 this runs out of memory in a 2GB container.

COPY src /penrose/src
COPY test /penrose/test
COPY ChangeLog.md LICENSE README.md /penrose/
RUN stack build
ENV PATH=/penrose/.stack-work/install/x86_64-linux/lts-9.10/8.0.2/bin:${PATH}

RUN apt-get install -y openjdk-8-jdk
WORKDIR /penrose/src
RUN make -B

RUN apt-get install -y python3 tmux net-tools

EXPOSE 8000 9160
CMD bash -c "(python3 -m http.server &) && \
    penrose \
    linear-algebra-domain/twoVectors.sub \
    linear-algebra-domain/linear-algebra.sty \
    linear-algebra-domain/linear-algebra.dsl"
