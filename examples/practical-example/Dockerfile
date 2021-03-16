cd /mnt/drived/code/stt/models/ && \
    wget --no-check-certificate https://phon.ioc.ee/~tanela/tedlium_nnet_ms_sp_online.tgz && \
    tar -zxvf tedlium_nnet_ms_sp_online.tgz && \
    wget https://raw.githubusercontent.com/alumae/kaldi-gstreamer-server/py3/sample_english_nnet2.yaml -P /mnt/drived/code/stt/models/ && \
    find /mnt/drived/code/stt/models/ -type f | xargs sed -i 's:test:/opt:g' && \
    sed -i 's:full-post-processor:#full-post-processor:g' /mnt/drived/code/stt/models/sample_english_nnet2.yaml