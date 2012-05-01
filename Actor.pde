/**
 An actor of the simulation
 
 Each actor has two status: 
   Its /current/ status - This one should be viewed as immutable.
   Its /future/ status - All changes of the status should take place in this one
 */
class Actor {
  Actor(Status status) {
    _currentStatus = status;
    _futureStatus = (Status)status.clone();
  }

  void nextStep() {
    
  }

  /**  */
  Status nextStatus() {
    Status pastStatus = _currentStatus;
    _currentStatus = _futureStatus;
    _futureStatus = (Status)_futureStatus.clone();
    
    return pastStatus;
  }
  
  Status _currentStatus;
  Status _futureStatus;
}
