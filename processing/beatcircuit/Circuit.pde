class Circuit {
  ArrayList<Wire> wires;
  float x1, y1, x2, y2;

  void init() {
    wires = new ArrayList<Wire>();
  }

  Circuit() {
    init();
  }
  Circuit(float _x1, float _y1, float _x2, float _y2) {
    init();
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
    if (x1 < x2) {
      if (y1 < y2) {
        wires.add(new SequenceWire(x1, y1, x2, y1, false, true));
        wires.add(new SequenceWire(x2, y1, x2, y2, false, true));
        wires.add(new SequenceWire(x2, y2, x1, y2, false, true));
        wires.add(new SequenceWire(x1, y2, x1, y1, false, true));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x1, y2, false, true));
        wires.add(new SequenceWire(x1, y2, x2, y2, false, true));
        wires.add(new SequenceWire(x2, y2, x2, y1, false, true));
        wires.add(new SequenceWire(x2, y1, x1, y1, false, true));
      }
    }
    else {
      if (y1 < y2) {
        wires.add(new SequenceWire(x1, y1, x1, y2, false, true));
        wires.add(new SequenceWire(x1, y2, x2, y2, false, true));
        wires.add(new SequenceWire(x2, y2, x2, y1, false, true));
        wires.add(new SequenceWire(x2, y1, x1, y1, false, true));
      }
      else {
        wires.add(new SequenceWire(x1, y1, x2, y1, false, true));
        wires.add(new SequenceWire(x2, y1, x2, y2, false, true));
        wires.add(new SequenceWire(x2, y2, x1, y2, false, true));
        wires.add(new SequenceWire(x1, y2, x1, y1, false, true));
      }
    }

    wires.get(0).addNext(wires.get(1));
    wires.get(1).addNext(wires.get(2));
    wires.get(2).addNext(wires.get(3));
    wires.get(3).addNext(wires.get(0));

  }

  // void update() {}

  void display() {
    for (int i = 0, n = wires.size(); i < n; i++) {
      Wire w = wires.get(i);
      w.update();
      w.display();
    }
  }

  void mouseReleased(int mX, int mY) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mouseReleased(mX, mY);
    }
  }
  void mouseDragged(int mX, int mY) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mouseDragged(mX, mY);
    }
  }
  void mousePressed(int mX, int mY) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mousePressed(mX, mY);
    }
  }
  void mouseSensed(int mX, int mY) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mouseSensed(mX, mY);
    }
  }

  Wire addSequenceWire(float x_s, float y_s, float x_e, float y_e) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mouseSensed(int(x_s), int(y_s));
      if (w.mousePointEndSensed) {
        println("!!!!");
        Wire w_new = new SequenceWire(w.x_e, w.y_e, x_e, y_e, false, false);
        w.addNext(w_new);
        w_new.addPrev(w);
        wires.add(w_new);
        return w_new;
      }
    }

    Wire w_new = new SequenceWire(x_s, y_s, x_e, y_e, false, false);
    wires.add(w_new);
    return w_new;

    // wires.add(new Wire(x_s, y_s, x_e, y_e));

    // wires.add(
    //   connected?
    //   new SequenceWire(x_pressed, y_pressed, mouseX, mouseY, false, false):
    //   new SequenceWire(x_pressed, y_pressed, mouseX, mouseY, true)
    // );
  }
  Wire addShortedWire(float x_s, float y_s, float x_e, float y_e) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      w.mouseSensed(int(x_s), int(y_s));
      if (w.mousePointEndSensed) {
        println("!!!!");
        Wire w_new = new ShortedWire(w.x_e, w.y_e, x_e, y_e);
        w.addNext(w_new);
        w_new.addPrev(w);
        wires.add(w_new);
        return w_new;
      }
    }

    Wire w_new = new ShortedWire(x_s, y_s, x_e, y_e);
    wires.add(w_new);
    return w_new;

    // wires.add(new Wire(x_s, y_s, x_e, y_e));

    // wires.add(
    //   connected?
    //   new SequenceWire(x_pressed, y_pressed, mouseX, mouseY, false, false):
    //   new SequenceWire(x_pressed, y_pressed, mouseX, mouseY, true)
    // );
  }
  void clearWires() {
    wires.clear();
  }
}
