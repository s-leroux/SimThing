class Valve extends Actor {
  Valve(IAdjustable source, IAdjustable dest, IObservable flow) {
    _source = source;
    _dest = dest;
    _flow = flow;
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, _flow.value()));
  }

  IObservable _flow;
  IAdjustable _source;
  IAdjustable _dest;
}
