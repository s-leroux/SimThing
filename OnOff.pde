class OnOff extends GUIActor {
  OnOff(float cx, float cy, ValueInRange vir) {
    super(RectByCenter(cx,cy,30,30));
    _vir = vir;
  }
  
  void display() {
    stroke((_pressed) ? 255 : 0);
    fill(_vir.map(100, 255), 100,100);
    _shape.draw();
  }
  
  void userAction() {
    if (_vir.empty())
      _vir.toMax();
    else
      _vir.toMin();
  }

  
  ValueInRange  _vir;
}
