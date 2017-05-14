FROM ubuntu

RUN apt-get update
RUN apt-get install -y apt-utils vim curl apache2 apache2-utils
RUN apt-get -y install python3 libapache2-mod-wsgi-py3
RUN ln /usr/bin/python3 /usr/bin/python
RUN apt-get -y install python3-pip
RUN ln /usr/bin/pip3 /usr/bin/pip
RUN pip install --upgrade pip
RUN pip install django ptvsd
ADD ./demo_site.conf /etc/apache2/sites-available/000-default.conf
#COPY www/* /var/www/html/

######### Install Elastic file system ############
RUN apt-get install nfs-common -y
# EFS_URL - URL of the elastic file system
RUN mkdir /efs

CMD apt-get update -y && \
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${EFS_URL}:/ efs && \
mount --bind --verbose /efs/debian/jenkins_home/workspace/django /var/www/html && \
apache2ctl -DFOREGROUND
##################################################

EXPOSE 80 3500
