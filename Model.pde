/**
  An observable value.
  
  You can read the value of an "Observable".
  */
interface Observable {
  float value();
}

/**
  An adjustable value.
  
  You can adjust the value of an "Adjustable"
  */
interface Adjustable {
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

class InfiniteValue implements Adjustable {
  void invert() { /* nothing to do */ }
  void adjust(float delta) { /* nothing to do */ }
  float accept(float delta) { return delta; }
}

class NumericValue implements Observable, Adjustable {
  NumericValue(float theValue) {
    value = theValue;
  }

  void invert() { value = -value; }
  void adjust(float delta) { value += delta; }
  float accept(float delta) { return delta; }
  
  float value() { return value; }
  
  protected float value;
}

class ValueInRange extends NumericValue {
  ValueInRange(float theValue, float theMin, float theMax) {
    super(constrain(theValue, theMin, theMax));
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
  
  void toMax() { value = max; }
  void toMin() { value = min; }
  
  boolean full() { return value == max; }
  boolean empty() { return value == min; }
  
  float map(float dmin, float dmax) {
    return SimThing.map(value, min, max, dmin, dmax);
  }
  
  final float min;
  final float max;
}

