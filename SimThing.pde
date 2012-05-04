Simulation simulation = new Simulation();

void setup() {
  size(300,500);
  
  ISimValue    va = simulation.makeValueInRange("V_A", 50, 0, 200);
  ISimValue    vb = simulation.makeValueInRange("V_B", 150, 0, 200);
  IAdjustable  ocean = simulation.makeInfiniteValue("ocean");
  
  simulation.add(new Gauge(100,100, 78, 78, va));
  simulation.add(new Gauge(220,100, 78, 78, vb));
  
  ISimValue fab = simulation.makeValueInRange("flow_A_B", 0,0,.5);
  simulation.add(new Valve(va, vb, fab));
  simulation.add(new OnOff(160,80,fab));
  
  ISimValue fba = simulation.makeValueInRange("flow_B_A", 0,0,.5);
  simulation.add(new Valve(vb, va, fba));
  simulation.add(new OnOff(160,120,fba));
  
  ISimValue foa = simulation.makeValueInRange("flow_O_A", 0,0,.5);
  simulation.add(new Valve(ocean, va, foa));
  simulation.add(new OnOff(40,80,foa));
  
  ISimValue fao = simulation.makeValueInRange("flow_A_O", 0,0,.5);
  simulation.add(new Valve(va, ocean, fao));
  simulation.add(new OnOff(40,120,fao));

  simulation.add(new Display(150,40,va));
  simulation.add(new Display(150,20,simulation.date()));
  
  // ------------------------------
  // Logic gate
  final ISimValue in[] = new ISimValue[4];
  for(int i = 0; i < in.length; ++i) {
    in[i] = simulation.makeValueInRange("in_"+i, 0, 0, 1);
  }

  rectMode(CORNERS);
  rect(100,180,160,340);
  
  simulation.add(new OnOff(100, 200, in[0]));
  simulation.add(new OnOff(100, 260, in[1]));
  simulation.add(new Indicator(160, 200) {
   public boolean active() { return in[0].value()*in[1].value() != 0; } 
  });
  simulation.add(new OnOff(160, 260, in[2]));
  simulation.add(new OnOff(160, 320, in[3]));
  simulation.add(new Indicator(100, 320) {
   public boolean active() { return in[2].value()*in[3].value() != 0; } 
  });
  
  // ------------------------------
  // Periodic
  ISimValue flag = simulation.makeValueInRange("flag", 0,0,1);
  simulation.add(new OnOff(60,420,flag));
  
  for (int i = 0; i < 4; ++i) {
    final ISimValue src = flag;
    final ISimValue dst = simulation.makeValueInRange("flag"+i, 0,0,1);
    
    simulation.add(new Indicator(120+40*i, 420) {
     public boolean active() { return dst.full(); } 
    });

    simulation.in(0, new RepeatEvent(200, new Event() {
      public void doIt(Simulation theSimulation) {
        if (src.full())
          dst.toMax();
        else
          dst.toMin();
      }
    }));
    
    flag = dst;
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

