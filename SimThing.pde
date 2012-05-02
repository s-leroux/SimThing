Simulation simulation = new Simulation();

void setup() {
  size(300,200);

  WaterTank tank1 = new WaterTank(100,100,200,50);
  WaterTank tank2 = new WaterTank(200,100,200,150);
  Ocean ocean = new Ocean();
  WaterPump pump  = new WaterPump(ocean.model, tank1.model, .5);
  simulation.add(tank1);
  simulation.add(tank2);
  simulation.add(ocean);
  simulation.add(pump);
  simulation.add(new WaterPump(tank1.model, tank2.model, 1));
  simulation.add(new Display(150,20,simulation.date()));
  simulation.add(new Display(150,40,tank1.model));

  simulation.in(0, new RepeatEvent(new InvertEvent(pump.model), 200));
}

void draw() {
  simulation.nextStep();
  simulation.display();
}
