import pika
import os
import math
from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS


class Analytics():
#### variables de datos ######################
    max_value = -math.inf
    min_value = math.inf
    step_count = 0
    step_sum = 0
    days_100k = 0
    days_5k = 0
    prev_value = 0
    days_consecutive = 0


################ variables de control #################
    bucket = 'rabbit'
    token = 'token-secret'
    url = 'http://influx:8086'
    org = 'org'
#### escritura en influx  ######################
    def write_db(self, tag, key, value):
        client= InfluxDBClient(url=self.url, token=self.token, org=self.org)
        write_api = client.write_api(write_options=SYNCHRONOUS)
        point = Point('analitica').tag("Descriptive", tag).field(key, value)
        write_api.write(bucket=self.bucket, record=point)
#### maximo valor  ######################
    def add_max_value(self, _medida):
        if _medida > self.max_value:
            self.max_value = _medida
        self.write_db('pasos', "maximo", self.max_value)
#### minimo valor ######################    
    def add_min_value(self, _medida):
        if _medida < self.min_value:
            self.min_value = _medida
        self.write_db('pasos', "minimo", self.min_value)
#### promedio ######################
    def get_prom(self, _medida):
        self.step_count += 1
        self.step_sum += _medida
        promedio = self.step_sum/self.step_count
        self.write_db('pasos', "promedio", promedio)

    def get_days_100k(self, _medida):
        if _medida >= 100000:
            self.days_100k += 1
        self.write_db('pasos', "marca_100k", self.days_100k)

    def get_days_5k(self, _medida):
        if _medida <= 5000:
            self.days_5k += 1
        self.write_db('pasos', "marca_5k", self.days_5k)

    def get_consecutive_days(self, _medida):
        if _medida >= self.prev_value:
            self.days_consecutive += 1
        else:
            self.days_consecutive = 0
        self.prev_value = _medida
        self.write_db('pasos', "dias_superandose", self.days_consecutive)
    

    
    def take_measurement(self,_dato ):
        dato = _dato.split("=")
        datos = float(dato[-1])
        print(" dato enviado", flush=True)
        self.add_max_value(datos)
        self.add_min_value(datos)
        self.get_prom(datos)
        self.get_days_100k(datos)
        self.get_days_5k(datos)
        self.get_consecutive_days(datos)
        
if __name__ == '__main__':

    analytics = Analytics()
    def callback(ch, method, properties, body):
        global analytics
        message = body.decode("utf-8")
        analytics.take_measurement(message)

    url = os.environ.get('AMQP_URL','amqp://user:pass@rabbit:5672/%2f')
    params = pika.URLParameters(url)
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    ##channel.queue_declare(queue='pasos')
    channel.queue_bind(exchange='amq.topic', queue='pasos', routing_key='#')    
    channel.basic_consume(queue='pasos', on_message_callback=callback, auto_ack=True)
    channel.start_consuming()