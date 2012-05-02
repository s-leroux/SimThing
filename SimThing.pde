Simulation simulation = new Simulation();

void setup() {
  size(300,200);

  WaterTank tank1 = new WaterTank(100,100,200,50);
  WaterTank tank2 = new WaterTank(200,100,200,150);
  Ocean ocean = new Ocean();
  Valve      valve1 = new Valve(ocean.model, tank1.model, 1, -1, 1);
  Valve      valve2 = new Valve(tank1.model, tank2.model, 2, -2, 2);
  simulation.add(tank1);
  simulation.add(tank2);
  simulation.add(ocean);
  simulation.add(valve1);
  simulation.add(valve2);
  simulation.add(new OnOff(40,100,valve1.model));
  simulation.add(new OnOff(260,100,valve2.model));
  simulation.add(new Display(150,20,simulation.date()));
  simulation.add(new Display(150,40,tank1.model));
}

void draw() {
  simulation.nextStep();
  simulation.display();
}

void mousePressed() {
  simulation.mousePressed(mouseX, mouseY);
}

void mouseReleased() {
  simulation.mouseReleased(mouseX, mouseY);
}

