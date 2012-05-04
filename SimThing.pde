Simulation simulation = new Simulation();

void setup() {
  size(300,500);
  
  ValueInRange  tank1  = new ValueInRange("V_A", 50, "l", 0, 200);
  ValueInRange  tank2  = new ValueInRange("V_B", 150, "l", 0, 200);
  InfiniteValue ocean  = new InfiniteValue();

  simulation.add(new Gauge(100,100, 78, 78,tank1));
  simulation.add(new Gauge(220,100, 78, 78,tank2));

  ValueInRange  valve1A_flow = new ValueInRange("flow", 0, "l/s", 0, .5);
  ValueInRange  valve1B_flow = new ValueInRange("flow", 0, "l/s", 0, .5);
  ValueInRange  valve2A_flow = new ValueInRange("flow", 0, "l/s", 0, .3);
  ValueInRange  valve2B_flow = new ValueInRange("flow", 0, "l/s", 0, .3);
  simulation.add(new Valve(ocean, tank1, valve1A_flow));
  simulation.add(new Valve(tank1, ocean, valve1B_flow));
  simulation.add(new Valve(tank1, tank2, valve2A_flow));
  simulation.add(new Valve(tank2, tank1, valve2B_flow));
  simulation.add(new OnOff(40,80,valve1A_flow));
  simulation.add(new OnOff(40,120,valve1B_flow));
  simulation.add(new OnOff(160,80,valve2A_flow));
  simulation.add(new OnOff(160,120,valve2B_flow));
  simulation.add(new Display(150,20,simulation.date()));
  simulation.add(new Display(150,40,tank1));
  
  
  // ------------------------------
  // Logic gate
  final ValueInRange  in1 = new ValueInRange("in1", 0, "", 0, 1);
  final ValueInRange  in2 = new ValueInRange("in1", 0, "", 0, 1);
  final ValueInRange  in3 = new ValueInRange("in1", 0, "", 0, 1);
  final ValueInRange  in4 = new ValueInRange("in1", 0, "", 0, 1);


  rectMode(CORNERS);
  rect(100,180,160,340);
  
  simulation.add(new OnOff(100, 200, in1));
  simulation.add(new OnOff(100, 260, in2));
  simulation.add(new Indicator(160, 200) {
   public boolean active() { return in1.value()*in2.value() != 0; } 
  });
  simulation.add(new OnOff(160, 260, in3));
  simulation.add(new OnOff(160, 320, in4));
  simulation.add(new Indicator(100, 320) {
   public boolean active() { return in3.value()*in4.value() != 0; } 
  });
  
  
  // ------------------------------
  // Periodic
  final boolean  b[] = new boolean[5];

  simulation.add(new Switch(60, 420) {
    public boolean active() { return b[0]; }
    public void    userAction() { b[0] = !b[0]; }
  });

  
  for(int i = 1; i < b.length; ++i) {
    final int v = i;
    
    b[i] = false;
    simulation.add(new Indicator(80+40*i, 420) {
     public boolean active() { return b[v]; } 
    });

    simulation.in(0, new RepeatEvent(200, new Event() {
      public void doIt(Simulation theSimulation) {
        b[v] = b[v-1];
      }
    }));

  }
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

