class Simulation {
  Simulation() {
    _date = 0;
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
    if (date < _date)
      return false;
      
    _events.add(new DatedEvent(date, event));
    return true;
  }
  
  void in(long delay, Event event) {
    _events.add(new DatedEvent(_date+delay, event));
  }
  
  void nextStep() {
    while((_events.size() > 0) && (_events.peek().date <= _date)) {
      DatedEvent de = _events.poll();
      de.event.doIt(this);
    }
    for(Actor actor : _actors) {
      actor.nextStep(this);
    }
    _date += 1; // quantum
  }
  
  void display() {
    for(Actor actor : _actors) {
      if (actor instanceof GUIActor) // this is ugly ?
        ((GUIActor)actor).display();
    }
  }
  
  long date() { return _date; }
 
  class DatedEvent implements Comparable<DatedEvent> {
    DatedEvent(long theDate, Event theEvent) {
      date = theDate;
      event = theEvent;
    }

    int compareTo(DatedEvent o) {
      return (date < o.date) ? -1 : (date > o.date) ? 1 : 0; 
    }
    
    final long date;
    final Event event;
  }
  
  private long                      _date;
  private ArrayList<Actor>          _actors;
  private PriorityQueue<DatedEvent> _events;
}

