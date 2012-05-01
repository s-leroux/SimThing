class WaterTank extends GUIActor implements Value {
  WaterTank(float cx, float cy, float capacity, float volume) {
    super(new ValueInRangeModel(volume, 0, capacity), RectByCenter(cx, cy, 78, 78));
    _capacity = capacity;
  }
  
  float adjust(float delta) {
    ValueInRangeModel oldModel = (ValueInRangeModel)_futureModel;
    ValueInRangeModel newModel = oldModel.adjust(delta);
    
    _futureModel = newModel;
    
    return newModel.value - oldModel.value;
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
    rect(x, y, x+w, y+h);

    fill(100,100,255);
    rect(x, y+h, x+w, y+h-map(current.value, 0, _capacity, 0, h));

    noFill();
    stroke(0);
    rect(x, y, x+w, y+h);

    popStyle();
  }

  float _capacity;
}

