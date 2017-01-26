color bk = color(30, 30, 30);



//self define class
eBackgroundClient back;
Wire w;
float x_pressed, y_pressed;



void setup() {
  background(bk);
  size(1200, 800);

  //self define class
  back = new eBackgroundClient();

  //test
  w = new Wire(random(width), random(height),random(width), random(height));
}

void draw() {
  background(bk);
  back.display();
  w.display();
}


void mousePressed() {
  //test for background
  //back.trigger(mouseX, mouseY);

  x_pressed = mouseX;
  y_pressed = mouseY;
}

void mouseReleased() {
  w = new Wire(x_pressed, y_pressed, mouseX, mouseY);
}
