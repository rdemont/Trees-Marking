import '../../businessObj/trunkSize.dart';
import '../businessObj/trunkSizeGen.dart';
import '../../databaseObj/databaseObj.dart';


class TrunkSizeDBGen extends DatabaseObj {
  
  double _minDiameter = 0.0;
  double _maxDiameter = 0.0;
  double _volume = 0.0;
  String _code = '';
  String _name = '';



  TrunkSizeDBGen()
  {
    tableName = 'trunkSize';
  }

  double get minDiameter => _minDiameter;
  double get maxDiameter => _maxDiameter;
  double get volume => _volume;
  String get code => _code;
  String get name => _name;



  set minDiameter(double value)
  {
    if (_minDiameter != value)
    {
      dataUpdated(); 
      _minDiameter = value;
    }
  }
  set maxDiameter(double value)
  {
    if (_maxDiameter != value)
    {
      dataUpdated(); 
      _maxDiameter = value;
    }
  }
  set volume(double value)
  {
    if (_volume != value)
    {
      dataUpdated(); 
      _volume = value;
    }
  }
  set code(String value)
  {
    if (_code != value)
    {
      dataUpdated(); 
      _code = value;
    }
  }
  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }


  Future<TrunkSize> open(int id)
  {
    return query(TrunkSizeGen.TABLE_NAME,where: TrunkSizeGen.COLUMN_ID+" = $id").then((obj)
    {
      TrunkSize result = TrunkSize(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);

      }
      return result ; 
    });
  }

  TrunkSize newObj()
  {
    TrunkSize result = TrunkSize(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    return{
      TrunkSizeGen.COLUMN_MINDIAMETER : _minDiameter,
      TrunkSizeGen.COLUMN_MAXDIAMETER : _maxDiameter,
      TrunkSizeGen.COLUMN_VOLUME : _volume,
      TrunkSizeGen.COLUMN_CODE : _code,
      TrunkSizeGen.COLUMN_NAME : _name,

    };
    
  }


  Future<TrunkSize> fromMap(Map<String,Object?> map)
  async {
    TrunkSize result = TrunkSize(this) ;
    super.id = map[TrunkSizeGen.COLUMN_ID] as int; 
    
    _minDiameter = (map[TrunkSizeGen.COLUMN_MINDIAMETER]??0.0) as double;
    _maxDiameter = (map[TrunkSizeGen.COLUMN_MAXDIAMETER]??0.0) as double;
    _volume = (map[TrunkSizeGen.COLUMN_VOLUME]??0.0) as double;
    _code = (map[TrunkSizeGen.COLUMN_CODE]??'') as String;
    _name = (map[TrunkSizeGen.COLUMN_NAME]??'') as String;



    return result; 

  }



}