class Simulation {
  Simulation() {
    _date = 0;
    _actors = new ArrayList<Actor>();
    _events = new PriorityQueue<DatedEvent>();
    _state = new HashMap<String,ISimValue>();
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
  
  /**
    Register a new state value
    */
  private void addState(String name, ISimValue value) {
    if (_state.containsKey(name))
      throw new IllegalArgumentException();
      
    _state.put(name, value);
  }
  
  ISimValue  makeValueInRange(String name, float value, float min, float max) {
    ISimValue v = new SimValue(value, min, max);
    addState(name, v);
    
    return v;
  }
  
  ISimValue  makeValue(String name, float value) {
    ISimValue v = new SimValue(value);
    addState(name, v);
    
    return v;
  }
  
  IAdjustable  makeInfiniteValue(String name) {
    ISimValue v = new InfiniteValue();
    addState(name, v);
    
    return v;
  }
  
  IObservable getObservableState(String name) {
    return _state.get(name);
  }
  
  void nextStep() {
    while((_events.size() > 0) && (_events.peek().date <= _date)) {
      DatedEvent de = _events.poll();
      de.event.doIt(this);
    }
    for(Actor actor : _actors) {
      actor.nextStep(this);
    }
    for(ISimValue v : _state.values()) {
      v.fix();
    }
    _date += 1; // quantum
  }
  
  void display() {
    for(Actor actor : _actors) {
      if (actor instanceof GUIActor) { // this is ugly ?
        pushStyle();
        ((GUIActor)actor).display(this);
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

  Observable date() { return new SimpleObservable() {
                                    public float value() { return _date; }
                                    public String name() { return "date"; }
                                  };
  }
 
  class DatedEvent implements Comparable<DatedEvent> {
    DatedEvent(long theDate, Event theEvent) {
      date = theDate;
      event = theEvent;
    }

    int compareTo(DatedEvent o) {
      return (date < o.date) ? -1 : (date > o.date) ? 1 : 0; 
    }
    
    final long  date;
    final Event event;
  }
  
  long                              _date;
  private ArrayList<Actor>          _actors;
  private PriorityQueue<DatedEvent> _events;
  
  // The current state of the simulation
  private Map<String, ISimValue>     _state;
}

