import '../../businessObj/species.dart';
import '../../services/databaseService.dart';
import 'speciesGen.dart';



class SpeciesListGen
{

  
  static Future<List<Species>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(SpeciesGen.TABLE_NAME,orderBy: order??SpeciesGen.COLUMN_ID).then((raws) async {
        List<Species> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await SpeciesGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}