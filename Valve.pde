class Valve extends Actor {
  Valve(Adjustable source, Adjustable dest, ValueInRange flow) {
    _source = source;
    _dest = dest;
    model = flow;
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  ValueInRange model;
  Adjustable _source;
  Adjustable _dest;
}
