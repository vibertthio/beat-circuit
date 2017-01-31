//constant
final int scl = 20;
final color bk = color(30, 30, 30);
PFont font;

BackgroundClient back;
Circuit circuit;
Circuit cc;
float x_pressed, y_pressed;

//state
boolean newLine = false;
boolean newCircuit = false;

Metro metro;
int fc;

void setup() {
  // size(1200, 800, P2D);
  size(1920, 1050, P2D);
  background(bk);


  //self define class
  back = new BackgroundClient();
  cc = new Circuit();

  metro = new Metro(true, 1000);
  fc = metro.frameCount();
  font = createFont("Courier", 12);
  textFont(font);

  //debbug
  float x, y;
  prev = cc.addSequenceWire( x = random(width), y = random(height),
                     x + random(-200, 200), y + random(-200, 200));
}

void draw() {
  background(bk);
  back.display();

  cc.mouseSensed(mouseX, mouseY);
  cc.display();

  if (circuit != null) {
    circuit.mouseSensed(mouseX, mouseY);
    circuit.display();
  }

  showfr();
  // debbug();
}

void mousePressed() {
  //test for background
  back.trigger(mouseX, mouseY);
  if (newLine || newCircuit) {
    x_pressed = mouseX;
    y_pressed = mouseY;
  }
  else {
    cc.mousePressed(mouseX, mouseY);
    //test
    if (circuit != null) circuit.mousePressed(mouseX, mouseY);
  }
}
void mouseReleased() {
  if (newLine) {
    // wires.add( new Wire(x_pressed, y_pressed,
    //                             mouseX, mouseY) );
    // wires.add( new SequenceWire(x_pressed, y_pressed,
    //                             mouseX, mouseY, false, false) );
    cc.addSequenceWire( x_pressed, y_pressed, mouseX, mouseY);
  }
  else if (newCircuit) {
    cc.addShortedWire( x_pressed, y_pressed, mouseX, mouseY);
    // circuit = new Circuit(x_pressed, y_pressed,
    // mouseX, mouseY);
  }
  else {
    cc.mouseReleased(mouseX, mouseY);
    if (circuit != null) circuit.mouseReleased(mouseX, mouseY);
  }
}
void mouseDragged() {
  if (!newLine && !newCircuit) {
    cc.mouseDragged(mouseX, mouseY);
    if (circuit != null) circuit.mouseDragged(mouseX, mouseY);
  }
}
void keyPressed() {
  if(key == 'n') {
    newLine = true;
  }
  if(key == 'm') {
    newCircuit = true;
  }

  if( key == ' ') {
    cc.clearWires();
    circuit = null;
  }
}
void keyReleased() {
  if(key == 'n') {
    newLine = false;
  }
  if(key == 'm') {
    newCircuit = false;
  }
}

//utility
void showfr() {
  fill(255);
  text( "frameRate: " + str(frameRate),10, 20);
}

Wire prev;
void debbug() {
  if(random(1) < 0.001) {
    back.trigger(mouseX, mouseY);
  }

  if (fc < metro.frameCount()) {
    fc = metro.frameCount();
    // cc.addWire( random(width), random(height),
    //             random(width), random(height));
    prev = cc.addSequenceWire( prev.x_e, prev.y_e,
                       prev.x_e + random(-200, 200), prev.y_e + random(-200, 200));
  println("-------------------");
  println("number of wires: " + cc.wires.size());
  println("frame rate: " + frameRate);
  }
}
