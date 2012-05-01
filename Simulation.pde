class Simulation {
  Simulation() {
    actors = new ArrayList<Actor>();
  }
  
  void add(Actor actor) {
    actors.add(actor);
  }
  
  void nextStep() {
    for(Actor actor : actors) {
      actor.nextStep();
    }
    for(Actor actor : actors) {
      actor.nextStatus();
    }
  }
  
  void display() {
    for(Actor actor : actors) {
      if (actor instanceof GUIActor) // this is ugly ?
        ((GUIActor)actor).display();
    }
  }
  
  
  
  private ArrayList<Actor>  actors;
}
