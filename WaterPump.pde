class WaterPump extends Actor {
  WaterPump(Adjustable source, Adjustable dest, float flowRate) {
    _source = source;
    _dest = dest;
    model = new NumericValue("flow", flowRate, "l/s");
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  NumericValue model;
  Adjustable _source;
  Adjustable _dest;
}
