class TImage extends PImage implements Runnable {  //separate thread for saving images
  String filename;

  TImage(int w,int h,int format,String filename){
    this.filename = filename;
    init(w,h,format);
  }

  public void saveThreaded(){
    new Thread(this).start();
  }

  public void run(){
    this.save(filename);
  }

}

// usage
// float angle = 0.1;
//
// void setup() {
//   size(500, 500);
//   smooth();
//   noStroke();
//   background(0);
//
//   frameRate(12);
// }
//
// void draw() {
//
//   float size = map(sin(angle),-1,1,0,height);
//   rectMode(CENTER);
//   translate(width/2, height/2);
//   rotate(angle);
//   noStroke();
//   fill(255,255);
//   rect(0,0, size, size);
//   angle += 0.0523 ;
//
//   noStroke();
//   fill( 0, 15);
//   rect(0, 0, width, height);
//
//   if(frameCount <= 120){
//     TImage frame = new TImage(width,height,RGB,sketchPath("frame_"+nf(frameCount,3)+".png"));
//     frame.set(0,0,get());
//     frame.saveThreaded();
//   }
// }
