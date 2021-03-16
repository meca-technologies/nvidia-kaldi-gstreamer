FROM nvcr.io/nvidia/kaldi:21.02-py3
MAINTAINER Derek Bartoli

RUN apt-get update && apt-get install -y  \
    procps \
    autoconf \
    automake \
    bzip2 \
    g++ \
    git \
    gstreamer1.0-plugins-good \
    gstreamer1.0-tools \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-ugly  \
    libatlas3-base \
    libgstreamer1.0-dev \
    libtool-bin \
    libasound-dev \
    make \
    python3-pip \
    python3-yaml \
    python3-simplejson \
    python3-gi \
    subversion \
    unzip \
    wget \
    build-essential \
    python-dev \
    sox \
    zlib1g-dev && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    pip3 install tornado

WORKDIR /opt

RUN wget http://www.digip.org/jansson/releases/jansson-2.7.tar.bz2 && \
    bunzip2 -c jansson-2.7.tar.bz2 | tar xf -  && \
    cd jansson-2.7 && \
    ./configure && make -j $(nproc) && make check &&  make install && \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/jansson.conf && ldconfig && \
    rm /opt/jansson-2.7.tar.bz2 && rm -rf /opt/jansson-2.7
RUN cd /opt/kaldi/tools && rm -rf portaudio && ./install_portaudio.sh
RUN cd /opt/kaldi/src/gst-plugin && sed -i 's/-lmkl_p4n//g' Makefile && make depend -j $(nproc) && make -j $(nproc)
RUN cd /opt && \
    git clone https://github.com/alumae/gst-kaldi-nnet2-online.git && \
    cd /opt/gst-kaldi-nnet2-online/src && \
    sed -i '/KALDI_ROOT?=\/home\/tanel\/tools\/kaldi-trunk/c\KALDI_ROOT?=\/opt\/kaldi' Makefile && head Makefile && \
    make depend -j $(nproc) && make -j $(nproc) && \
    rm -rf /opt/gst-kaldi-nnet2-online/.git/ && \
    find /opt/gst-kaldi-nnet2-online/src/ -type f -not -name '*.so' -delete && \
    rm -rf /opt/kaldi/.git && \
    rm -rf /opt/kaldi/egs/ /opt/kaldi/windows/ /opt/kaldi/misc/ && \
    find /opt/kaldi/src/ -type f -not -name '*.so' -delete && \
    find /opt/kaldi/tools/ -type f \( -not -name '*.so' -and -not -name '*.so*' \) -delete && \
    cd /opt && git clone https://github.com/alumae/kaldi-gstreamer-server.git -b py3 && \
    rm -rf /opt/kaldi-gstreamer-server/.git/ && \
    rm -rf /opt/kaldi-gstreamer-server/test/

COPY start.sh stop.sh /opt/
COPY worker.py /opt/kaldi-gstreamer-server/kaldigstserver/

RUN chmod +x /opt/start.sh && \
    chmod +x /opt/stop.sh 
