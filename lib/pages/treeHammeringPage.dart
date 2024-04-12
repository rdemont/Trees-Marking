


import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart' as ExcelLib;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../businessObj/campaign.dart';
import '../businessObj/markedTree.dart';
import '../businessObj/markedTreeList.dart';
import '../businessObj/species.dart';
import '../businessObj/speciesList.dart';
import '../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';

import '../generate/businessObj/markedTreeGen.dart';
import '../generate/businessObj/speciesGen.dart';
import '../widget/settingsWidget.dart';

class TreeHammeringPage extends StatefulWidget {

  final Campaign campaign;
  TreeHammeringPage({super.key,required Campaign campaign}):this.campaign = campaign;

  @override
  State<TreeHammeringPage> createState() => _TreeHammeringPageState();
}


class _TreeHammeringPageState extends State<TreeHammeringPage> {

  //TextEditingController nameController = TextEditingController();
  List<TrunkSize> _trunkSizeList = [] ; 
  List<Species> _speciesList = [] ; 
  List<MarkedTree> _markedTreeList = []; 

  Widget body = Text("Please waite ....loading ");  
  int _btnSpeciesOn = 0 ; 
  int _btnTrunkSizeOn = 0;
  
  
  MarkedTree? _markedTree = null ; 

  bool _validate = false ;

  @override
  void initState() {
    
    super.initState();

    //nameController.text = _campaign.name;
    
    MarkedTreeList.getFromCampaign(widget.campaign.id).then((value) {
      _markedTreeList = value ;
    });

  }


  @override
  Widget build(BuildContext context) {

    Future.wait([
      TrunkSizeList.getAll().then((value) {
        _trunkSizeList = value ;  
        return ;
      }),

      SpeciesList.getAll(SpeciesGen.COLUMN_COMMUNUSE +"=1").then((value) {
        _speciesList = value ;  
        return ;
      }),
    ]).then((value) {
      loadData();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Martelage"),
      ),
      body:body,
      endDrawer:  Drawer(child:  SettingsWidget()), 
      bottomNavigationBar: SizedBox(height: 75, child:BottomAppBar(child: getBottomInfo(),)),
    ) ;
  }


  loadData(){
    setState(() {
      body = Text(AppLocalizations.of(context)!.pleaseWaite);
    });
    if ((!_speciesList.isEmpty)
      && (!_trunkSizeList.isEmpty))
      {
        setState(() {
          body = getScreen();
        });
        
      }
  }


  


  Widget getScreen()
  {
    

    return Column(
      children: [
        getHeadrePart(),
        Divider(),
        getSpeciesPart(),
        Divider(),
        getTrunkSizePart(), 
        Visibility(
            maintainSize: false,
            visible: _markedTree != null,
            child: Divider(),
        ),
        getButton(),
        Divider(),
        getList(),
      ],
    ); 
  }

  Widget getHeadrePart()
  {
    return Row(
      children: [
        Text("Localization :"),
        Flexible(
          child: Text(widget.campaign.name)
        )  
      ],
    );
  }

  Widget getSpeciesCell(int cell){
    
    if (_speciesList.length > cell)
    {
      return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _btnSpeciesOn = cell;             
          });
        },
        style: ElevatedButton.styleFrom(backgroundColor:cell==_btnSpeciesOn?Colors.blue:Colors.grey,),
        child: Text(_speciesList[cell].name),
      );

    }
    return Text("");
  }



  Widget getSpeciesPart()
  {
    
    return Table(
      border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
      children: [
        TableRow(
          children: [getSpeciesCell(0),getSpeciesCell(1),getSpeciesCell(2),getSpeciesCell(3)]
        ),
        TableRow(
          children: [getSpeciesCell(4),getSpeciesCell(5),getSpeciesCell(6),getSpeciesCell(7)]
        ),
      ],

    );
  }

  
  

  Widget getTrunkSizeCell(int cell){
    if (_trunkSizeList.length > cell)
    {
      return ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _btnTrunkSizeOn = cell;             
            //_validate = nameController.text.isEmpty ; 
          });
          if (!_validate)
          {
            save();
          }
                
        }, 
        style: ElevatedButton.styleFrom(backgroundColor:cell==_btnTrunkSizeOn?Colors.blue:Colors.grey,),
        child: Text(_trunkSizeList[cell].code),
      );
    }
    return Text("void");
  }

  Widget getTrunkSizePart()
 {

    return Table(
      border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
      children: [
        TableRow(
          children: [getTrunkSizeCell(0),getTrunkSizeCell(1),getTrunkSizeCell(2),getTrunkSizeCell(3),getTrunkSizeCell(4),getTrunkSizeCell(5)]
        ),
        TableRow(
          children: [getTrunkSizeCell(6),getTrunkSizeCell(7),getTrunkSizeCell(8),getTrunkSizeCell(9),getTrunkSizeCell(10),getTrunkSizeCell(11)]
        ),
        TableRow(
          children: [getTrunkSizeCell(12),getTrunkSizeCell(13),getTrunkSizeCell(14),getTrunkSizeCell(15),getTrunkSizeCell(16),getTrunkSizeCell(17)]
        ),
        TableRow(
          children: [getTrunkSizeCell(18),getTrunkSizeCell(19),getTrunkSizeCell(20),getTrunkSizeCell(21),getTrunkSizeCell(22),getTrunkSizeCell(23)]
        ),
      ],

    );
  }


  Widget getButton()
  {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            maintainSize: false,
            visible: _markedTree != null,
            child:ElevatedButton(onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                //_validate = nameController.text.isEmpty ; 
              });
              if (!_validate)
              {
                save();
              }
                
            }, 
            child: Text("Save",
              style: new TextStyle(
              fontSize: 30.0,
              fontStyle: FontStyle.italic
              ),)
            ),
          ),
          Visibility(
            maintainSize: false,
            visible: _markedTree != null,
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _markedTree!.delete();
                _markedTree!.save().then((value){
                  MarkedTreeList.getFromCampaign(widget.campaign.id).then((value) {
                    setState(() {
                      _markedTreeList = value ; 
                      _markedTree = null; 
                    });
                  }); 
                });
              },
              child: Text("Delete",
                style: new TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic
                ),
              )
            ),
          ),
          Visibility(
            maintainSize: false,
            visible: _markedTree != null,
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _markedTree = null; 
              },
              child: Text("Cancel",
                style: new TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic
                ),
              )
            ),
          )

        ]
      );
    
  }


  Widget getList()
  {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _markedTreeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color:(index%2 == 0 ) ? Colors.grey[50] : Colors.grey[350],
            child: ListTile(
              title: Text(_markedTreeList[index].species.name+" - "+_markedTreeList[index].trunkSize.toString()), 
              onLongPress: () {
                // edit 
                setState(() {
                  _markedTree =  _markedTreeList[index];
                  _btnSpeciesOn = _speciesList.indexWhere((element) => element.id == _markedTree!.species.id);
                  _btnTrunkSizeOn = _trunkSizeList.indexWhere((element) => element.id == _markedTree!.trunkSize.id);

                });
              },
              onTap: () {
                ;
              },
            )
          );
        }
      )
    );  
  }

  save()
  {
  
    
    MarkedTree markedTree = _markedTree?? MarkedTreeGen.newObj();
    markedTree.campaignId = widget.campaign.id ; 
    markedTree.speciesId = _speciesList[_btnSpeciesOn].id;
    markedTree.trunkSizeId = _trunkSizeList[_btnTrunkSizeOn].id;


    Geolocator.getCurrentPosition().then((value) {
      print("POSITION **** "+value.latitude.toString());              
      markedTree.latitude =  value.latitude ;
      markedTree.longitude =  value.longitude ; 

      markedTree.save().then((value){
        MarkedTreeList.getFromCampaign(widget.campaign.id).then((value) {
          setState(() {
            _markedTreeList = value ; 
            _markedTree = null; 
          });
        }); 
      });
    });
  }

  

  Widget getBottomInfo() {
    double sv = 0; 
    Map<String,int> speciesCount = {};
    Map<String,double> speciesSv = {};
    

    for (int i = 0;i<_markedTreeList.length;i++)
    {
      sv += _markedTreeList[i].trunkSize.volume; 
      String speciesName = _markedTreeList[i].species.name;
      speciesCount[speciesName] = (speciesCount[speciesName]??0) +1;  
      speciesSv[speciesName] = (speciesSv[speciesName]??0) + _markedTreeList[i].trunkSize.volume;  

    }

    List<DataRow> dataRow = []; 
    
    int i = 0 ; 
    for (String key in speciesCount.keys)
    {
      dataRow.add(DataRow(color: ((i % 2) == 0) ? MaterialStateProperty.all(Colors.grey[100]):MaterialStateProperty.all(Colors.grey[350]),cells: [
        DataCell(Text(key)),
        DataCell(Text(speciesCount[key].toString())),
        DataCell(Text((speciesSv[key]??0.0).toStringAsFixed(2))),
        ]));
        i++;
    }
    
    dataRow.add(DataRow(cells: [
      DataCell(Text(speciesCount.length.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
      DataCell(Text(_markedTreeList.length.toString(),style: TextStyle(fontWeight: FontWeight.bold),)),
      DataCell(Text(sv.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold),))
    ]));

    return GestureDetector(
      onTap: () {   
        showModalBottomSheet(context: context,
          builder: (context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                //height: 200,
                color: Colors.grey,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text(AppLocalizations.of(context)!.species,style: TextStyle(fontStyle: FontStyle.italic),)),
                    DataColumn(label: Text(AppLocalizations.of(context)!.count,style: TextStyle(fontStyle: FontStyle.italic),)),
                    DataColumn(label: Text(AppLocalizations.of(context)!.sv,style: TextStyle(fontStyle: FontStyle.italic),)),
                  ],
                  rows: dataRow,
                    
                )
            );
          },
        );
      },

      child: 
      Row(
      children: [
        IconButton(onPressed: () {
            exportData();
          }, icon: Icon(Icons.attach_email_rounded)
        ),
        Expanded(child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalDivider(),
              Text("${AppLocalizations.of(context)!.species}: ${speciesCount.length}"),
              VerticalDivider(),
              Text("${AppLocalizations.of(context)!.count}: ${_markedTreeList.length}"),
              VerticalDivider(),
              Text("${AppLocalizations.of(context)!.sv}: ${sv.toStringAsFixed(2)}"),
              VerticalDivider(),
            ],
          )
        )
      ],
      )
    );
  }


  exportData()
  {
    ExcelLib.Excel excel = ExcelLib.Excel.createExcel();
    excel.copy("Sheet1","PV martelage");
    excel.rename("Sheet1", "liste de marquage");
    excel.setDefaultSheet("PV martelage");
    ExcelLib.Sheet sheet = excel["liste de marquage"]; 

    ExcelLib.CellStyle cellPVTitle = ExcelLib.CellStyle(bold: true,backgroundColorHex: ExcelLib.ExcelColor.fromHexString("#f59842"));   
    ExcelLib.CellStyle cellPVSubTitle = ExcelLib.CellStyle(bold: true,backgroundColorHex: ExcelLib.ExcelColor.fromHexString("#f5c190"));   

    
    //sheet.merge(ExcelLib.CellIndex.indexByString('A1'), ExcelLib.CellIndex.indexByString('D1'), customValue: ExcelLib.TextCellValue(nameController.text));
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).value = ExcelLib.TextCellValue("Date de la saisie") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("B1")).value = ExcelLib.TextCellValue("Essence") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).value = ExcelLib.TextCellValue("taille du tronc") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("D1")).value = ExcelLib.TextCellValue("Sylve") ; 

    ExcelLib.CellStyle cellTitle = ExcelLib.CellStyle(bold: true);
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("B1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("D1")).cellStyle = cellTitle ;


    Map<String,int> sumNbTrunkLeafy = {};
    Map<String,double> sumVolumeLeafy = {};
    Map<String,int> sumNbTrunkSoftWood = {};
    Map<String,double> sumVolumeSoftWood = {};
    Map<String,int> sumNbTrunkType = {};
    Map<String,double> sumVolumeType = {};


    for (int i = 0;i<_markedTreeList.length;i++)
    {
      sheet.cell(ExcelLib.CellIndex.indexByString("A${i+2}")).value = ExcelLib.TextCellValue(DateFormat('dd.MM.yyyy HH:mm:ss').format(_markedTreeList[i].insertTime)) ; 
      sheet.cell(ExcelLib.CellIndex.indexByString("B${i+2}")).value = ExcelLib.TextCellValue(_markedTreeList[i].species.name) ; 
      sheet.cell(ExcelLib.CellIndex.indexByString("C${i+2}")).value = ExcelLib.TextCellValue(_markedTreeList[i].trunkSize.code) ; 
      sheet.cell(ExcelLib.CellIndex.indexByString("D${i+2}")).value = ExcelLib.TextCellValue(_markedTreeList[i].trunkSize.volume.toStringAsFixed(2)) ; 

      switch(_markedTreeList[i].species.type)
      {
        case Species.TYPE_LEAFY :
          if (!sumNbTrunkLeafy.containsKey(_markedTreeList[i].species.name))
          { 
            sumNbTrunkLeafy[_markedTreeList[i].species.name] = 0;
            sumVolumeLeafy[_markedTreeList[i].species.name] = 0.0;
          }
          sumNbTrunkLeafy[_markedTreeList[i].species.name] = sumNbTrunkLeafy[_markedTreeList[i].species.name]! +1;
          sumVolumeLeafy[_markedTreeList[i].species.name] = sumVolumeLeafy[_markedTreeList[i].species.name]! + _markedTreeList[i].trunkSize.volume ;
          break ; 
        case Species.TYPE_SOFTWOOD : 
          if (!sumNbTrunkSoftWood.containsKey(_markedTreeList[i].species.name))
          { 
            sumNbTrunkSoftWood[_markedTreeList[i].species.name] = 0;
            sumVolumeSoftWood[_markedTreeList[i].species.name] = 0.0;
          }
          sumNbTrunkSoftWood[_markedTreeList[i].species.name] = sumNbTrunkSoftWood[_markedTreeList[i].species.name]! +1;
          sumVolumeSoftWood[_markedTreeList[i].species.name] = sumVolumeSoftWood[_markedTreeList[i].species.name]! + _markedTreeList[i].trunkSize.volume ;
          break ; 
      }

      if (!sumNbTrunkType.containsKey(_markedTreeList[i].species.type.toString()))
      {
        sumNbTrunkType[_markedTreeList[i].species.type.toString()] = 0;
        sumVolumeType[_markedTreeList[i].species.type.toString()] = 0.0;
      }

      sumNbTrunkType[_markedTreeList[i].species.type.toString()] = sumNbTrunkType[_markedTreeList[i].species.type.toString()]! + 1;
      sumVolumeType[_markedTreeList[i].species.type.toString()] = sumVolumeType[_markedTreeList[i].species.type.toString()]! + _markedTreeList[i].trunkSize.volume;
    }


    sheet = excel["PV martelage"]; 
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).value = ExcelLib.TextCellValue("Propriétaire") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).value = ExcelLib.TextCellValue("Chantier") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("E1")).value = ExcelLib.TextCellValue("Martelage") ; 

    
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).cellStyle = cellPVTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).cellStyle = cellPVTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("E1")).cellStyle = cellPVTitle;


    List<String> listOwner = LineSplitter().convert(widget.campaign.owner);
    List<String> listyard = LineSplitter().convert(widget.campaign.yard);
    List<String> listName = LineSplitter().convert(widget.campaign.name);

    int nextLine = listOwner.length + 2 ;
    if ((listyard.length+2) > nextLine)
    {
      nextLine = listyard.length + 2 ;
    }
    if ((listName.length+3) > nextLine)
    {
      nextLine = listName.length + 3 ;
    }
    
    for (int i=0;i<listOwner.length;i++)
    {
      sheet.cell(ExcelLib.CellIndex.indexByString("A${i+2}")).value = ExcelLib.TextCellValue(listOwner[i]) ; 
    }
    
    for (int i=0;i<listyard.length;i++)
    {
      sheet.cell(ExcelLib.CellIndex.indexByString("C${i+2}")).value = ExcelLib.TextCellValue(listyard[i]) ; 
    }

    sheet.cell(ExcelLib.CellIndex.indexByString("E2")).value = ExcelLib.TextCellValue(DateFormat('dd.MM.yyyy HH:mm:ss').format(widget.campaign.campaignDate)) ; 
    for (int i=0;i<listName.length;i++)
    {
      sheet.cell(ExcelLib.CellIndex.indexByString("E${i+3}")).value = ExcelLib.TextCellValue(listName[i]) ; 
    }

    nextLine++; 
    nextLine++; 
    nextLine++; 

    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Récapitulatif par essence") ;

    nextLine++; 
    int lineMoy = nextLine ; 

    nextLine++; 
    nextLine++; 
    nextLine++; 
    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Nb tige : ") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).cellStyle = cellPVTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue("Vol. moyen") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).cellStyle = cellPVTitle;
    

    nextLine++; 
    nextLine++; 
    nextLine++; 

    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Essence") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).cellStyle = cellPVTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue("Nb tige") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).cellStyle = cellPVTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue("Volume") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).cellStyle = cellPVTitle;
    
    int totalNbTrunk = (sumNbTrunkType[Species.TYPE_LEAFY.toString()]?? 0) + (sumNbTrunkType[Species.TYPE_SOFTWOOD.toString()]?? 0);
    double totalVolume = (sumVolumeType[Species.TYPE_LEAFY.toString()]?? 0) + (sumVolumeType[Species.TYPE_SOFTWOOD.toString()]?? 0);

    sheet.cell(ExcelLib.CellIndex.indexByString("B$lineMoy")).value = ExcelLib.TextCellValue(totalNbTrunk.toString()) ;
    sheet.cell(ExcelLib.CellIndex.indexByString("B$lineMoy")).cellStyle = cellPVSubTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("D$lineMoy")).value = ExcelLib.TextCellValue((totalVolume/totalNbTrunk).toStringAsFixed(3)) ;
    sheet.cell(ExcelLib.CellIndex.indexByString("D$lineMoy")).cellStyle = cellPVSubTitle;


    if (sumNbTrunkLeafy.isNotEmpty) //Feuillu
    {
      nextLine++; 
      sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Feuillu") ;
      sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).cellStyle = cellPVSubTitle;
      sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue(sumNbTrunkType[Species.TYPE_LEAFY.toString()].toString()) ;
      sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).cellStyle = cellPVSubTitle;
      sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue(sumVolumeType[Species.TYPE_LEAFY.toString()]!.toStringAsFixed(2)) ;
      sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).cellStyle = cellPVSubTitle;


      sumNbTrunkLeafy.forEach((key, value) 
      {
        nextLine++; 
        sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue(key) ;
        sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue(sumNbTrunkLeafy[key].toString()) ;
        sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue(sumVolumeLeafy[key]!.toStringAsFixed(2)) ;
       });


    }


    if (sumNbTrunkSoftWood.isNotEmpty) //Résineux
    {
      nextLine++; 
      sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Résineux") ;
      sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).cellStyle = cellPVSubTitle;
      sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue(sumNbTrunkType[Species.TYPE_SOFTWOOD.toString()].toString()) ;
      sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).cellStyle = cellPVSubTitle;
      sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue(sumVolumeType[Species.TYPE_SOFTWOOD.toString()]!.toStringAsFixed(2)) ;
      sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).cellStyle = cellPVSubTitle;
      
      sumNbTrunkSoftWood.forEach((key, value) 
      {
        nextLine++; 
        sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue(key) ;
        sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue(sumNbTrunkSoftWood[key].toString()) ;
        sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue(sumVolumeSoftWood[key]!.toStringAsFixed(2)) ;
       });
    }

    nextLine++; 
    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).value = ExcelLib.TextCellValue("Total général") ;
    sheet.cell(ExcelLib.CellIndex.indexByString("A$nextLine")).cellStyle = cellPVSubTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).value = ExcelLib.TextCellValue(totalNbTrunk.toString()) ;
    sheet.cell(ExcelLib.CellIndex.indexByString("B$nextLine")).cellStyle = cellPVSubTitle;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).value = ExcelLib.TextCellValue(totalVolume.toStringAsFixed(2)) ;
    sheet.cell(ExcelLib.CellIndex.indexByString("C$nextLine")).cellStyle = cellPVSubTitle;

    List<int>? fileBytes = excel.save();
    getApplicationDocumentsDirectory().then((value){
      Directory appDocumentsDirectory = value ; // 1
      String appDocumentsPath = appDocumentsDirectory.path;
      String filePath = '$appDocumentsPath/PV_martelage_${DateFormat("yyyyMMddhhmmss").format(DateTime.now())}.xlsx';
      File file = File(filePath);
      file.writeAsBytesSync(fileBytes!);

      Share.shareXFiles([XFile(filePath)]);
    });
  }
}