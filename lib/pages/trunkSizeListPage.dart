import 'package:flutter/material.dart';

import '../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeList.dart';
import 'trunkSizePage.dart';

class TrunkSizeListPage extends StatefulWidget {
  const TrunkSizeListPage({super.key});


  @override
  State<TrunkSizeListPage> createState() => _TrunkSizeListPageState();
}



class _TrunkSizeListPageState extends State<TrunkSizeListPage> {
  List<TrunkSize> _trunkSizeList = [];
  

  @override
  void initState() {
    _loadTrunkSize();
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Trunk size list Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addTrunkSize();
        },
      ),
      body:  Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _trunkSizeList.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: () => showTrunkSize(_trunkSizeList[index]),
                child: new Card(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 5.0, top: 2.0, bottom: 2.0),
                    child: Row(
                      children: [
                      Text(_trunkSizeList[index].code),
                      Expanded(child: Container()),
                      Text(_trunkSizeList[index].minDiameter.toString()+" cm - "+_trunkSizeList[index].minDiameter.toString()+" cm ["+_trunkSizeList[index].volume.toString()+" sv]" ),
                    ]), 
                  )
                    
                ) 
              );
            }
          ),
      ),
    );
  }
  

  showTrunkSize(TrunkSize trunkSize)
  {   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TrunkSizePage(trunkSize :trunkSize))
    ).then((value){
      setState(() {
        _loadTrunkSize();
      });
    });
  }

  addTrunkSize() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  TrunkSizePage()  )
    ).then((value){
      setState(() {
        _loadTrunkSize();
      });
    });
  }
  
  
  void _loadTrunkSize() {
    TrunkSizeList.getAll().then((value) {
      setState(() {
        _trunkSizeList = value; 
      });
    });

  }
}