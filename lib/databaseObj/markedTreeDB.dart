import '../businessObj/markedTree.dart';
import 'databaseObj.dart';
import '../businessObj/species.dart';
import '../businessObj/gen/speciesImpl.dart';
import '../businessObj/trunkSize.dart';
import '../businessObj/gen/trunkSizeImpl.dart';
import '../businessObj/campaign.dart';
import '../businessObj/gen/campaignImpl.dart';


class MarkedTreeDB extends DatabaseObj {
  
  Species _species = SpeciesImpl.newObj();
  int _speciesId = 0;
  TrunkSize _trunkSize = TrunkSizeImpl.newObj();
  int _trunkSizeId = 0;
  Campaign _campaign = CampaignImpl.newObj();
  int _campaignId = 0;
  String _remark = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _insertTime = DateTime.now();



  MarkedTreeDB()
  {
    tableName = 'markedTree';
  }

  Species get species => _species;
  int get speciesId => _speciesId;
  TrunkSize get trunkSize => _trunkSize;
  int get trunkSizeId => _trunkSizeId;
  Campaign get campaign => _campaign;
  int get campaignId => _campaignId;
  String get remark => _remark;
  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get insertTime => _insertTime;



  set speciesId(int value)
  {
    if (_speciesId != value)
    {
      dataUpdated(); 
      _speciesId = value;
    }
  }
  set trunkSizeId(int value)
  {
    if (_trunkSizeId != value)
    {
      dataUpdated(); 
      _trunkSizeId = value;
    }
  }
  set campaignId(int value)
  {
    if (_campaignId != value)
    {
      dataUpdated(); 
      _campaignId = value;
    }
  }
  set remark(String value)
  {
    if (_remark != value)
    {
      dataUpdated(); 
      _remark = value;
    }
  }
  set latitude(double value)
  {
    if (_latitude != value)
    {
      dataUpdated(); 
      _latitude = value;
    }
  }
  set longitude(double value)
  {
    if (_longitude != value)
    {
      dataUpdated(); 
      _longitude = value;
    }
  }
  set insertTime(DateTime value)
  {
    if (_insertTime != value)
    {
      dataUpdated(); 
      _insertTime = value;
    }
  }


  Future<MarkedTree> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj)
    {
      MarkedTree result = MarkedTree(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);
        SpeciesImpl.openObj(_speciesId).then((value){
          _species = value ;
        });
        TrunkSizeImpl.openObj(_trunkSizeId).then((value){
          _trunkSize = value ;
        });
        CampaignImpl.openObj(_campaignId).then((value){
          _campaign = value ;
        });

      }
      return result ; 
    });
  }

  MarkedTree newObj()
  {
    MarkedTree result = MarkedTree(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    //Map<String, Object?> result = super.toMap();
    return{
      'speciesId' : _speciesId,
      'trunkSizeId' : _trunkSizeId,
      'campaignId' : _campaignId,
      'remark' : _remark,
      'latitude' : _latitude,
      'longitude' : _longitude,
      'insertTime' : _insertTime.millisecondsSinceEpoch,

    };
    
  }


  Future<MarkedTree> fromMap(Map<String,Object?> map)
  async {
    MarkedTree result = MarkedTree(this) ;
    super.id = map["id"] as int; 
    
    _speciesId = (map['speciesId']??0) as int;
    if (_speciesId >0 )
    {
      _species = await SpeciesImpl.openObj(_speciesId);
    }
    _trunkSizeId = (map['trunkSizeId']??0) as int;
    if (_trunkSizeId >0 )
    {
      _trunkSize = await TrunkSizeImpl.openObj(_trunkSizeId);
    }
    _campaignId = (map['campaignId']??0) as int;
    if (_campaignId >0 )
    {
      _campaign = await CampaignImpl.openObj(_campaignId);
    }
    _remark = (map['remark']??'') as String;
    _latitude = (map['latitude']??0.0) as double;
    _longitude = (map['longitude']??0.0) as double;
    _insertTime = DateTime.fromMillisecondsSinceEpoch((map['insertTime']??0) as int);



    return result; 

  }



}