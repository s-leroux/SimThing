Simulation simulation = new Simulation();

void setup() {
  size(200,200);

  WaterTank tank = new WaterTank(100,100,200,50);
  simulation.add(tank);
  simulation.add(new WaterPump(tank, 1));
}

void draw() {
  simulation.nextStep();
  simulation.display();
}
