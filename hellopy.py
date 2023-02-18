# hellopy.py
import sys
import time

# mqtt
from datetime import datetime
import paho.mqtt.client as mqtt


# mqtt connect
def on_connect(client_mqtt, userdata, flags, rc):
    print(f"Connected with resultcode {rc}")

# mqtt
client_mqtt = mqtt.Client()
client_mqtt.on_connect = on_connect
client_mqtt.connect("broker.emqx.io", 1883, 60)

sensor_ID = "1111"
data_ppm =  "111111111"

def function_send(sensor, data):

    sensor_ID = sensor
    data_ppm = data

    '''
    ### write to the file 
    ### 目前 data 寫不進檔案
    file = open('C_call_py.txt', 'w')
    file.write('here: ' + sensor_ID)
    file.close()
    '''
    
    while(1):

        # add time
        dateandtime = str(datetime.now().isoformat(timespec='seconds'))
        dateandtime = dateandtime.replace('T',',')
        print('dateandtime:',dateandtime)

        payload_NH3 = 'NH3,'+dateandtime+','+data_ppm
        print(payload_NH3)

        client_mqtt.publish('itris300/topic', payload=payload_NH3, qos=0, retain=False)
        print(f"send {payload_NH3} to itris300/topic")
        # client_mqtt.publish('denox/sensor1', payload=payload_NH3, qos=0, retain=False)
        # print(f"send {payload_NH3} to denox/sensor1")


        print("~~~~~~~~~~~~~~~~~")
        
        time.sleep(5);


    sensor = sensor + data
    return sensor, data 

if __name__ == '__main__':

    # be called from the C# !
    # print(function_send(sys.argv[1],sys.argv[2]))
    
    # test on local 
    print(function_send(sensor_ID,data_ppm))

