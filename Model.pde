interface IObservable {
  float value();
  
  String name();
}

/**
  Interface for constrained values.
  */
interface IConstrained {
  boolean full();
  boolean empty();
  float map(float dmin, float dmax);
}

/**
  An adjustable value.
  
  You can adjust the value of an "Adjustable"
  */
interface IAdjustable {
  /**
    Adjust a value
    */
  void adjust(float delta);
  /**
    Check if a value could be adjusted by the specified amount
    */
  float accept(float delta);

  void toMax();
  void toMin();

  void fix();
}

interface ISimValue extends IObservable, IAdjustable, IConstrained {
}

/**
  A value of the simulation.
  
  All value are constrained.
  By default the constraints are Float.MIN_VALUE to Float.MAX_VALUE.
  */
class SimValue implements ISimValue {
  SimValue(String name, float value) {
    this.name = name;
    this.futureValue = this.value = value;
  }
  
  SimValue(String name, float value, float min, float max) {
    this.name = name;
    this.min = min;
    this.max = max;
    this.futureValue = this.value = constrain(value,min,max);
  }
  
  String name() { return name; }
  
  void fix() {
    value = futureValue;
  }
  
  void adjust(float delta) {
    futureValue = constrain(futureValue+delta, min, max);
  }
  
  float accept(float delta) {
    return constrain(futureValue+delta, min, max) - futureValue;
  }
  
  float value() {
    return value;
  }
  
  void toMax() { futureValue = max; }
  void toMin() { futureValue = min; }
  
  boolean full() { return value == max; }
  boolean empty() { return value == min; }
  
  float map(float dmin, float dmax) {
    return SimThing.map(value, min, max, dmin, dmax);
  }
  
  float min() { return min; }
  float max() { return max; }

  private String name;
  private float value;  
  private float futureValue;
  private float min = Float.MIN_VALUE;
  private float max = Float.MAX_VALUE;
}

class InfiniteValue implements IAdjustable {
  void adjust(float delta) { /* nothing to do */ }
  float accept(float delta) { return delta; }
  void toMax() { /* nothing to do */ }
  void toMin() { /* nothing to do */ }
  
  void fix() { /* nothing to do */ }
  
  float value() { return Float.MAX_VALUE; }
  boolean full() { return false; }
  boolean empty() { return false; }
  float map(float dmin, float dmax) { return (dmin+dmax)/2; /* XXX this is silly */ }
}
