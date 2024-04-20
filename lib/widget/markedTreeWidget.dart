import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:treesmarking/businessObj/campaign.dart';
import 'package:treesmarking/pages/markedTreePage.dart';
import '../businessObj/markedTree.dart';
import '../businessObj/markedTreeList.dart';
import '../generate/businessObj/markedTreeGen.dart';


class MarkedTreeWidget extends StatefulWidget {

  final List<MarkedTree> markedTreeList;
  final Campaign campaign ;
  
  MarkedTreeWidget({required this.markedTreeList,required  this.campaign});
  


  @override
  State<MarkedTreeWidget> createState() => _MarkedTreeWidgetState();
}


class _MarkedTreeWidgetState extends State<MarkedTreeWidget> {
  
  //List<MarkedTree> _markedTreeList = [];

  @override
  void initState() {
    //_markedTreeList = widget.markedTreeList;
    _loadData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    
    return
      Stack(
        children: [ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.markedTreeList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(widget.markedTreeList[index].remark+"/"+DateFormat("dd.MM.yyyy HH:mm:ss").format(widget.markedTreeList[index].insertTime)), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MarkedTreePage(marketTree: widget.markedTreeList[index],campaign: widget.campaign,)  )
                    ).then((value){
                      setState(() {
                        _loadData();
                      });
                    });
                  },
                );
            }
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(onPressed:() {
            
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  MarkedTreePage(campaign: widget.campaign,)  )
              ).then((value){
                setState(() {
                  _loadData();
                });
              });
            }, 
            child: Text("Add"),),
          )]
      
  );
  }
  
  void _loadData() {

  }
  
  _addMarkedTree() {

    var textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Marked Tree"),
        content: TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: "Remark"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
debugPrint("Test Debug Pring");
print(textFieldController.text);
              MarkedTree markedTree = MarkedTreeGen.newObj();
              markedTree.remark = textFieldController.text;
              markedTree.campaign = widget.campaign ;
print("markedTree Save 1");
              markedTree.save().then((value){
                int tmpid = markedTree.id ;
print("markedTree Save DONE with Value $value and ID: $tmpid");         
                MarkedTreeList.getFromCampaign(widget.campaign.id).then((list) {
                  setState(() {
print("load markedTreeList count : "+list.length.toString());                    
                    //_markedTreeList = list ; 
                  });     
                });
                //widget.onCamaignChange(campaign.id);
              });

              
              

              Navigator.pop(context, 'OK');
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
}


