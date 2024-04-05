import '../../generate/businessObj/speciesGen.dart';
import '../../services/databaseService.dart';
import '../species.dart';


class SpeciesList
{

  
  static Future<List<Species>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("species",orderBy: "name").then((raws)async {
        List<Species> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await SpeciesGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
/*
  static Future<Map<int, Species>> getObjectsMap(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("campaign",orderBy: "id").then((raws){
        Map<int, Species> result = {} ;
        for (int i=0;i<raws.length;i++)
        {
          Species obj = SpeciesImpl.fromMap(raws[i]);

          result[obj.id]  = obj;
          
        }
        return result ; 
      });
    });
  }
*/
}