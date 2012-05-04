/**
  Simple boolean indicator
  */
abstract class Indicator extends GUIActor {
  Indicator(float cx, float cy) {
    super(RectByCenter(cx,cy,30,30));
  }
  
  abstract public boolean active();
  
  void display(Simulation s) {
    fill(active() ? 255 : 100, 100,100);
      
    _shape.draw();
  }
}

