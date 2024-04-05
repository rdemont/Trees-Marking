import 'trunkSize.dart';
import '../generate/businessObj/trunkSizeListGen.dart';



class TrunkSizeList extends TrunkSizeListGen
{

  static Future<List<TrunkSize>> getAll([String? order]){
    return TrunkSizeList.getAll(order);
  }
}