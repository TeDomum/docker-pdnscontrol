FROM debian:jessie

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git python-pip python-virtualenv python-mysqldb  \
 && apt-get clean

RUN git clone https://github.com/kaiyou/pdnscontrol.git \
 && cd pdnscontrol \
 && git checkout master

ADD requirements.txt .
RUN pip install -r requirements.txt

ADD pdnscontrol.conf /pdnscontrol/instance/

RUN cd /pdnscontrol && python manage.py assets --parse-templates build

EXPOSE 5000

CMD ["/pdnscontrol/pdnscontrold"]
