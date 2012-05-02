class WaterTank extends GUIActor {
  WaterTank(float cx, float cy, float capacity, float volume) {
    super(RectByCenter(cx, cy, 78, 78));
    model = new ValueInRange(volume, 0, capacity);
  }
  
  void display() { 
    Rect myShape = (Rect)_shape;
    float x = myShape.x();
    float y = myShape.y();
    float h = myShape.height();
    float w = myShape.width();
    
    pushStyle();
    
    rectMode(CORNERS);

    fill(255);
    noStroke();
    rect(x, y, x+w, y+h);

    fill(100,100,255);
    rect(x, y+h, x+w, y+h-map(model.value, model.min, model.max, 0, h));

    noFill();
    stroke(0);
    rect(x, y, x+w, y+h);

    popStyle();
  }

  final ValueInRange  model;
}

