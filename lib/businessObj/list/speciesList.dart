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

}