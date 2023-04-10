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
data_ppm =  "987"

def function_send(sensor, data):

    sensor_ID = sensor # inNO
    data_ppm = data # 123456789

    '''
    ### write to the file 
    ### 目前 data 寫不進檔案
    file = open('C_call_py.txt', 'w')
    file.write('here: ' + sensor_ID)
    file.close()
    '''
    
    # while(1):

    # add time
    dateandtime = str(datetime.now().isoformat(timespec='seconds'))
    file = open('C_call_py.txt', 'w')
    file.write(dateandtime)
    file.close()

    dateandtime = dateandtime.replace('T',',')
    print('dateandtime:',dateandtime)


    # payload_inNO = 'inNO,' + dateandtime + ',' + data_ppm
    payload_inNO = sensor_ID + ',' + dateandtime + ',' + data_ppm
    print(payload_inNO)
    
    
    client_mqtt.publish('denox/topic', payload=payload_inNO, qos=0, retain=False)
    print(f"send {payload_inNO} to denox/topic")
    # client_mqtt.publish('payload_inNO', payload=payload_inNO, qos=0, retain=False)
    # print(f"send {payload_inNO} to payload_inNO")


    print("~~~~~~~~~~~~~~~~~")
    
    # time.sleep(5);

    return sensor, data 

if __name__ == '__main__':

    ### be called from the C# !
    print(function_send(sys.argv[1],sys.argv[2]))
    
    
    ### test on local 
    # print(function_send(sensor_ID,data_ppm))
