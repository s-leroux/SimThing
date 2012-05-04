class CSVWriter extends Actor {
  CSVWriter(String fName, IObservable ... values) throws IOException {
    this.values = values;
    this.writer = new FileWriter(fName);
  }
  
  void nextStep(Simulation theSimulation) {
    // nothing by default
  }
  
  void writeHeader() throws IOException {
    int n = 0;
    for(IObservable v : values) {
      if (n++ > 0) {
        writer.write(",");
      }
      writer.write(v.name());
    }
    writer.write("\n");
  }
  
  void writeData() throws IOException {
    int n = 0;
    for(IObservable v : values) {
      if (n++>0) {
        writer.write(",");
      }
      writer.write(String.format("%f", v.value()));
    }
    writer.write("\n");
    writer.flush();
  }

  long               interval;
  FileWriter         writer;
  IObservable[]      values;
}
