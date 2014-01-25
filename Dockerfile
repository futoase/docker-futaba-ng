FROM saltstack/ubuntu-13.10-minimal

MAINTAINER Keiji Matsuzaki <futoase@gmail.com>

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y software-properties-common 
RUN apt-get install -y python-software-properties
RUN apt-add-repository -y ppa:ondrej/php5
RUN apt-add-repository -y ppa:nginx/stable
RUN apt-add-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y wget curl php5 nginx git nodejs --force-yes

RUN npm -g install grunt-cli

RUN git clone https://github.com/futoase/futaba-ng.git /root/futaba-ng
RUN cd /root/futaba-ng/app; npm install
RUN cd /root/futaba-ng/app; grunt concat:models
RUN cd /root/futaba-ng/app; grunt concat:futaba

ADD ./template/nginx.conf /etc/nginx/sites-available/futaba-ng.conf
RUN ln -s /etc/nginx/sites-available/futaba-ng.conf /etc/nginx/sites-enabled/futaba-ng.conf
RUN rm /etc/nginx/sites-enabled/default
RUN service nginx restart

ADD ./startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

EXPOSE 80

CMD ["/root/startup.sh"]
