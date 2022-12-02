import 'package:injectable/injectable.dart';

abstract class ABConstants {
  printVariant();
}

@Injectable(as: ABConstants)
@Environment('dev')
class ABConstantsDev extends ABConstants{
  static int variant = 1;

  void printVariant(){
    print(variant);
  }
}

@Injectable(as: ABConstants)
@Environment('prod')
class ABConstantsProd extends ABConstantsDev{
  static int variant = 2;

  void printVariant(){
    print(variant);
  }
}