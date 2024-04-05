import '../generate/businessObj/trunkSizeGen.dart';

class TrunkSize extends TrunkSizeGen
{
  TrunkSize(super.dbObj);


  @override
  String toString() {
    return "$code - $minDiameter cm - $maxDiameter cm [$volume sv]";
  }

}