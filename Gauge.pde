class Gauge extends GUIActor {
  Gauge(float cx, float cy, float width, float height, IObservable state) {
    super(RectByCenter(cx, cy, width, height));
    _state = state;
  }
  
  void display(Simulation sim) { 
    fill(255);
    noStroke();
    _shape.draw();

    fill(100,100,255);
    rectMode(CORNER);
    rect(_shape.left(), _shape.bottom(), _shape.width(), -_state.map(0, _shape.height()));

    noFill();
    stroke(0);
    _shape.draw();
  }
  
  boolean contains(float x, float y) {
    return (x >= _x && x <=_x+_width) && (y >= _y && y <= _y+_height);
  }

  float _x;
  float _y;
  float _width;
  float _height;  
  final IObservable  _state;
}

