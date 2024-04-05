import '../../businessObj/campaign.dart';
import '../businessObj/campaignGen.dart';
import '../../databaseObj/databaseObj.dart';


class CampaignDBGen extends DatabaseObj {
  
  String _name = '';
  String _remark = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _campaignDate = DateTime.now();



  CampaignDBGen()
  {
    tableName = 'campaign';
  }

  String get name => _name;
  String get remark => _remark;
  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get campaignDate => _campaignDate;



  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
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


  Future<Campaign> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj)
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
      CampaignGen.COLUMN_REMARK : _remark,
      CampaignGen.COLUMN_LATITUDE : _latitude,
      CampaignGen.COLUMN_LONGITUDE : _longitude,
      CampaignGen.COLUMN_CAMPAIGNDATE : _campaignDate.millisecondsSinceEpoch,

    };
    
  }


  Future<Campaign> fromMap(Map<String,Object?> map)
  async {
    Campaign result = Campaign(this) ;
    super.id = map["id"] as int; 
    
    _name = (map[CampaignGen.COLUMN_NAME]??'') as String;
    _remark = (map[CampaignGen.COLUMN_REMARK]??'') as String;
    _latitude = (map[CampaignGen.COLUMN_LATITUDE]??0.0) as double;
    _longitude = (map[CampaignGen.COLUMN_LONGITUDE]??0.0) as double;
    _campaignDate = DateTime.fromMillisecondsSinceEpoch((map[CampaignGen.COLUMN_CAMPAIGNDATE]??0) as int);



    return result; 

  }



}