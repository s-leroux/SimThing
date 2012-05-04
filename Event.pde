abstract class Event {
  abstract void doIt(Simulation theSimulation);
}

class UpdateValueEvent extends Event {
  UpdateValueEvent(IAdjustable theValue, float theAdjust) {
    value = theValue;
    adjust = theAdjust;
  }
  
  void doIt(Simulation theSimulation) {
    value.adjust(adjust);
  }
  
  final IAdjustable  value;
  final float  adjust;
}

class MoveEvent extends Event {
  MoveEvent(IAdjustable theSrc, IAdjustable theDst, float theAmount) {
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
  
  final IAdjustable src;
  final IAdjustable dst;
  final float amount;
}

class RepeatEvent extends Event {
  RepeatEvent(long delay, Event event) {
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

