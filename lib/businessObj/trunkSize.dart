import 'gen/trunkSizeImpl.dart';

class TrunkSize extends TrunkSizeImpl
{
  TrunkSize(super.dbObj);


  @override
  String toString() {
    return this.code +" - "+this.minDiameter.toString()+" cm - "+this.maxDiameter.toString()+" cm ["+this.volume.toString()+"sv]";
  }

}