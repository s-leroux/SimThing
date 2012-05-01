/**
  Data-centric model for actors status
  */
class Model {
  Model clone() { return new Model(); };
}

class ValueInRangeModel extends Model {
  ValueInRangeModel(float theValue, float theMin, float theMax) {
    value = constrain(theValue, theMin, theMax);
    min = theMin;
    max = theMax;
  } 
  
  ValueInRangeModel adjust(float delta) {
    return new ValueInRangeModel(value+delta, min, max);
  }
  
  boolean full() { return value == max; }
  boolean empty() { return value == min; }
  
  ValueInRangeModel clone() { return new ValueInRangeModel(value, min, max); }
  
  final float value;
  final float min;
  final float max;
}

interface ValueInRange {
  ValueInRangeModel adjust(float delta);
}
