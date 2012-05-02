/**
  Data-centric model for actors status
  */
interface Value {
  /**
    Change the sign of a value
    */
  void invert();

  /**
    Adjust a value
    */
  void adjust(float delta);
  /**
    Check if a value could be adjusted by the specified amount
    */
  float accept(float delta);
  
}

class NumericValue implements Value {
  NumericValue(float theValue) {
    value = theValue;
  }

  void invert() { value = -value; }
  void adjust(float delta) { value += delta; }
  float accept(float delta) { return delta; }
  
  float value() { return value; }
  
  private float value;
}

class InfiniteValue implements Value {
  void invert() { /* nothing to do */ }
  void adjust(float delta) { /* nothing to do */ }
  float accept(float delta) { return delta; }
}

class ValueInRange implements Value {
  ValueInRange(float theValue, float theMin, float theMax) {
    value = constrain(theValue, theMin, theMax);
    min = theMin;
    max = theMax;
  } 
  
  void invert() {
    value = constrain(-value, min, max);
  }
  
  void adjust(float delta) {
    value = constrain(value+delta, min, max);
  }
  
  float accept(float delta) {
    return constrain(value+delta, min, max) - value;
  }
  
  boolean full() { return value == max; }
  boolean empty() { return value == min; }
  
  float       value;
  final float min;
  final float max;
}

