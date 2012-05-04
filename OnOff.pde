class OnOff extends Indicator {
  OnOff(float cx, float cy, ValueInRange vir) {
    super(cx,cy);
    _vir = vir;
  }
  
  void display() {
    stroke((_pressed) ? 255 : 0);

    super.display();
  }
  
  void userAction() {
    if (_vir.empty())
      _vir.toMax();
    else
      _vir.toMin();
  }
  
  boolean active() {
    return _vir.full();
  }

  
  ValueInRange  _vir;
}
