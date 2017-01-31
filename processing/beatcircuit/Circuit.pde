class Circuit {
  ArrayList<Wire> wires;
  int x1, y1, x2, y2;

  void init() {
    wires = new ArrayList<Wire>();
  }

  Circuit() {
    init();
  }
  Circuit(int _x1, int _y1, int _x2, int _y2) {
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

  void addSequenceWire(int _xs, int _ys, int _xe, int _ye) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      if (w.xe == _xs && w.ye == _ys) {
        // println("!!!!");
        Wire w_new = new SequenceWire(_xs, _ys, _xe, _ye, false, false);
        w.addNext(w_new);
        w_new.addPrev(w);
        wires.add(w_new);
        return ;
      }
    }

    Wire w_new = new SequenceWire(_xs, _ys, _xe, _ye, false, false);
    wires.add(w_new);
    // return w_new;

    // wires.add(new Wire(x_s, y_s, x_e, y_e));
  }
  void addShortedWire(int _xs, int _ys, int _xe, int _ye) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      if (w.xe == _xs && w.ye == _ys) {
        // println("!!!!");
        Wire w_new = new ShortedWire(_xs, _ys, _xe, _ye);
        w.addNext(w_new);
        w_new.addPrev(w);
        wires.add(w_new);
        return ;
      }
    }

    Wire w_new = new ShortedWire(_xs, _ys, _xe, _ye);
    wires.add(w_new);
    // return w_new;

    // wires.add(new Wire(x_s, y_s, x_e, y_e));
  }

  void removeWire(int mX, int mY) {
    for (int i=0, n=wires.size(); i<n; i++) {
      Wire w = wires.get(i);
      if (w.xs == mX && w.ys == mY) {
        wires.remove(i);
        return;
      }
    }
  }
  void clearWires() {
    wires.clear();
  }
}
