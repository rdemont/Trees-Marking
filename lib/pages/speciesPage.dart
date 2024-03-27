
import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/species.dart';

import '../businessObj/list/speciesList.dart';



class SpeciesPage extends StatefulWidget {
  const SpeciesPage({super.key});


  @override
  State<SpeciesPage> createState() => _SpeciesPageState();
}



class _SpeciesPageState extends State<SpeciesPage> {
  List<Species> _speciesList = [];


  @override
  void initState() {
    _loadSpecies();
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spacies Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addSpecies();
        },
      ),
      body: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _speciesList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(_speciesList[index].name), 
                );
            }
          ),
    
    );
  }
  
  addSpecies() {
    var textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New spacies"),
        content: TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: "name"),
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
              Species species = Species.newObj();
              species.name = textFieldController.text;
print("Campaign Save 1");
              species.save().then((value){
                int tmpid = species.id ;
print("Campaign Save DONE with Value $value and ID: $tmpid");              
                
              });

              
              

              Navigator.pop(context, 'OK');
              
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  void _loadSpecies() {
print("Load Species");    
    SpeciesList.getAll().then((value) {
      setState(() {
        _speciesList = value; 
      });
    });

  }
}