/**
  Infinite water source and sink
  */
class Ocean extends Actor implements Value {
  Ocean() {
    super(new Model());
  }
  
  float adjust(float v) { return v; };
}
