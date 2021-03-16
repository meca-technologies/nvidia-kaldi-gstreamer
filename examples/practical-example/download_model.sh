DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
mkdir -p ${DIR}/models && cd ${DIR}/models && \
    wget --no-check-certificate https://phon.ioc.ee/~tanela/tedlium_nnet_ms_sp_online.tgz && \
    tar -zxvf tedlium_nnet_ms_sp_online.tgz && \
    wget https://raw.githubusercontent.com/alumae/kaldi-gstreamer-server/master/sample_english_nnet2.yaml -P ${DIR}/models && \
    find ${DIR}/models/ -type f | xargs sed -i 's:test:/opt:g' && \
    sed -i 's:full-post-processor:#full-post-processor:g' ${DIR}/models/sample_english_nnet2.yaml