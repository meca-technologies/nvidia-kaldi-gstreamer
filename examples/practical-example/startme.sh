WORKERS="${WORKERS:=1}"
MASTER="${MASTER:=localhost}"
PORT="${PORT:=80}"
echo '[supervisord]
nodaemon=true

' > /etc/supervisor/conf.d/supervisord.conf
if [[ $MASTER = "localhost" ]]
then 
    echo '[program:master]
command=python3 /opt/kaldi-gstreamer-server/kaldigstserver/master_server.py --port='$PORT'
numprocs=1
autostart=true
autorestart=true
stderr_logfile=/opt/master.log

' >> /etc/supervisor/conf.d/supervisord.conf
fi
echo '[program:worker]
process_name=%(program_name)s_%(process_num)02d
environment=GST_PLUGIN_PATH=/opt/gst-kaldi-nnet2-online/src/:/opt/kaldi/src/gst-plugin/
command=python3 /opt/kaldi-gstreamer-server/kaldigstserver/worker.py -c /opt/models/sample_english_nnet2.yaml -u ws://'$MASTER':'$PORT'/worker/ws/speech
numprocs='$WORKERS'
autostart=true
autorestart=true
stderr_logfile=/opt/worker.log' >> /etc/supervisor/conf.d/supervisord.conf

/usr/bin/supervisord