
import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:treesmarking/services/databaseService.dart';

class DatabaseObj{

  static const MODE_NONE = 0;
  
  static const MODE_ISNEW = 1;
  static const MODE_ISUPDATE = 2;
  static const MODE_ISDELETE = 4;

  int mode  = MODE_NONE; 

  int SAVE_RESULT_OK = 0;
  int SAVE_RESULT_ERROR = 1;

  String tableName = '' ; 
  
  int _id = 0  ;

  @protected 
  Map<String, Object?> toMap() 
  {
    return {
      'id':id
    };
  }


  delete(){
    mode = mode | MODE_ISDELETE ; 
  }

  undelete(){
    mode = mode & ~MODE_ISDELETE ; 
  }

  Future<int> save() async {
    if ((mode & MODE_ISDELETE) == MODE_ISDELETE)
    {
      //DELETE 
      if ((mode & MODE_ISNEW) != MODE_ISNEW) 
      {
        final Database db = await DatabaseService.initializeDb();
        int count = await db.delete(tableName,where: "id = $id");
        if (count == 1) return SAVE_RESULT_OK ; 
        return SAVE_RESULT_ERROR ; 
      }
    }else {
      if ((mode & MODE_ISUPDATE) == MODE_ISUPDATE)
      {
        if ((mode & MODE_ISNEW) == MODE_ISNEW)
        {
          //INSERT 
          final Database db = await DatabaseService.initializeDb();
          _id = await db.insert(tableName,this.toMap());
          if (_id >0 ) return SAVE_RESULT_OK ; 
          return SAVE_RESULT_ERROR ; 
        }
        }else {
          final Database db = await DatabaseService.initializeDb();
          int count = await db.update(tableName,this.toMap());
          if (count == 1 ) return SAVE_RESULT_OK ; 
          return SAVE_RESULT_ERROR ; 

        }    
      } 
    return Future(() => SAVE_RESULT_OK);
  } 


  int get id => _id;
   

  @protected
  set id(int value) => _id = value ;

  DatabaseObj()
  {
    mode = MODE_NONE ; 
  }

  dataUpdated()
  {
    mode = mode | MODE_ISUPDATE ; 
  }

  Future<List<Map<String, Object?>>> query(String table,
    {bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset}){

      return DatabaseService.initializeDb().then((db) {
        return db.query(tableName,
          distinct: distinct,
          columns: columns,
          where: where,
          whereArgs: whereArgs,
          groupBy: groupBy,
          having: having,
          orderBy: orderBy,
          limit: limit,
          offset: offset
          );
      });
      

    }

}