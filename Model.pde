/**
  An observable value.
  
  You can read the value of an "Observable".
  */
interface Observable {
  float value();
  String name();
  String unit();
}

interface Constrained {
  float min();
  float max();
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

abstract class SimpleObservable implements Observable {
  String name() { return ""; }
  String unit() { return ""; }
}

abstract class SimpleAdjustable extends SimpleObservable implements Adjustable {
  void invert() {
    float v = value();
    if (v>0) {
      adjust(-2*v);
    }
    else {
      adjust(2*v);
    }
  }
  
  float accept(float delta) { return delta; }
}

/**
  An Observal and Adjustable instance with sensible defaults.
  
  Require only to override adjust and value.
 */
abstract class SimpleValue extends SimpleObservable implements Adjustable {
  void invert() {
    float v = value();
    if (v>0) {
      adjust(-2*v);
    }
    else {
      adjust(2*v);
    }
  }
  
  float accept(float delta) { return delta; }
}

class InfiniteValue implements Adjustable {
  void invert() { /* nothing to do */ }
  void adjust(float delta) { /* nothing to do */ }
  float accept(float delta) { return delta; }
}

class NumericValue implements Observable, Adjustable {
  NumericValue(String theName, float theValue, String theUnit) {
    value = theValue;
    _name = theName;
    _unit = theUnit;
  }

  void invert() { value = -value; }
  void adjust(float delta) { value += delta; }
  float accept(float delta) { return delta; }
  
  float value() { return value; }
  
  protected float value;
  
  
  // ==============
  String name() { return _name; }
  String unit() { return _unit; }
  
  private final String _name;
  private final String _unit;
}

class ValueInRange extends NumericValue implements Constrained {
  ValueInRange(String name, float theValue, String unit, float theMin, float theMax) {
    super(name, constrain(theValue, theMin, theMax), unit);
    _min = theMin;
    _max = theMax;
  } 
  
  void invert() {
    value = constrain(-value, _min, _max);
  }
  
  void adjust(float delta) {
    value = constrain(value+delta, _min, _max);
  }
  
  float accept(float delta) {
    return constrain(value+delta, _min, _max) - value;
  }
  
  void toMax() { value = _max; }
  void toMin() { value = _min; }
  
  boolean full() { return value == _max; }
  boolean empty() { return value == _min; }
  
  float map(float dmin, float dmax) {
    return SimThing.map(value, _min, _max, dmin, dmax);
  }
  
  float min() { return _min; }
  float max() { return _max; }
  
  final float _min;
  final float _max;
}


