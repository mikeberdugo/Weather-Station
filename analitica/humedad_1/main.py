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
    url = 'http://20.87.221.208:8086'
    org = 'org'
#### escritura en influx  ######################
    def write_db(self, tag, key, value):
        client= InfluxDBClient(url=self.url, token=self.token, org=self.org)
        write_api = client.write_api(write_options=SYNCHRONOUS)
        point = Point('analitica').tag("Descriptive", tag).field(key, value)
        write_api.write(bucket=self.bucket, record=point)

#### promedio ######################
    def get_prom(self, _medida):
        self.step_count += 1
        self.step_sum += _medida
        promedio = self.step_sum/self.step_count
        self.write_db('anali', "promedio", promedio)
    
    def take_measurement(self,_dato ):
        dato = _dato.split("=")
        datos = float(dato[-1])
        print(" dato enviado", flush=True)
        self.get_prom(datos)
        
if __name__ == '__main__':

    analytics = Analytics()
    def callback(ch, method, properties, body):
        global analytics
        message = body.decode("utf-8")
        analytics.take_measurement(message)

    url = os.environ.get('AMQP_URL','amqp://mike:berdugo13@20.87.221.208:5672/%2f')
    params = pika.URLParameters(url)
    connection = pika.BlockingConnection(params)
    channel = connection.channel()
    channel.queue_declare(queue='variables')
    channel.queue_bind(exchange='amq.topic', queue='variables', routing_key='#')    
    channel.basic_consume(queue='variables', on_message_callback=callback, auto_ack=True)
    channel.start_consuming()