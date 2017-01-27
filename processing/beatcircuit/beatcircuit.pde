color bk = color(30, 30, 30);

//self define class
eBackgroundClient back;
Wire w;
float x_pressed, y_pressed;

//state
boolean newLine = false;


void setup() {

  background(bk);
  size(1200, 800);

  //self define class
  back = new eBackgroundClient();

  //test
  w = new Wire(random(width), random(height), random(width), random(height), true);
}

void draw() {
  // println(System.nanoTime());
  background(bk);
  back.display();

  w.update();
  w.display();

  //background
  if(random(1) < 0.001) {
    // back.trigger(mouseX, mouseY);
  }

  //frameRate
  fill(255);
  text( "frameRate: " + str(frameRate),10, 20);
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
    w = new Wire(x_pressed, y_pressed, mouseX, mouseY, false);
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
