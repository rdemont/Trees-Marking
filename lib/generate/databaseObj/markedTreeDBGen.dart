import '../../businessObj/markedTree.dart';
import '../businessObj/markedTreeGen.dart';
import '../../databaseObj/databaseObj.dart';
import '../../businessObj/species.dart';
import '../businessObj/speciesGen.dart';
import '../../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeGen.dart';
import '../../businessObj/campaign.dart';
import '../businessObj/campaignGen.dart';


class MarkedTreeDBGen extends DatabaseObj {
  
  Species _species = SpeciesGen.newObj();
  int _speciesId = 0;
  TrunkSize _trunkSize = TrunkSizeGen.newObj();
  int _trunkSizeId = 0;
  Campaign _campaign = CampaignGen.newObj();
  int _campaignId = 0;
  String _remark = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _insertTime = DateTime.now();
  double _altitude = 0.0;



  MarkedTreeDBGen()
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
  double get altitude => _altitude;



  set species(Species value)
  {
    if (_speciesId != value.id)
    {
      dataUpdated(); 
      _speciesId = value.id;
      _species = value;
    }
  }
  set trunkSize(TrunkSize value)
  {
    if (_trunkSizeId != value.id)
    {
      dataUpdated(); 
      _trunkSizeId = value.id;
      _trunkSize = value;
    }
  }
  set campaign(Campaign value)
  {
    if (_campaignId != value.id)
    {
      dataUpdated(); 
      _campaignId = value.id;
      _campaign = value;
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
  set altitude(double value)
  {
    if (_altitude != value)
    {
      dataUpdated(); 
      _altitude = value;
    }
  }


  Future<MarkedTree> open(int id)
  {
    return query(MarkedTreeGen.TABLE_NAME,where: MarkedTreeGen.COLUMN_ID+" = $id").then((obj)
    {
      MarkedTree result = MarkedTree(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);
        SpeciesGen.openObj(_speciesId).then((value){
          _species = value ;
        });
        TrunkSizeGen.openObj(_trunkSizeId).then((value){
          _trunkSize = value ;
        });
        CampaignGen.openObj(_campaignId).then((value){
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
    return{
      MarkedTreeGen.COLUMN_SPECIESID : _speciesId,
      MarkedTreeGen.COLUMN_TRUNKSIZEID : _trunkSizeId,
      MarkedTreeGen.COLUMN_CAMPAIGNID : _campaignId,
      MarkedTreeGen.COLUMN_REMARK : _remark,
      MarkedTreeGen.COLUMN_LATITUDE : _latitude,
      MarkedTreeGen.COLUMN_LONGITUDE : _longitude,
      MarkedTreeGen.COLUMN_INSERTTIME : _insertTime.millisecondsSinceEpoch,
      MarkedTreeGen.COLUMN_ALTITUDE : _altitude,

    };
    
  }


  Future<MarkedTree> fromMap(Map<String,Object?> map)
  async {
    MarkedTree result = MarkedTree(this) ;
    super.id = map[MarkedTreeGen.COLUMN_ID] as int; 
    
    _speciesId = (map[MarkedTreeGen.COLUMN_SPECIESID]??0) as int;
    if (_speciesId >0 )
    {
      _species = await SpeciesGen.openObj(_speciesId);
    }
    _trunkSizeId = (map[MarkedTreeGen.COLUMN_TRUNKSIZEID]??0) as int;
    if (_trunkSizeId >0 )
    {
      _trunkSize = await TrunkSizeGen.openObj(_trunkSizeId);
    }
    _campaignId = (map[MarkedTreeGen.COLUMN_CAMPAIGNID]??0) as int;
    if (_campaignId >0 )
    {
      _campaign = await CampaignGen.openObj(_campaignId);
    }
    _remark = (map[MarkedTreeGen.COLUMN_REMARK]??'') as String;
    _latitude = (map[MarkedTreeGen.COLUMN_LATITUDE]??0.0) as double;
    _longitude = (map[MarkedTreeGen.COLUMN_LONGITUDE]??0.0) as double;
    _insertTime = DateTime.fromMillisecondsSinceEpoch((map[MarkedTreeGen.COLUMN_INSERTTIME]??0) as int);
    _altitude = (map[MarkedTreeGen.COLUMN_ALTITUDE]??0.0) as double;



    return result; 

  }

 
  @override
  clone(DatabaseObj value)
  {
    super.clone(value);
    (value as MarkedTreeDBGen)._speciesId = speciesId;
    (value as MarkedTreeDBGen)._trunkSizeId = trunkSizeId;
    (value as MarkedTreeDBGen)._campaignId = campaignId;
    (value as MarkedTreeDBGen)._remark = remark;
    (value as MarkedTreeDBGen)._latitude = latitude;
    (value as MarkedTreeDBGen)._longitude = longitude;
    (value as MarkedTreeDBGen)._insertTime = insertTime;
    (value as MarkedTreeDBGen)._altitude = altitude;

  }
}