TimeLine timer;
final color col = color(224, 130, 131);
PFont font;

void setup() {
  size(1500, 300);
  background(30);
  font = createFont("Courier", 18);
  textFont(font);
  timer = new TimeLine(2000);

}

float dia = 80;
float iX = 300;
float distance = 600;
int dir = 1;
int n = 10;

void draw() {
  background(30);
  text("timer's limit: " + timer.limit, 20, 30);
  text("timer's liner: " + timer.liner(), 20, 60);
  text("timer's state: " + timer.state, 20, 90);
  stroke(255);
  for(int i = 0; i <= n; i++) {
    line(iX + distance * float(i)/n, 0,
         iX + distance * float(i)/n, height);
  }
  // float r = timer.liner();
  // float r = timer.getPowIn(2.5);
  // float r = timer.getPowOut(3);
  // float r = timer.getPowInOut(3);
  // float r = timer.sineIn();
  // float r = timer.sineOut();
  // float r = timer.sineInOut();
  // float r = timer.getBackIn(1.2);
  // float r = timer.getBackOut(1.2);
  // float r = timer.getBackInOut(1.2);
  // float r = timer.circIn();
  // float r = timer.circOut();
  // float r = timer.circInOut();
  // float r = timer.bounceIn();
  // float r = timer.bounceOut();
  // float r = timer.bounceInOut();
  // float r = timer.elasticIn();
  // float r = timer.elasticOut();
  float r = timer.elasticInOut();

  float x = iX + r * distance;
  noStroke();
  fill(col);
  ellipse(x, height/2, dia, dia);

}

void keyPressed() {
  if (key == ' ') {
    timer.startTimer();
    dir *= 1;
  }
}
