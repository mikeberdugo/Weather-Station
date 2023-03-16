FROM rabbitmq:3.11.7-management

COPY rabbitmq/rabbitmq.conf /etc/rabbitmq
COPY rabbitmq/definitions.json /etc/rabbitmq

RUN cat /etc/rabbitmq/rabbitmq.conf


RUN rabbitmq-plugins enable rabbitmq_mqtt
RUN rabbitmq-plugins enable rabbitmq_web_mqtt

