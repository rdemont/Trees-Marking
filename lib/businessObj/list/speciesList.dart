import '../../services/databaseService.dart';
import '../species.dart';


class SpeciesList
{

  
  static Future<List<Species>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("species",orderBy: "name").then((raws){
        return raws.map((e) => Species.fromMap(e)).toList();
      });
    });
  }

  static Future<Map<int, Species>> getObjectsMap(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("campaign",orderBy: "id").then((raws){
        Map<int, Species> result = {} ;
        for (int i=0;i<raws.length;i++)
        {
          Species obj = Species.fromMap(raws[i]);

          result[obj.id]  = obj;
          
        }
        return result ; 
      });
    });
  }

}