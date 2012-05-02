/**
  A shape
*/
interface Shape {
  /**
    Is the given point in the shape?
    */
  abstract boolean contains(float x, float y);
  
  /**
    Draw the shape using the current fill/stroke - mode is not garanteed
    */
  abstract void draw();
  
  abstract float cx();
  abstract float cy();
}

class Rect implements Shape {  
  boolean contains(float x, float y) {
    return (x >= _x && x <=_x+_width) && (y >= _y && y <= _y+_height);
  }
  
  float x() { return _x; }
  float y() { return _y; }
  float cx() { return _x+_width/2; }
  float cy() { return _y+_height/2; }
  float width() { return _width; }
  float height() { return _height; }
  
  
  float _x, _y, _width, _height;

  protected Rect(float x, float y, float width, float height) {
    _x = x;
    _y = y;
    _width = width;
    _height = height;
    
    if (_width < 0) {
      _x += _width;
      _width = -_width;
    }
    
    if (_height < 0) {
      _y += _height;
      _height = -_height;
    }
  }
  
  void draw() {
    rectMode(CORNER);
    rect(_x,_y,_width,_height);
  }
}

Rect RectByCenter(float cx, float cy, float width, float height) {
    return new Rect(cx-width/2, cy-height/2, width, height);
}

