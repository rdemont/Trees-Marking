

import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/list/speciesList.dart';

import '../businessObj/markedTree.dart';
import '../businessObj/species.dart';


class MarkedTreePage extends StatefulWidget {
  
  MarkedTree markedTree;

  MarkedTreePage({super.key, MarkedTree? marketTree}):this.markedTree=marketTree ?? MarkedTree.newObj();

  @override
  State<MarkedTreePage> createState() => _MarkedTreePageState();
}


class _MarkedTreePageState extends State<MarkedTreePage> {
  TextEditingController remarkController = TextEditingController();
  late List<Species> speciesList ;

  @override
  void initState() {
    super.initState();
    remarkController.text = widget.markedTree.remark.toString();
    SpeciesList.getAll().then((value) {
      setState(() {
        speciesList = value ;   
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marked tree Page'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text("Species : "),
                DropdownButton(
                  value: widget.markedTree.speciesId.toString(),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.markedTree.speciesId = value as int;
                      //change in object 
                      //widget.species.communUse = value ?? true; 
                    });
                  },
                  items:speciesList.map((value) {
                    return DropdownMenuItem(
                      value: value.id.toString(),
                      child: Text(value.name)
                    );
                  }).toList(),
                ),
                  
                
              ],
            ),
            Row(
              children: [
                Text("Remark : "),
                Flexible(
                  child: TextField(
                      controller: remarkController,
                      decoration: const InputDecoration(hintText: "Remark"), 
                    )
                )              
              ],
            ),
           
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text("Save")),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text("Delete")),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text("Cancel")),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.markedTree.remark = remarkController.text;

    widget.markedTree.save().then((value){
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.markedTree.delete();
    widget.markedTree.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}