

import '../businessObj/campaign.dart';
import 'databaseObj.dart';

class CampaignDB extends DatabaseObj {
  


  String _name = '';
String _remark = '';
double _latitude = 0.0;
double _longitude = 0.0;
DateTime _campaignDate = DateTime.now();



  CampaignDB()
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
    return query(tableName,where: "id = $id").then((obj){
      Campaign result = Campaign(this);
      if (obj.isEmpty)
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
    //Map<String, Object?> result = super.toMap();
   return{
      'name': _name,
'remark': _remark,
'latitude': _latitude,
'longitude': _longitude,
'campaignDate': _campaignDate.millisecondsSinceEpoch,

    };
    
  }


  Campaign fromMap(Map<String,Object?> map)
  {
    Campaign result = Campaign(this) ;
    super.id = map["id"] as int; 
    
    _name = map['name'] as String;
_remark = map['remark'] as String;
_latitude = map['latitude'] as double;
_longitude = map['longitude'] as double;
_campaignDate = DateTime.fromMicrosecondsSinceEpoch(map['campaignDate'] as int);



    return result; 

  }



}