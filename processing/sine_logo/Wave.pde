class Wave {
  float radian = 0.15;
  float amp = 30;
  float _amp = amp;
  // int def = 245;
  int def = 102;
  float scl = 1;
  float offset = -( float(def) * scl / 2);
  float phase = 0.3;

  float diameter = 300;


  Wave() {}

  void display() {
    pushMatrix();

    translate(width/2, height/2);

    noFill();
    stroke(0);
    strokeWeight(5);

    //frame
    ellipse(0, 0, diameter, diameter);

    //wave
    for (int i = 0; i < def - 1; i++) {
      float x1 = offset + float(i)*scl ;
      float y1 = _amp * sin(phase + radian * i);
      float x2 = offset + float((i+1))*scl ;
      float y2 = _amp * sin(phase + radian * (i+1));

      line(x1, y1, x2, y2);
    }

    popMatrix();

  }

  void update() {
    // phase += 0.05;
    float v = pow(sin(phase), 2)/10 + 0.05;
    phase += v;
    _amp = amp + sin(phase + 0.5) * 5;

  }

}
