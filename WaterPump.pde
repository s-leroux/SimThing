class WaterPump extends Actor {
  WaterPump(WaterTank tank, float flowRate) {
    super(new Status());
    _tank = tank;
    _flowRate = flowRate;
  }
  
  void nextStep() {
    float v = _tank.adjustVolumeUpTo(_flowRate);
    if (v != _flowRate)
      _flowRate = -_flowRate;
  }

  float _flowRate;
  WaterTank _tank;
}
