import '../../businessObj/campaign.dart';
import '../businessObj/campaignGen.dart';
import '../../databaseObj/databaseObj.dart';


class CampaignDBGen extends DatabaseObj {
  
  String _name = '';
  String _owner = '';
  String _yard = '';
  String _remark = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _campaignDate = DateTime.now();
  double _altitude = 0.0;



  CampaignDBGen()
  {
    tableName = 'campaign';
  }

  String get name => _name;
  String get owner => _owner;
  String get yard => _yard;
  String get remark => _remark;
  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get campaignDate => _campaignDate;
  double get altitude => _altitude;



  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }
  set owner(String value)
  {
    if (_owner != value)
    {
      dataUpdated(); 
      _owner = value;
    }
  }
  set yard(String value)
  {
    if (_yard != value)
    {
      dataUpdated(); 
      _yard = value;
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
  set campaignDate(DateTime value)
  {
    if (_campaignDate != value)
    {
      dataUpdated(); 
      _campaignDate = value;
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


  Future<Campaign> open(int id)
  {
    return query(CampaignGen.TABLE_NAME,where: CampaignGen.COLUMN_ID+" = $id").then((obj)
    {
      Campaign result = Campaign(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);

      }
      return result ; 
    });
  }

  Campaign newObj()
  {
    Campaign result = Campaign(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      CampaignGen.COLUMN_NAME : _name,
      CampaignGen.COLUMN_OWNER : _owner,
      CampaignGen.COLUMN_YARD : _yard,
      CampaignGen.COLUMN_REMARK : _remark,
      CampaignGen.COLUMN_LATITUDE : _latitude,
      CampaignGen.COLUMN_LONGITUDE : _longitude,
      CampaignGen.COLUMN_CAMPAIGNDATE : _campaignDate.millisecondsSinceEpoch,
      CampaignGen.COLUMN_ALTITUDE : _altitude,

    };
    
  }


  Future<Campaign> fromMap(Map<String,Object?> map)
  async {
    Campaign result = Campaign(this) ;
    super.id = map[CampaignGen.COLUMN_ID] as int; 
    
    _name = (map[CampaignGen.COLUMN_NAME]??'') as String;
    _owner = (map[CampaignGen.COLUMN_OWNER]??'') as String;
    _yard = (map[CampaignGen.COLUMN_YARD]??'') as String;
    _remark = (map[CampaignGen.COLUMN_REMARK]??'') as String;
    _latitude = (map[CampaignGen.COLUMN_LATITUDE]??0.0) as double;
    _longitude = (map[CampaignGen.COLUMN_LONGITUDE]??0.0) as double;
    _campaignDate = DateTime.fromMillisecondsSinceEpoch((map[CampaignGen.COLUMN_CAMPAIGNDATE]??0) as int);
    _altitude = (map[CampaignGen.COLUMN_ALTITUDE]??0.0) as double;



    return result; 

  }

 
  @override
  clone(DatabaseObj value)
  {
    super.clone(value);
    (value as CampaignDBGen)._name = name;
    value._owner = owner;
    value._yard = yard;
    value._remark = remark;
    value._latitude = latitude;
    value._longitude = longitude;
    value._campaignDate = campaignDate;
    value._altitude = altitude;

  }
}