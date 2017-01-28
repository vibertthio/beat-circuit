//constant
final color bk = color(30, 30, 30);
PFont font;

BackgroundClient back;
ArrayList<Wire> wires;
Circuit circuit;
float x_pressed, y_pressed;

//state
boolean newLine = false;

Metro metro;
int fc;

void setup() {
  size(1200, 800, P2D);
  background(bk);


  //self define class
  back = new BackgroundClient();

  wires = new ArrayList<Wire>();
  wires.add( new SequenceWire(random(width), random(height),
                              random(width), random(height), true) );

  metro = new Metro(true, 300);
  fc = metro.frameCount();
  font = createFont("Courier", 12);
  textFont(font);

}

void draw() {
  background(bk);
  back.display();

  for (int i=0; i<wires.size(); i++) {
    Wire w = wires.get(i);
    w.update();
    w.display();
  }

  if (circuit != null) {
    circuit.display();
  }

  showfr();
  // debbug();
}

void mousePressed() {
  //test for background
  //back.trigger(mouseX, mouseY);

  if (!newLine) {
    for (int i=0; i<wires.size(); i++) {
      Wire w = wires.get(i);
      w.mousePressed(mouseX, mouseY);
    }
  }

  x_pressed = mouseX;
  y_pressed = mouseY;
}
void mouseReleased() {
  if (newLine) {
    // wires.add( new SequenceWire(x_pressed, y_pressed,
    //                             mouseX, mouseY, true) );
    // wires.add( new Wire(x_pressed, y_pressed,
    //                             mouseX, mouseY) );
    circuit = new Circuit(x_pressed, y_pressed,
                          mouseX, mouseY);
  }
}
void keyPressed() {
  if(key == 'n') {
    newLine = true;
  }
  if( key == ' ') {
    wires.clear();
  }
}
void keyReleased() {
  if(key == 'n') {
    newLine = false;
  }
}

//utility
void showfr() {
  fill(255);
  text( "frameRate: " + str(frameRate),10, 20);
}
void debbug() {
  if(random(1) < 0.001) {
    back.trigger(mouseX, mouseY);
  }

  if (fc < metro.frameCount()) {
    fc = metro.frameCount();
    wires.add( new SequenceWire(random(width), random(height),
                                random(width), random(height), true) );
  println("-------------------");
  println("number of wires: " + wires.size());
  println("frame rate: " + frameRate);
  }
}
