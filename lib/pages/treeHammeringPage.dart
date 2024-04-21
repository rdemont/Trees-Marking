


import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart' as ExcelLib;
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lv95/lv95.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treesmarking/pages/speciesListPage.dart';

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
  int _btnSpeciesOn = -1 ; 
  int _btnTrunkSizeOn = 0;
  bool _isLoaded = false  ; 
  
  late MarkedTree _markedTree; 
  MarkedTree? _markedTreeLastChange = null ; 
  int _mtEditIndex = -1 ;

  
  bool _btnEditOn = false ; 

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ScrollOffsetController _scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener _scrollOffsetListener = ScrollOffsetListener.create();


  @override
  void initState() {
    
    super.initState();

    _markedTree = MarkedTreeGen.newObj();
    
  }


  @override
  Widget build(BuildContext context) {

    if (!_isLoaded)
    {
      Future.wait([
        MarkedTreeList.getFromCampaign(widget.campaign.id).then((value) {
          _markedTreeList = value ;
          return ;
        }),
        TrunkSizeList.getAll().then((value) {
          _trunkSizeList = value ;  
          return ; 
        }),

        SpeciesList.getAll().then((value) {
          _speciesList = value ;  
          return ; 
        })
      ]).then((value) {
        setState(() {
          _isLoaded = true ;   
        });
        
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Martelage"),
        actions: [
          IconButton(
            icon:Icon(Icons.forest_outlined),
            tooltip: "Marteler",
            onPressed: () {
              openSpecies();
            },
          )
        ]
      ),
      body:getScreen(), //body,
      //endDrawer:  Drawer(child:  SettingsWidget()), 
      bottomNavigationBar: SizedBox(height: 75, child:BottomAppBar(child: getBottomInfo(),)),
    ) ;
  }


  openSpecies()
  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  SpeciesListPage())).then((value){
        SpeciesList.getAll().then((value) {
          setState(() {
            _speciesList = value ;    
          });
          
        });
      }, );

  }

/*
  loadData(){              
    if ((!_speciesList.isEmpty)
      && (!_trunkSizeList.isEmpty))
      {
print("*****SETSTATE LOADDATA **** ");                            
        setState(() {
          body = getScreen();
        });
        
      }
  }
*/


  Widget getScreen()
  {
    if (!_isLoaded)
    {
      return Text("Please waite ....loading ");  
    }
print("***********speciesList.length :"+_speciesList.length.toString());
    return Column(
      children: [
        getHeadrePart(),
        getSpeciesPart(),
        getTrunkSizePart(),
        getButton(),
        getList(),
      ],
    ); 
  }

  Widget getHeadrePart()
  {
    return Row(
      children: [
        //Text("Localization :"),
        Flexible(
          child: Text(widget.campaign.name)
        )  
      ],
    );
  }

  Widget getSpeciesCell(int cell){
    
    if (_speciesList.length > cell)
    {
      return 
      Container(
        color:cell==_btnSpeciesOn?Colors.blue:null,
        height: 60,
        child: TextButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
  print("*****SETSTATE SPECIESCELL   **** ");                              
            setState(() {
              _btnSpeciesOn = cell;    
              //body = getScreen();        
            });
          },
          //style: TextButton.styleFrom(backgroundColor:cell==_btnSpeciesOn?Colors.blue:Colors.grey,),
          child: Text(
            _speciesList[cell].name,
            overflow: TextOverflow.ellipsis,
          ),
        )
      );
    }
    return Text("");
  }



  Widget getSpeciesPart()
  {
    
    List<int> val =[]; 
    for(int i=0;i<_speciesList.length;i++)
    {
      if (_speciesList[i].communUse)
      {
        val.add(i);
        if (_btnSpeciesOn < 0)
        {
          _btnSpeciesOn = i ; 
        }
      }
    }

    for(int i=0-1;i<8;i++)
    {
      val.add(999999);
    }
    
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),
        verticalInside:  BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),  
      ),
      children: [
        TableRow(
          children: [getSpeciesCell(val[0]),getSpeciesCell(val[1]),getSpeciesCell(val[2]),getSpeciesCell(val[3])]
        ),
        TableRow(
          children: [getSpeciesCell(val[4]),getSpeciesCell(val[5]),getSpeciesCell(val[6]),getSpeciesCell(val[7])]
        ),
      ],

    );
  }

  
  

  Widget getTrunkSizeCell(int cell){
    if (_trunkSizeList.length > cell)
    {
      return
      Container(
        color:cell==_btnTrunkSizeOn?Colors.blue:null,
        height: 40,
        child: TextButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
  print("*****SETSTATE TRUNKSIZECELL   **** ");                              
            setState(() {
              _btnTrunkSizeOn = cell;             
            
            });
            save();      
          }, 
          child: Text(_trunkSizeList[cell].code),
        )
      );
    }
    return Text("void");
  }

  Widget getTrunkSizePart()
 {

    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),
        verticalInside:  BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid),
      ),
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
            visible: _btnEditOn,
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  _btnEditOn = false ; 
                  _mtEditIndex = -1 ; 
                  _markedTreeList.remove(_markedTree);
                });                
                _markedTree.delete();
                _markedTree.save();
                _markedTree = MarkedTreeGen.newObj();
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
            visible: _btnEditOn,
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  _btnEditOn = false ; 
                  _mtEditIndex = -1 ; 
                });
//ToDo : Faire le bouton Delete                               
                //_markedTree = null; 
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

  Color? getLineColor(int index)
  {
    if(index == _mtEditIndex)
    {
        return Colors.red[200];
    }
    if (_markedTreeLastChange != null)
    {
      if (_markedTreeList[index].id == _markedTreeLastChange!.id)
      {
        return Colors.yellow[200];
      }
    }
    return (index%2 == 0 ) ? Colors.grey[50] : Colors.grey[350];
    
  }
  String getXYString(MarkedTree markedTree)
  {
    LatLng wgs84 = LatLng(markedTree.latitude,markedTree.longitude);
    XY lv95 = LV95.fromWGS84(wgs84,precise: true,height: markedTree.altitude);        
    return "x:"+lv95.x.toStringAsFixed(0).substring(1)+" y:"+lv95.y.toStringAsFixed(0).substring(1);
  }

  Widget getList()
  {
    DateFormat df = DateFormat("dd.MM.yyyy hh:mm"); 
    return Expanded(
      child: ScrollablePositionedList.builder(
        scrollDirection: Axis.vertical,
        itemScrollController: _itemScrollController,
        scrollOffsetController: _scrollOffsetController,
        itemPositionsListener: _itemPositionsListener,
        scrollOffsetListener: _scrollOffsetListener,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: _markedTreeList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 75,
            color: getLineColor(index),
            child: ListTile(
              leading: CircleAvatar(child: Text(_markedTreeList[index].species.code)),
              title: Text(_markedTreeList[index].trunkSize.code+" "+_markedTreeList[index].species.name), 
              subtitle: Text(df.format(_markedTreeList[index].insertTime)+" - "+getXYString(_markedTreeList[index])), //+"\n"+_markedTreeList[index].trunkSize.toString()) ,           
              onLongPress: () {
                // edit 
print("*****SETSTATE GETLIST   **** ");                    
                setState(() {
                  _mtEditIndex = index; 
                  _btnEditOn = true ; 
                  _markedTree =  _markedTreeList[index];
                  _btnSpeciesOn = _speciesList.indexWhere((element) => element.id == _markedTree.species.id);
                  _btnTrunkSizeOn = _trunkSizeList.indexWhere((element) => element.id == _markedTree.trunkSize.id);

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


print("****SAVE-----");
    //MarkedTree markedTree = _markedTree?? MarkedTreeGen.newObj();

    MarkedTree mt = _markedTree.clone();
    _markedTree = MarkedTreeGen.newObj();

    
    mt.campaign = widget.campaign ; 
    mt.species = _speciesList[_btnSpeciesOn];
    mt.trunkSize = _trunkSizeList[_btnTrunkSizeOn];
    mt.insertTime = DateTime.now();
    

    if (mt.id == 0)
    {
      setState(() {
        _markedTreeList.add(mt);
      });
      if (_markedTreeList.length > 1)
      {
        _itemScrollController.scrollTo(
          index: _markedTreeList.length -1 ,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOutCubic
        );
      }
      
    }
    if (_mtEditIndex >= 0)
    {
      setState(() {
        _markedTreeList[_mtEditIndex].trunkSize = _trunkSizeList[_btnTrunkSizeOn];
        _markedTreeList[_mtEditIndex].species = _speciesList[_btnSpeciesOn];
      });
    }

    setState(() {
      _markedTreeLastChange = mt ;  
      _btnEditOn = false ; 
      _mtEditIndex = -1 ; 
    });

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high ).then((value) {
      setState(() {
        mt.latitude =  value.latitude ;
        mt.longitude =  value.longitude ; 
        mt.altitude = value.altitude ;         
      });          

      mt.save();
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
                    DataColumn(label: Text("Essences",style: TextStyle(fontStyle: FontStyle.italic),)),
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
              Text("Essences: ${speciesCount.length}"),
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

    ExcelLib.CellStyle cellPVTitle = ExcelLib.CellStyle(bold: true,backgroundColorHex: ExcelLib.ExcelColor.fromHexString("#08AA2A"));   
    ExcelLib.CellStyle cellPVSubTitle = ExcelLib.CellStyle(bold: true,backgroundColorHex: ExcelLib.ExcelColor.fromHexString("#15CE3C"));   

    
    //sheet.merge(ExcelLib.CellIndex.indexByString('A1'), ExcelLib.CellIndex.indexByString('D1'), customValue: ExcelLib.TextCellValue(nameController.text));
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).value = ExcelLib.TextCellValue("Date de la saisie") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("B1")).value = ExcelLib.TextCellValue("Essence") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).value = ExcelLib.TextCellValue("taille du tronc") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("D1")).value = ExcelLib.TextCellValue("Sylve") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("E1")).value = ExcelLib.TextCellValue("Coordonées X") ; 
    sheet.cell(ExcelLib.CellIndex.indexByString("F1")).value = ExcelLib.TextCellValue("Coordonées Y") ; 

    ExcelLib.CellStyle cellTitle = ExcelLib.CellStyle(bold: true);
    sheet.cell(ExcelLib.CellIndex.indexByString("A1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("B1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("C1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("D1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("E1")).cellStyle = cellTitle ;
    sheet.cell(ExcelLib.CellIndex.indexByString("F1")).cellStyle = cellTitle ;


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


      LatLng wgs84 = LatLng(_markedTreeList[i].latitude,_markedTreeList[i].longitude);
      XY lv95 = LV95.fromWGS84(wgs84,precise: true,height: _markedTreeList[i].altitude);

      sheet.cell(ExcelLib.CellIndex.indexByString("E${i+2}")).value = ExcelLib.TextCellValue(lv95.x.toStringAsFixed(0).substring(1)) ; 
      sheet.cell(ExcelLib.CellIndex.indexByString("F${i+2}")).value = ExcelLib.TextCellValue(lv95.y.toStringAsFixed(0).substring(1)) ; 

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