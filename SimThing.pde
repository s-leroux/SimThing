Simulation simulation = new Simulation();

void setup() {
  size(300,200);

  WaterTank tank1 = new WaterTank(100,100,200,50);
  WaterTank tank2 = new WaterTank(200,100,200,150);
  Ocean ocean = new Ocean();
  simulation.add(tank1);
  simulation.add(tank2);
  simulation.add(ocean);
  simulation.add(new WaterPump(ocean, tank1, .5));
  simulation.add(new WaterPump(tank1, tank2, 1));
}

void draw() {
  simulation.nextStep();
  simulation.display();
}
