FROM python:3.7.3-stretch

LABEL maintainer="Damjan Dvoršek"

RUN wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
            chmod +x /bin/hadolint && pip install pylint 