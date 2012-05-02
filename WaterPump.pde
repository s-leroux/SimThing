class WaterPump extends Actor {
  WaterPump(Value source, Value dest, float flowRate) {
    _source = source;
    _dest = dest;
    model = new NumericValue(flowRate);
  }
  
  void nextStep(Simulation theSimulation) {
    theSimulation.in(1, new MoveEvent(_source, _dest, model.value()));
  }

  NumericValue model;
  Value _source;
  Value _dest;
}
