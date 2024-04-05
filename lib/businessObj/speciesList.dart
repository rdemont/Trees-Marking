import 'species.dart';
import '../generate/businessObj/speciesListGen.dart';



class SpeciesList extends SpeciesListGen
{

  static Future<List<Species>> getAll([String? order]){
    return SpeciesListGen.getAll(order);
  }
}