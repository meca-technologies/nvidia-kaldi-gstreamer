FROM macide/nvidia-kaldi-gstreamer

# This is the practical example part

RUN apt-get update && \
    apt-get install -y supervisor && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY startme.sh /opt/

EXPOSE 80

CMD ["/opt/startme.sh"]
