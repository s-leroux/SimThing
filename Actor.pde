/**
 An actor of the simulation
 
 Each actor has two status: 
   Its /current/ status - This one should be viewed as immutable.
   Its /future/ status - All changes of the status should take place in this one
 */
class Actor {
  Actor(Model model) {
    _currentModel = model;
    _futureModel = (Model)model.clone();
  }

  void nextStep() {
    
  }

  /**  */
  Model nextModel() {
    Model pastModel = _currentModel;
    _currentModel = _futureModel;
    _futureModel = (Model)_futureModel.clone();
    
    return pastModel;
  }
  
  Model _currentModel;
  Model _futureModel;
}

