/**
 An Actor with a graphical representation.
 May respond to user actions (clics) 
*/
class GUIActor extends Actor {
  GUIActor(Shape shape) {
    _shape = shape;
  }
  
  /**
    Display a actor of the given status
    */
  void display() {
    // do nothing by default
  }
  
  /**
    Response to an action triggered by the user (mouse click)
    */
  void userAction() {
    // do nothing by default
  }
  
  /**
    does the actor contains the given point?
   */
  boolean contains(float x, float y) {
    return _shape.contains(x,y);
  }
  
  void mousePressed(int x,int y) {
    _pressed = this.contains(x,y);
  }
  
  void mouseReleased(int x,int y) {
    if (_pressed && this.contains(x,y))
      this.userAction();
    _pressed = false;
  }


  
  protected Shape   _shape;
  protected boolean _pressed; // does the use have clicked on this GUIActor (button not released)
}
