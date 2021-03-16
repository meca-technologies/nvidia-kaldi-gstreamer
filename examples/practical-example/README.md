#Nvidia-kaldi-gstreamer example

1. Build
    ```
    docker build . --tag gstream
    ```
1. Run 
    ```
    ./download_models.sh
    ```
1. Next mount the created models folder to the docker on /opt/models.

set -e ENV variables
available options and default

ENV |Description| Default Value
--------|--------|--------
PORT|Port for master|80
MASTER|URL for master|localhost
WORKERS|Number of workers|1


To run an instance of master and 15 workers run this:
```
./downloads_models.sh &&\ 
docker run -d --rm -p 8080:80 -e WORKERS=15 -v $(PWD)/models:/opt/models --name gstreamer_15workers gstream
```

To run an instance of just 15 workers and direct to different master on gstream.url:8080 run this:
```
./downloads_models.sh &&\ 
docker run -d --rm -p 8080:80 -e MASTER=gstream.url -e PORT=8080 -e WORKERS=15 -v $(PWD)/models:/opt/models --name gstreamer_15workers gstream
```
