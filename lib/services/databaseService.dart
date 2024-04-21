import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt ;
import 'dart:convert' as convert;
import 'dart:developer';

class DatabaseService {
  static const String databaseName = "treesmarkingdb.sqlite";
  static Database? db;

  static const DATABASE_VERSION = 2;
  

  static const SECRET_KEY = "2021_PRIVATE_KEY_ENCRYPT_2021";

  static Future<Database> initializeDb() async {
    final databasePath = (await getApplicationDocumentsDirectory()).path;
    final path = join(databasePath, databaseName);
    print(path);
    return db ??
        await openDatabase(
          path,
          version: DATABASE_VERSION,
          onCreate: (Database db, int version) async {
            await createTables(db);
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            await updateTables(db, oldVersion, newVersion);
          },
          onOpen: (db) async {
            await openDB(db);
          },
        );
  }

  static Future<void> emptyTables()
  {
    print("** empty tables **");
    return DatabaseService.initializeDb().then((db){
      return db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((tables) 
      {
        if (tables.length > 0) 
        {
          for (int i = 0; i < tables.length; i++) 
          {

            String tableName = tables[i]['name'].toString() ; 
            if ((tableName != "sqlite_sequence") && (tableName != "android_metadata"))
            {
              db.execute("DELETE FROM '$tableName' ");
            }
          }
        }
      });
    });
  }

  static openDB(Database db) {
    //db.execute("UPDATE Todo SET groupId = 0 WHERE groupId IS NULL");
    
    print("** rename table **"); 
          

    //db.execute("DROP TABLE markedTree");
    //db.execute("DROP TABLE species");
    //db.execute("DROP TABLE trunkSize");
    //db.execute("DROP TABLE campaign");
    //db.execute("DELETE FROM  markedTree");
    //db.execute("DELETE FROM  species");
    //db.execute("DELETE FROM  campaign");
    //db.execute("DELETE FROM  trunkSize");
    //createTables(db);



    print("** show tables **");
    db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((tables) 
    {
      if (tables.length > 0) 
      {
        String strjson = "{\"tables\":[" ; 
        for (int i = 0; i < tables.length; i++) 
        {

          String tableName = tables[i]['name'].toString() ; 
          if ((tableName != "sqlite_sequence") && (tableName != "android_metadata"))
          {
            db.rawQuery("PRAGMA table_info('$tableName')").then((cols)
            {
              db.rawQuery("SELECT count(*) as nb FROM $tableName").then((count)
              {
                  db.rawQuery("SELECT * FROM $tableName ORDER BY ID ").then((raws){
                  print("TABLE : $tableName / NB-Raw : "+count[0]['nb'].toString());          
                  print(tables[i]);
                  for (int iraw = 0 ; iraw<raws.length;iraw++)
                  {
                    print(raws[iraw]);
                  }

                  
                });

              });

              strjson += "{\"$tableName\":[";
              for(int icol = 0;icol < cols.length;icol++)
              {
                String colName = cols[icol]['name'].toString();
                String colType = cols[icol]['type'].toString();
                String colpk = cols[icol]['pk'].toString();
                String colNotnull = cols[icol]['notnull'].toString();
               
                strjson += "{\"name\":\"$colName\",\"type\":\"$colType\",\"ispk\":\"$colpk\",\"notnull\":\"$colNotnull\"},";
              }
              strjson = strjson.substring(0,strjson.length-1)+"]},";


              if (i == tables.length-1)
              {
                strjson = strjson.substring(0,strjson.length-1)+"]}";
                print("*********************JSON STRUCTURE ******************************");
                log(strjson);
                print("*********************END JSON STRUCTURE ******************************");
              }
            });
          }
        }
        
      }
    });
  }

  static updateTables(Database db, int oldVersion, int newVersion) {
    print(" DB Version : $newVersion");
    db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((value) {
      print(value);
    });


    if (oldVersion < newVersion) {


      if (newVersion == 2) // add group table with link on todo
      {
        
      
        db.execute("""ALTER TABLE markedTree ADD COLUMN altitude FLOAT """);
        db.execute("""ALTER TABLE campaign ADD COLUMN altitude FLOAT """);
        
      }
    }
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS markedTree(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          speciesId int NOT NULL,
          trunkSizeId int NOT null,
          campaignId int NOT null,
          remark TEXT,
          latitude FLOAT,
          longitude FLOAT,
          insertTime DATETIME DEFAULT CURRENT_TIMESTAMP  
      )      
    """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS species(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      code TEXT NOT NULL,
      type INT NOT NULL, 
      communUse BOOLEAN
    )          
    """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS trunkSize(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      minDiameter FLOAT, 
      maxDiameter FLOAT, 
      volume FLOAT,
      code TEXT NOT NULL,
      name TEXT

    )          
    """);    
/*
    await database.execute("DELETE FROM  trunkSize");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (16.0,19.99,0.2,'1')");    
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (20.0,23.99,0.3,'2')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (24.0,27.99,0.5,'3')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (28.0,31.99,0.7,'4')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (32.0,35.99,1.0,'5')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (36.0,39.99,1.3,'6')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (40.0,43.99,1.6,'7')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (44.0,47.99,2.0,'8')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (48.0,51.99,2.4,'9')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (52.0,55.99,2.8,'10')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (56.0,59.99,3.3,'11')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (60.0,63.99,3.8,'12')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (64.0,67.99,4.4,'13')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (68.0,71.99,5.0,'14')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (72.0,75.99,5.7,'15')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (76.0,79.99,6.4,'16')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (80.0,83.99,7.1,'17')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (84.0,87.99,7.9,'18')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (88.0,91.99,8.7,'19')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (92.0,95.99,9.5,'20')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (96.0,99.99,10.3,'21')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (100.0,103.99,11.2,'22')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (104.0,107.99,12.1,'23')");
    await database.execute("INSERT INTO trunkSize (minDiameter,maxDiameter,volume,code) VALUES (108.0,111.99,13.1,'24')");
    
*/

    await database.execute("""
    CREATE TABLE IF NOT EXISTS campaign(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      owner TEXT NOT NULL,
      yard TEXT NOT NULL, 
      remark TEXT,
      latitude FLOAT,
      longitude FLOAT,
      campaignDate DATETIME DEFAULT CURRENT_TIMESTAMP 
    )          
    """);        



    //await database.insert('Groups', Group(name: "Default").toMap());

  }



    static Future<String> generateBackup({bool isEncrypted = false}) async {

    print('GENERATE BACKUP');
   
    var dbs = await DatabaseService.initializeDb();

    List data =[];
    List<String> tables =[];
    
    List<Map<String,dynamic>> listMaps=[];

    return Future(() {      
      return dbs.rawQuery('SELECT * FROM sqlite_master ORDER BY name;').then((tab) 
      async {
        if (tab.length > 0) 
        {
          for (int i = 0; i < tab.length; i++) 
          {

            String tableName = tab[i]['name'].toString() ; 
            if ((tableName != "sqlite_sequence") && (tableName != "android_metadata"))
            {
              tables.add(tableName);
              listMaps = await dbs.query(tableName);
              data.add(listMaps);  
              
            }
          }
        }
      });
    }).then((value) {
      
    List backups=[tables,data];

    String json = convert.jsonEncode(backups);

    if(isEncrypted)
    {

      var key = encrypt.Key.fromUtf8(SECRET_KEY);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key));
      var encrypted = encrypter.encrypt(json, iv: iv);
        
      return encrypted.base64;  
    }
    else
    {
print("*** Backup ***");
log(json);      
      return json;
    }
    },);

  }

  static Future<void>restoreBackup(String backup,{ bool isEncrypted = false}) async {

    await DatabaseService.emptyTables();

    var dbs = await DatabaseService.initializeDb();

    Batch batch = dbs.batch();
    
    var key = encrypt.Key.fromUtf8(SECRET_KEY);
    var iv = encrypt.IV.fromLength(16);
    var encrypter = encrypt.Encrypter(encrypt.AES(key));

    List json = convert.jsonDecode(isEncrypted ? encrypter.decrypt64(backup,iv:iv):backup);

    for (var i = 0; i < json[0].length; i++)
    {
      for (var k = 0; k < json[1][i].length; k++)
      {
         dbs.execute("DELETE FROM ${json[0][i]}").then((value) {
          batch.insert(json[0][i],json[1][i][k]);   
         },);
        
      }
    }

    await batch.commit(continueOnError:false,noResult:true);

    print('RESTORE BACKUP');
  }

}