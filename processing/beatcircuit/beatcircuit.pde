//constant
final int scl = 20;
final color bk = color(30, 30, 30);
PFont font;

BackgroundClient back;
Circuit circuit;
Circuit cc;
int x_pressed, y_pressed;
int mX = 0, mY = 0;
float cX, cY;

//state
boolean newLine = false;
boolean newCircuit = false;

Metro metro;
int fc;

void setup() {
  // size(1200, 800, P2D);
  size(1920, 1050, P2D);
  background(bk);
  noCursor();

  //self define class
  back = new BackgroundClient();
  cc = new Circuit();

  metro = new Metro(true, 1000);
  fc = metro.frameCount();
  font = createFont("Courier", 12);
  textFont(font);
}

void draw() {
  background(bk);
  back.display();
  drawCursor();

  cc.mouseSensed(mX, mY);
  cc.display();

  if (circuit != null) {
    circuit.mouseSensed(mX, mY);
    circuit.display();
  }

  showfr();
  // debbug();
}

void mousePressed() {
  //test for background
  back.trigger(mouseX, mouseY);
  if (newLine || newCircuit) {
    x_pressed = mX;
    y_pressed = mY;
  }
  else {
    cc.mousePressed(mX, mY);
    //test
    if (circuit != null) circuit.mousePressed(mX, mY);
  }
}
void mouseReleased() {
  if (newLine) {
    // wires.add( new Wire(x_pressed, y_pressed,
    //                             mouseX, mouseY) );
    // wires.add( new SequenceWire(x_pressed, y_pressed,
    //                             mouseX, mouseY, false, false) );
    cc.addSequenceWire( x_pressed, y_pressed, mX, mY);
  }
  else if (newCircuit) {
    cc.addShortedWire( x_pressed, y_pressed, mX, mY);
    // circuit = new Circuit(x_pressed, y_pressed,
    // mouseX, mouseY);
  }
  else {
    cc.mouseReleased(mX, mY);
    if (circuit != null) circuit.mouseReleased(mX, mY);
  }
}
void mouseDragged() {
  if (!newLine && !newCircuit) {
    cc.mouseDragged(mX, mY);
    if (circuit != null) circuit.mouseDragged(mX, mY);
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
void drawCursor() {
  mX = round(mouseX / scl);
  mY = round(mouseY / scl);

  cX = float(mX * scl) + 0.5 * (cX - float(mX * scl));
  cY = float(mY * scl) + 0.5 * (cY - float(mY * scl));

  noFill();
  stroke(255);

  ellipse(cX, cY, 10, 10);
}
void showfr() {
  fill(255);
  text( "frameRate: " + str(frameRate),10, 20);
}


// Wire prev;
// void debbug() {
//   if(random(1) < 0.001) {
//     back.trigger(mouseX, mouseY);
//   }
//
//   if (fc < metro.frameCount()) {
//     fc = metro.frameCount();
//     // cc.addWire( random(width), random(height),
//     //             random(width), random(height));
//     prev = cc.addSequenceWire( prev.x_e, prev.y_e,
//                        prev.x_e + random(-200, 200), prev.y_e + random(-200, 200));
//   println("-------------------");
//   println("number of wires: " + cc.wires.size());
//   println("frame rate: " + frameRate);
//   }
// }
