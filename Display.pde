class Display extends GUIActor {
  Display(float cx, float cy, Observable model) {
    super(RectByCenter(cx,cy,140, 20));
    _model = model;
  }
  
  void display() {
    pushStyle();
    fill(200);
    stroke(255,100,100);
    _shape.draw();
    
    textAlign(RIGHT,BASELINE);
    fill(0);
    text(_model.value(), _shape.cx()+40, _shape.cy()+5);
    textAlign(LEFT,BASELINE);
    text(_model.unit(), _shape.cx()+45, _shape.cy()+5);
    
    popStyle();
  }

  Observable _model;
}
