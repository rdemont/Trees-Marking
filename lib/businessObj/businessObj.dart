

import 'package:treesmarking/databaseObj/databaseObj.dart';

abstract class BusinessObj{

  DatabaseObj dbObj ;

  BusinessObj(this.dbObj);
  
  int get id => dbObj.id; 

  delete(){
    dbObj.delete(); 
  }

  undelete(){
    dbObj.undelete(); 
  }

  Future<int> save(){
    return dbObj.save().then((value) 
    {
print ("BusinessObj - SAVE- ID: $id");      
      return value ;
    });
  }

  cloneDB(DatabaseObj value)
  {
    dbObj.clone(value);
  }


  
  BusinessObj clone(); 

}