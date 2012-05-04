abstract class Switch extends Indicator {
  Switch(float cx, float cy) {
    super(cx,cy);
  }
  
  void display() {
    stroke((_pressed) ? 255 : 0);

    super.display();
  }
}

class OnOff extends Switch {
  OnOff(float cx, float cy, ValueInRange vir) {
    super(cx,cy);
    _vir = vir;
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
