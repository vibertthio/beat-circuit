class eBackgroundDot {
  boolean pos = false;
  float x = 0;
  float y = 0;

  //size
  float sz;
  float szOffset = 1;
  float szLimit = 3;
  float szPeak = szLimit;



  //alpha
  float alpha;
  float alphaOffset = 200;
  float alphaLimit = 255;
  float alphaPeak = alphaLimit;


  TimeLine timer;

  color colorOfDots = color (255, 255, 255);

  eBackgroundDot(float _x, float _y) {
    timer = new TimeLine(500);
    timer.setLinerRate(1);
    timer.set1();
    x = _x;
    y = _y;
  }

  void display() {
    noStroke();
    //adjust alpha
    // fill(colorOfDots, dotAlpha());
    fill(255);
    //adjust size
    ellipse(x, y, dotSize(), dotSize());
    //ellipse(x, y, szOffset, szOffset);
  }

  float dotSize() {
    if (pos) {
      sz = map(timer.liner(), 0, 1, szOffset, szLimit); }
    else {
      sz = map(timer.liner(), 0, 1, szPeak, szOffset); }
    return sz;
  }

  float dotAlpha() {
    if (pos) {
      alpha = map(timer.liner(), 0, 1, alphaOffset, alphaLimit); }
    else {
      alpha = map(timer.liner(), 0, 1, alphaPeak, alphaOffset); }
    return alpha;
  }

  void update(float _x, float _y, float maxsize, float minsize) {
    float d = dist(x, y, _x, _y);
    boolean _pos;
    if ( d > minsize && d < maxsize ) { _pos = true; }
    else { _pos = false; }

    if ( pos !=  _pos ) {
      timer.startTimer();
      if (pos) {
        alphaPeak = alpha;
        szPeak = sz;
      }
    }
    pos = _pos;
  }

}

class BackgroundClient {
  eBackgroundDot[][] eBackgroundDots;
  int xNo = 34;
  int yNo = 20;
  float xCenter = 0;
  float yCenter = 0;
  float maxsize = width * 1.3;
  float minsize = width * 1.5;

  TimeLine maxTimer;
  TimeLine minTimer;
  boolean maxTrig = false;
  boolean minTrig = false;
  int startTime = 0;
  int timeOffset = 0;//600;
  int timeGap = 1500;

  BackgroundClient() {
    eBackgroundDots = new eBackgroundDot[xNo][yNo];
    maxTimer = new TimeLine(5000);
    minTimer = new TimeLine(4000);
    maxTimer.setLinerRate(1);
    minTimer.setLinerRate(1);

    for(int i = 0; i < xNo; i++) {
      for (int j = 0; j < yNo; j++) {
        float x = map(i, 0, xNo-1, 0, width);
        float y = map(j, 0, yNo-1, 0, height);
        eBackgroundDots[i][j] = new eBackgroundDot(x, y);
      }
    }
  }

  void display() {
    if ((millis() - startTime) > timeOffset && !maxTrig) {
      maxTimer.startTimer();
      // println("maxTimer trigger!");
      maxTrig = true;
    }
    if (maxTimer.state && (millis() - startTime) > (timeGap + timeOffset) && !minTrig ) {
      // println("minTimer trigger!");
      // println("time:" + millis());
      minTrig = true;
      minTimer.startTimer();
    }

    for(int i = 0; i < xNo; i++) {
      for (int j = 0; j < yNo; j++) {
        eBackgroundDots[i][j].update(xCenter, yCenter, maxSize(), minSize());
        eBackgroundDots[i][j].display();
      }
    }
    // strokeWeight(1);
    // noFill();
    // stroke(255, 0, 0);
    // ellipse(xCenter, yCenter, maxSize()*2, maxSize()*2);
    // stroke(0, 0, 255);
    // ellipse(xCenter, yCenter, minSize()*2, minSize()*2);

    // println("maxSize:" + maxSize());
    // println("minSize:" + minSize());

  }

  float maxSize() {
    return maxsize * maxTimer.liner();
  }
  float minSize() {
    return minsize * minTimer.liner();
  }

  void trigger(float x, float y) {
    println("background trigger!");
    xCenter = x;
    yCenter = y;

    // print("background dots:  ");
    // print("x : " + str(x));
    // print("  y : " + str(y) );
    // print("  time: " + millis() + "\n");

    //maxTimer.startTimer();
    minTrig = false;
    maxTrig = false;
    startTime = millis();
    // println("start time:" + millis());
  }

}
