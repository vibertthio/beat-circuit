color bk = color(30, 30, 30);
eBackgroundClient back;

void setup() {
  background(bk);
  size(1200, 800);

  back = new eBackgroundClient();
}

void draw() {
  background(bk);
  back.display();
}













void mousePressed() {

  //back.trigger(mouseX, mouseY);
}
