class Simulation {
  Simulation() {
    _date = new NumericValue(0);
    _actors = new ArrayList<Actor>();
    _events = new PriorityQueue<DatedEvent>();
  }
  
  void add(Actor actor) {
    _actors.add(actor);
  }
  
  /**
    Schedule an event at the given date.
    
    Do nothing and returns false if the date is in the past.
    (XXX Should raise an exception?)
    */
  boolean at(long date, Event event) {
    if (date < _date.value())
      return false;
      
    _events.add(new DatedEvent(date, event));
    return true;
  }
  
  void in(long delay, Event event) {
    _events.add(new DatedEvent(_date.value()+delay, event));
  }
  
  void nextStep() {
    float date = _date.value();
    while((_events.size() > 0) && (_events.peek().date <= date)) {
      DatedEvent de = _events.poll();
      de.event.doIt(this);
    }
    for(Actor actor : _actors) {
      actor.nextStep(this);
    }
    _date.adjust(1); // quantum
  }
  
  void display() {
    for(Actor actor : _actors) {
      if (actor instanceof GUIActor) { // this is ugly ?
        pushStyle();
        ((GUIActor)actor).display();
        popStyle();
      }
    }
  }
  
  void mousePressed(int x,int y) {
    for(Actor actor : _actors) {
      if (actor instanceof GUIActor) { // this is ugly ?
        ((GUIActor)actor).mousePressed(x,y);
      }
    }
  }
  
  void mouseReleased(int x,int y) {
    for(Actor actor : _actors) {
      if (actor instanceof GUIActor) { // this is ugly ?
        ((GUIActor)actor).mouseReleased(x,y);
      }
    }
  }

  
  ReadableValue date() { return _date; }
 
  class DatedEvent implements Comparable<DatedEvent> {
    DatedEvent(float theDate, Event theEvent) {
      date = theDate;
      event = theEvent;
    }

    int compareTo(DatedEvent o) {
      return (date < o.date) ? -1 : (date > o.date) ? 1 : 0; 
    }
    
    final float date;
    final Event event;
  }
  
  NumericValue                      _date; // XXX Using a float here is only precise up to 16777216
  private ArrayList<Actor>          _actors;
  private PriorityQueue<DatedEvent> _events;
}

