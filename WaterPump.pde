class WaterPump extends Actor {
  WaterPump(Value source, Value dest, float flowRate) {
    super(new Model());
    _source = source;
    _dest = dest;
    _flowRate = flowRate;
  }
  
  void nextStep() {
    float s = -_source.adjust(-_flowRate);
    float d = _dest.adjust(s);
    if (d != s)
      _source.adjust(s-d);
      
    if (d != _flowRate)
      _flowRate = -_flowRate;
  }

  float _flowRate;
  Value _source;
  Value _dest;
}
