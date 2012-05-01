class WaterTank extends GUIActor implements ValueInRange {
  WaterTank(float cx, float cy, float capacity, float volume) {
    super(new ValueInRangeModel(volume, 0, capacity), RectByCenter(cx, cy, 78, 78));
    _capacity = capacity;
  }
  
  ValueInRangeModel adjust(float delta) {
    ValueInRangeModel newModel = ((ValueInRangeModel)_futureModel).adjust(delta);
    _futureModel = newModel;
    
    return newModel;
  }

  
  void display() { 
    Rect myShape = (Rect)_shape;
    float x = myShape.x();
    float y = myShape.y();
    float h = myShape.height();
    float w = myShape.width();
    ValueInRangeModel current = (ValueInRangeModel)_currentModel;
    
    pushStyle();
    
    rectMode(CORNERS);

    fill(255);
    noStroke();
    rect(x, y, x+w, x+h);

    fill(100,100,255);
    rect(x, y+h, x+w, x+h-map(current.value, 0, _capacity, 0, h));

    noFill();
    stroke(0);
    rect(x, y, x+w, x+h);

    popStyle();
  }

  float _capacity;
}

