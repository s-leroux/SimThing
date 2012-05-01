class WaterTank extends GUIActor {
  WaterTank(float cx, float cy, float capacity, float volume) {
    super(new WaterTankStatus(min(capacity,volume)), RectByCenter(cx, cy, 78, 78));
    _capacity = capacity;
  }
  
  void display() { 
    Rect myShape = (Rect)_shape;
    float x = myShape.x();
    float y = myShape.y();
    float h = myShape.height();
    float w = myShape.width();
    WaterTankStatus current = (WaterTankStatus)_currentStatus;
    
    pushStyle();
    
    rectMode(CORNERS);

    fill(255);
    noStroke();
    rect(x, y, x+w, x+h);

    fill(100,100,255);
    rect(x, y+h, x+w, x+h-map(current.volume, 0, _capacity, 0, h));

    noFill();
    stroke(0);
    rect(x, y, x+w, x+h);

    popStyle();
  }
  
  float adjustVolumeUpTo(float vol) {
    WaterTankStatus future = (WaterTankStatus)_futureStatus;
    if (vol > 0)
      vol = min(_capacity - future.volume, vol);
    if (vol < 0)
      vol = min(future.volume, vol);
    
    future.volume += vol;
    
    return vol;
  }

  float _capacity;
}

class WaterTankStatus extends Status {
  WaterTankStatus(float theVolume) {
    volume = theVolume;
  }
  
  public Status clone() {
    return new WaterTankStatus(volume);
  }

  
  float volume;
}

