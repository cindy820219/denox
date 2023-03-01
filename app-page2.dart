import 'package:airclean/page3.dart';
import 'package:flutter/material.dart';

var machine = ["H2 deNOx 模組"];

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  // override and AppBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('模組列表'),
        leading: BackButton(onPressed: () {
          Navigator.of(context).pop('----- here !! from page 2');
        },),),

      body: ListView.builder(
          itemCount: machine == null ? 0 : machine.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector( //You need to make my child interactive
              child: Card( //I am the clickable child
                child: Column(
                  children: <Widget>[
                    //new Image.network(video[index]),
                    const Padding(padding: EdgeInsets.all(10.0)),
                    Text(machine[index],
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),),

              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page3(machine[index]))).then((result) {
                  print(result); } ); },
              // MaterialPageRoute(builder: (context) => const Page3('VαIII-130G'))).then((result) {
              //   print(result); } );},
            );
          }),
    );
  }
}

// body:
//   Column(
//     children: [
//       Container(
//         margin: const EdgeInsets.all(20.0), ),
//
//       ElevatedButton(
//         child: const Text('機台 1 - VαIII-130G ', style: TextStyle(fontSize: 20, color: Colors.white), ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Page3('VαIII-130G'))).then((result){
//               print(result); } );} ),
//
//       ElevatedButton(
//         child: const Text('機台 2 - OOOXXXX ', style: TextStyle(fontSize: 20, color: Colors.white),),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Page3('OOOXXXX'))).then((result){
//               print(result); } );} ),
//
//       ElevatedButton(
//         child: const Text('機台 3 - XXXXOOO ', style: TextStyle(fontSize: 20, color: Colors.white),),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Page3('XXXXOOO'))).then((result){
//               print(result); } );} ),
//     ],
//   )
//       );
//     }
// }
