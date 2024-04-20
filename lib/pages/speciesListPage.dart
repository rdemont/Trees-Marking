import 'package:flutter/material.dart';
import 'package:treesmarking/businessObj/species.dart';


import '../businessObj/speciesList.dart';
import 'speciesPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
        title: Text(AppLocalizations.of(context)!.species),
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
                onLongPress: () => showSpecies(_speciesList[index]),
                onTap: () => communUseChange(_speciesList[index]),
                child: new ListTile(
                  leading: CircleAvatar(child: Text(_speciesList[index].code)),
                  title: Text(_speciesList[index].name),  
                  trailing: Icon(_speciesList[index].communUse ? Icons.check :Icons.cancel_outlined)                    
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

  communUseChange(Species species)
  {
    setState(() {
      species.communUse = !species.communUse ;  
    });
    
    species.save();
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