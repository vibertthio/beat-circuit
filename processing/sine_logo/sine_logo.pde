Wave sine;
float rec;
void setup() {
  size(500, 500);
  background(255);

  sine = new Wave();
  rec = sine.phase;
}



void draw() {
  background(255);
  sine.show();
  sine.update();

  if ((sine.phase < rec + 4 * PI) && frameCount%5 == 0) {
    screenshot();
  }
}

void keyPressed() {
  saveFrame("data/temp/logo-######.png");
}

void screenshot() {
  TImage frame = new TImage(width,height,RGB,sketchPath("data/temp/frame_"+nf(frameCount,5)+".png"));
  frame.set(0,0,get());
  frame.saveThreaded();
}
