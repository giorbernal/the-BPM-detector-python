FROM python:3.6.8
MAINTAINER "Gior Bernal"

RUN apt-get update && \
    apt-get -y install ffmpeg

RUN pip install --upgrade pip && \
    pip install numpy && \
    pip install pandas && \
    pip install matplotlib && \
    pip install scipy && \
    pip install pywavelets

RUN ["mkdir", "opt/app"]
RUN ["mkdir", "opt/workdir"]

COPY scripts/ /opt/app/scripts
COPY bpm_detection/ /opt/app/bpm_detection
COPY docker/entrypoint.sh /opt/app

CMD ["/opt/app/entrypoint.sh"]
