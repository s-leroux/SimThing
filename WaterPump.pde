class WaterPump extends Actor {
  WaterPump(IAdjustable source, IAdjustable dest, float flowRate) {
    _source = source;
    _dest = dest;
    model = new NumericValue("flow", flowRate, "l/s");
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  NumericValue model;
  IAdjustable _source;
  IAdjustable _dest;
}
