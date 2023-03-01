// import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// mqtt
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// mqtt publish
import 'package:typed_data/typed_data.dart' as typed;


//timer
import 'dart:async';

// mqttx
/*
Broker: broker.emqx.io
Name: pi_temperature
ClientID: mqttx_9a8461e6
Username:
password:
Keep Alive: 60
Clean Session:  true
Port: 1883
QoS: 0

Topic: denox/topic
*/

// mqttx setting
const url = 'pi_temperature@broker.emqx.io:1883';
const port = 1883;
const clientID = 'mqttx_9a8461e6';
const username = '';
const password = '';
MqttServerClient client =
MqttServerClient.withPort('broker.emqx.io', 'mqttx_9a8461e6', 1883);
// final client = MqttServerClient(url, clientID);
// MqttServerClient client = MqttServerClient.withPort('broker.emqx.io', 'mqttx_9a8461e6', 1883);


// mqttx temperature setting
var type = '-1';
var list_paylod =[];
var temperature_paylod;

var inNO_date = '-1';
var inNO_time = '-1';
var inNO_data = '-1';

var inNO2_date = '-1';
var inNO2_time = '-1';
var inNO2_data = '-1';

var outNO_date = '-1';
var outNO_time = '-1';
var outNO_data = '-1';

var outNO2_date = '-1';
var outNO2_time = '-1';
var outNO2_data = '-1';

var outH2_date = '-1';
var outH2_time = '-1';
var outH2_data = '-1';

var inTemp_date = '-1';
var inTemp_time = '-1';
var inTemp_data = '-1';

// mqtt machine setting
var machine = '-1';

// slider
double _currentSliderValue = 0;

// 1 timer
late Timer _timer;
int currentTimer = 0;


// Page3
class Page3 extends StatefulWidget {
  final String id;
  const Page3(this.id):assert( id != null, 'ID must have data');

  @override
  _Page3State createState() => _Page3State();
}

// State
// class _Page3State extends State<Page3> {
class _Page3State extends State<Page3> {

  // switch hand or auto
  late bool _isCheckON;
  late bool _isCheck;
  late bool _ispass;

  double val = 1;

  // init state
  @override
  void initState() {
    super.initState();

    _isCheckON = false;
    _isCheck = false;
    _ispass = false;

    // UI update!
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });

    // mqtt
    connect();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '氫能NOx處理設備',
            style: TextStyle(color: Colors.white),),
          leading: BackButton(onPressed: () {
            Navigator.of(context).pop('----- here !! from page 3');

            // mqtt unsubscribe & disconnect
            client.unsubscribe('denox/topic');
            client.disconnect();
            _timer.cancel();
          }),
        ),

        // body
        body:
        Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
            //child: Image.asset('assets/image/or.png'),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
          ),

          // Text('${widget.id}'),
          /*
          Text('射出機狀態：$machine', style: const TextStyle(fontSize: 20.0)),
          // Text('射出機社嘴溫度：200 ℃', style: TextStyle(fontSize: 20.0)),
          Text('射嘴溫度：$temperature_data ℃ ($temperature_time)',
              style: const TextStyle(fontSize: 20.0)),
          Text('是否清料：$clean_data ($clean_time)',
              style: const TextStyle(fontSize: 20.0)),

          // Text('氣體處理設備 (OFF/ON)：$fan_data ($fan_time) ', style: TextStyle(fontSize: 20.0)),
          Text('氣體處理設備模式 (手動/自動)：', style: TextStyle(fontSize: 20.0)),
          Switch(
            value: _isCheckON,
            onChanged: _changedON,),

          const Text('氣體處理設備風量 (關/小/中/大)： ', style: TextStyle(fontSize: 20.0)),
          Slider(
            value: val,
            onChanged: (value) {
              setState(() {
                // 0, 3, 7, 10
                val = value;
                var valInt = val.round();
                print('Value $valInt');

                // mqtt published
                // print(' -- here');
                const pubTopic = 'raspberry/control';
                final builder = MqttClientPayloadBuilder();
                final buff = typed.Uint8Buffer(1);
                if (valInt == 0) {
                  buff[0] = '0'.codeUnitAt(0); }
                if (valInt == 3) {
                  buff[0] = '3'.codeUnitAt(0); }
                if (valInt == 7) {
                  buff[0] = '7'.codeUnitAt(0); }
                if (valInt == 10) {
                  buff[0] = '9'.codeUnitAt(0); }
                client.publishMessage(pubTopic, MqttQos.exactlyOnce, buff);


                // final buff = typed.Uint8Buffer(4);
                // buff[0] = '1'.codeUnitAt(0);
                // buff[1] = 'b'.codeUnitAt(0);
                // buff[2] = 'c'.codeUnitAt(0);
                // buff[3] = 'd'.codeUnitAt(0);
                // client.publishMessage(pubTopic, MqttQos.exactlyOnce, buff);
              });
            },
            min: 0,
            max: 10,
            activeColor: Colors.green,
            inactiveColor: Colors.green[100],
            label: val.round().toString(),
            divisions: 3,
          ),
          */
          // Text('氣體處理設備風量：$fan_data ($fan_time)',
          // style: const TextStyle(fontSize: 25.0)),
          // Text('----------------------------------', style: const TextStyle(fontSize: 20.0)),

          //inNO_date
          Text('', style: const TextStyle(fontSize: 10.0)),
          Text('【Inlet 資訊】', style: const TextStyle(fontSize: 25.0)),
          Text('NO：$inNO_data ppm '
              '($inNO_time)',
              style: const TextStyle(fontSize: 25.0)),
          Text('NO2：$inNO2_data ppm ($inNO2_time)',
              style: const TextStyle(fontSize: 25.0)),
          Text('Temperature：$inTemp_data ppm ($inTemp_time)',
              style: const TextStyle(fontSize: 25.0)),

          Text('----------------------------------',
              style: const TextStyle(fontSize: 20.0)),
          Text('', style: const TextStyle(fontSize: 15.0)),
          Text('【Outlet 資訊】', style: const TextStyle(fontSize: 25.0)),
          Text('NO：$outNO_data ppm ($outNO_time)',
              style: const TextStyle(fontSize: 25.0)),
          Text('NO2：$outNO2_data ppm ($outNO2_time)',
              style: const TextStyle(fontSize: 25.0)),
          Text('H2：$outH2_data ppm ($outH2_time)',
              style: const TextStyle(fontSize: 25.0)),
          // Text('PM2.5去除後濃度：$pm_data ug/m3 ($pm_time)', style: TextStyle(fontSize: 10.0)), //, color: Color.fromARGB(255, 192, 192, 192))),
        ],)
    );
  }

  //switch hand or auto
  void _changedON(isCheckON) {
    setState(() {
      _isCheckON = !_isCheckON;

      // mqtt sent switch data - hand or auto
      print('here!!!!!!!!');
      print(_isCheckON);


      const pubTopic = 'denox/control';
      // final builder = MqttClientPayloadBuilder();
      final buff = typed.Uint8Buffer(1);
      if (_isCheckON == true) {
        buff[0] = 'A'.codeUnitAt(0);
      }
      else {
        buff[0] = 'H'.codeUnitAt(0);
      }
      client.publishMessage(pubTopic, MqttQos.exactlyOnce, buff);
    });
  }


// connection succeeded
  void onConnected() {
    print('Succeeded Connected');
  }

// unconnected
  void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
    print('subscribe !');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    print('Ping response client callback invoked');
  }


// mqtt subscribe, topic is denox/topic
  Future<MqttServerClient> connect() async {
    // MqttServerClient client =
    // MqttServerClient.withPort('broker.emqx.io', 'mqttx_9a8461e6', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    // client.onUnsubscribed = onUnsubscribed as UnsubscribeCallback?;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs(username, password)
    // .keepAliveFor(60)
    // .withWillTopic('raspberry/topic')
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }


    // temperature
    const topic = 'denox/topic';

    // subscribe
    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final message = c![0].payload as MqttPublishMessage;
      final payload =
      MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('----------- payload: ' + payload);

      temperature_paylod = payload;
      print(temperature_paylod.split(','));
      list_paylod = payload.split(',');
      // print(list_temperature_paylod[2]);

      type = list_paylod[0];
      print('type: $type');

      if (type == '4') {
        print('connect to cloud, but could not get the data');
        machine = '-1';
      }

      if (type == 'inNO') {
        inNO_date = list_paylod[1];
        inNO_time = list_paylod[2];
        inNO_data = list_paylod[3];
      }

      if (type == 'inNO2') {
        inNO2_date = list_paylod[1];
        inNO2_time = list_paylod[2];
        inNO2_data = list_paylod[3];
      }

      if (type == 'outNO') {
        outNO_date = list_paylod[1];
        outNO_time = list_paylod[2];
        outNO_data = list_paylod[3];
      }

      if (type == 'outNO2') {
        outNO2_date = list_paylod[1];
        outNO2_time = list_paylod[2];
        outNO2_data = list_paylod[3];
      }

      if (type == 'outH2') {
        outH2_date = list_paylod[1];
        outH2_time = list_paylod[2];
        outH2_data = list_paylod[3];
      }

      if (type == 'inTemp') {
        inTemp_date = list_paylod[1];
        inTemp_time = list_paylod[2];
        inTemp_data = list_paylod[3];
      }
      /*
      if (type == '-1') {
        machine = '-1';
      }
      if (type == 'Temperature') {
        machine = 'ON';
      }
      */

      print('---------- Received message:$payload from topic: ${c[0].topic}>');
    });
    return client;
  }
}
