docker build -t alpine-python .
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run -p 80:80 -p 3500:3500 -d --privileged=true --name alpine-python alpine-python

docker ps
