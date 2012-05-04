class Display extends GUIActor {
  Display(float cx, float cy, Observable model) {
    super(RectByCenter(cx,cy,200, 20));
    _model = model;
  }
  
  void display(Simulation sim) {
    fill(255,100,100);
    stroke(255,100,100);
    _shape.draw();

    fill(0);
    textAlign(LEFT,BASELINE);
    text(_model.name(), _shape.left()+5, _shape.cy()+5);
    text("XXXX", _shape.cx()+5, _shape.cy()+5);
    
    rectMode(CORNERS);
    fill(200);
    stroke(255,100,100);
    rect(_shape.left()+60, _shape.top(), _shape.right(), _shape.bottom());
    
    textAlign(RIGHT,BASELINE);
    fill(0);
    text(_model.value(), _shape.cx()+70, _shape.cy()+5);
    textAlign(LEFT,BASELINE);
    text(_model.unit(), _shape.cx()+75, _shape.cy()+5);
  }

  Observable _model;
}
