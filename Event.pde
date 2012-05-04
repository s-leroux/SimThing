abstract class Event {
  abstract void doIt(Simulation theSimulation);
}

class UpdateValueEvent extends Event {
  UpdateValueEvent(Adjustable theValue, float theAdjust) {
    value = theValue;
    adjust = theAdjust;
  }
  
  void doIt(Simulation theSimulation) {
    value.adjust(adjust);
  }
  
  final Adjustable  value;
  final float  adjust;
}

class MoveEvent extends Event {
  MoveEvent(Adjustable theSrc, Adjustable theDst, float theAmount) {
    src = theSrc;
    dst = theDst;
    amount = theAmount;
  }
  
  void doIt(Simulation theSimulation) {
    // Source and destination must agree to a common amount to move
    float theAmount = amount;
    theAmount = src.accept(-theAmount);
    theAmount = dst.accept(-theAmount);
    
    src.adjust(-theAmount);
    dst.adjust(theAmount);
  }
  
  final Adjustable src;
  final Adjustable dst;
  final float amount;
}

class InvertEvent extends Event {
  InvertEvent(Adjustable theValue) {
    value = theValue;
  }
  
  void doIt(Simulation theSimulation) {
    value.invert();
  }
  
  final Adjustable value;
}

class RepeatEvent extends Event {
  RepeatEvent(Event event, long delay) {
    _event = event;
    _delay = delay;
  }
  
  void doIt(Simulation theSimulation) {
    _event.doIt(theSimulation);
    theSimulation.in(_delay, this);
  }
  
  final Event _event;
  final long _delay;
}

