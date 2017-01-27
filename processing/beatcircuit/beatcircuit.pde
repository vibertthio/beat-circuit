color bk = color(30, 30, 30);

//self define class
eBackgroundClient back;
SequenceWire w;
float x_pressed, y_pressed;

//state
boolean newLine = false;


void setup() {

  background(bk);
  size(1200, 800);

  //self define class
  back = new eBackgroundClient();

  //test
  w = new SequenceWire(random(width), random(height), random(width), random(height), true);
}

void draw() {
  background(bk);
  back.display();

  w.update();
  w.display();

  //background
  if(random(1) < 0.001) {
    // back.trigger(mouseX, mouseY);
  }
  showfr();
}


void mousePressed() {
  //test for background
  //back.trigger(mouseX, mouseY);
  if (!newLine) {
    w.mousePressed(mouseX, mouseY);
  }
  x_pressed = mouseX;
  y_pressed = mouseY;
}

void mouseReleased() {
  if (newLine) {
    w = new SequenceWire(x_pressed, y_pressed, mouseX, mouseY, false);
  }
}

void keyPressed() {
  if(key == 'n') {
    newLine = true;
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
