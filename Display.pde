class Display extends GUIActor {
  Display(float cx, float cy, ReadableValue model) {
    super(RectByCenter(cx,cy,100, 20));
    _model = model;
  }
  
  void display() {
    pushStyle();
    fill(200);
    stroke(255,100,100);
    _shape.draw();
    
    textAlign(RIGHT,CENTER);
    fill(0);
    text(_model.value(), _shape.cx()+40, _shape.cy());
    
    popStyle();
  }

  ReadableValue _model;
}
