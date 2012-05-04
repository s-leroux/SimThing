class Valve extends Actor {
  Valve(Adjustable source, Adjustable dest, float flowRate, float min, float max) {
    _source = source;
    _dest = dest;
    model = new ValueInRange(flowRate, min, max);
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  ValueInRange model;
  Adjustable _source;
  Adjustable _dest;
}
