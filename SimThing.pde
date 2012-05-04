Simulation simulation = new Simulation();

void setup() {
  size(300,200);
  
  ValueInRange  tank1  = new ValueInRange("volume cuve A", 50, "l", 0, 200);
  ValueInRange  tank2  = new ValueInRange("volume cuve B", 150, "l", 0, 200);
  InfiniteValue ocean  = new InfiniteValue();

  simulation.add(new Gauge(100,100, 78, 78,tank1));
  simulation.add(new Gauge(200,100, 78, 78,tank2));

  Valve      valve1 = new Valve(ocean, tank1, 1, -1, 1);
  Valve      valve2 = new Valve(tank1, tank2, 2, -2, 2);
  simulation.add(ocean);
  simulation.add(valve1);
  simulation.add(valve2);
  simulation.add(new OnOff(40,100,valve1.model));
  simulation.add(new OnOff(260,100,valve2.model));
  simulation.add(new Display(150,20,simulation.date()));
  simulation.add(new Display(150,40,tank1));
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

