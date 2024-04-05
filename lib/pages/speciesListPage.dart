import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/species.dart';

import '../businessObj/speciesList.dart';
import 'speciesPage.dart';



class SpeciesListPage extends StatefulWidget {
  const SpeciesListPage({super.key});


  @override
  State<SpeciesListPage> createState() => _SpeciesListPageState();
}



class _SpeciesListPageState extends State<SpeciesListPage> {
  List<Species> _speciesList = [];
  bool cbCommunUse = true; 

  @override
  void initState() {
    _loadSpecies();
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Spacies list Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline),
        onPressed: () {
          addSpecies();
        },
      ),
      body:  Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: _speciesList.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: () => showSpecies(_speciesList[index]),
                child: new Card(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 5.0, top: 2.0, bottom: 2.0),
                    child: Row(
                      children: [
                      Text(_speciesList[index].name),
                      Expanded(child: Container()),
                      Icon(_speciesList[index].communUse ? Icons.check :Icons.cancel_outlined)
                    ]), 
                  )
                    
                ) 
              );
            }
          ),
      ),
    );
  }
  

  showSpecies(Species species)
  {   
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SpeciesPage(species :species))
    ).then((value){
      setState(() {
        _loadSpecies();
      });
    });
  }

  addSpecies() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SpeciesPage()  )
    ).then((value){
      setState(() {
        _loadSpecies();
      });
    });
  }
  
  
  void _loadSpecies() {
    SpeciesList.getAll().then((value) {
      setState(() {
        _speciesList = value; 
      });
    });

  }
}