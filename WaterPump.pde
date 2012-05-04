class WaterPump extends Actor {
  WaterPump(Adjustable source, Adjustable dest, float flowRate) {
    _source = source;
    _dest = dest;
    model = new NumericValue(flowRate);
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  NumericValue model;
  Adjustable _source;
  Adjustable _dest;
}
