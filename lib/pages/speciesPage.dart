import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treesmarking/businessObj/species.dart';

class SpeciesPage extends StatefulWidget {
  
  Species species;

  SpeciesPage({super.key, Species? species}):this.species=species ?? Species.newObj();

  @override
  State<SpeciesPage> createState() => _SpeciesPageState();
}


class _SpeciesPageState extends State<SpeciesPage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.species.name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spacies Page'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [
            Row(
              children: [
                Text("Name : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Spacies name"), 
                    )
                )              
              ],
            ),
            Row(
              children: [
                Text("Commun use : "),
                Checkbox(
                  value: widget.species.communUse, 
                  onChanged: (value) {
                    setState(() {
                      widget.species.communUse = value ?? true; 
                    });
                  })
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
    widget.species.name = nameController.text;
print("species page add");
    widget.species.save().then((value){
print("species page add -- POP");      
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.species.delete();
    widget.species.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}