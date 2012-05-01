class WaterPump extends Actor {
  WaterPump(ValueInRange tank, float flowRate) {
    super(new Model());
    _tank = tank;
    _flowRate = flowRate;
  }
  
  void nextStep() {
    ValueInRangeModel m = _tank.adjust(_flowRate);
    if (m.empty() || m.full())
      _flowRate = -_flowRate;
  }

  float _flowRate;
  ValueInRange _tank;
}
