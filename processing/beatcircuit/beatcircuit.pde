//constant
final int scl = 20;
final color bk = color(30, 30, 30);
PFont font;

BackgroundClient back;
Circuit cc;
int x_pressed, y_pressed;
int mX = 0, mY = 0;
float cX, cY;

//state
boolean newLine = false;
boolean removeLine = false;
boolean newCircuit = false;


Metro metro;
int fc;
float zoom = 1;

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
  scale(zoom);
  background(bk);
  back.display();
  drawCursor();

  cc.mouseSensed(mX, mY);
  cc.display();


  showfr();
  // debbug();
}

void mousePressed() {
  //test for background
  back.trigger(mX * scl, mY * scl);
  if (newLine || newCircuit) {
    x_pressed = mX;
    y_pressed = mY;
  }
  else if (removeLine) {
    cc.removeWire(mX, mY);
  }
  else {
    cc.mousePressed(mX, mY);
  }
}
void mouseReleased() {
  if (newLine) {
    cc.addWire(1, x_pressed, y_pressed, mX, mY);
  }
  else if (newCircuit) {
    cc.addWire(2, x_pressed, y_pressed, mX, mY);
  }
  else {
    cc.mouseReleased(mX, mY);
  }
}
void mouseDragged() {
  if (!newLine && !newCircuit) {
    cc.mouseDragged(mX, mY);
  }
}
void keyPressed() {
  if(key == 'n') {
    newLine = true;
  }
  if(key == 'm') {
    newCircuit = true;
  }
  if(key == 'r') {
    removeLine = true;
  }

  if( key == ' ') {
    cc.clearWires();
  }

  if (key == 'a') {
     zoom += 0.05;
   }
   else if (key == 'z') {
     zoom -= 0.05;
 }
 zoom = constrain(zoom,0,100);
}
void keyReleased() {
  if(key == 'n') {
    newLine = false;
  }
  if(key == 'm') {
    newCircuit = false;
  }
  if(key == 'r') {
    removeLine = false;
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
  text( "zoom rate: " + str(zoom),10, 30);
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
