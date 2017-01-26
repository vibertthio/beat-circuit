class TimeLine {
  boolean state;
  int localtime;
  int limit;
  int elapsedTime;
  int repeatTime = 1;
  boolean breathState = false;
  boolean loop = false;

  float linerRate = 1;

  TimeLine(int sec) {
    limit=sec;
    state=false;
  }

  TimeLine(int sec, boolean _loop) {
    limit = sec;
    loop = _loop;
    state = _loop;
  }

  float liner() {
    if (state == true) {
      elapsedTime = currentTime() - localtime;

      if (elapsedTime>int(limit)) {
        if( !loop ) {
          elapsedTime = int(limit);
          state=false;
        }
        else {
          startTimer();
        }
      }
    }


    float ret = pow( float(elapsedTime)/limit,linerRate );
    if( ret > 1)
      ret = 1;
    return ret;
  }

  float repeatBreathMovement() {
    if (state == true) {
      //println("check!!!!");
      elapsedTime = currentTime() - localtime;
      if (elapsedTime>int(limit)) {
        elapsedTime = int(limit);
        if(repeatTime < 2 && breathState) {
          state = false; }
        else {
          if(breathState == true) {
            repeatTime-- ;
          }
          breathState = !breathState;
          startTimer();
        }
      }
    }

    float t = float(elapsedTime)/limit;
    if(!breathState) {
      return pow(t, linerRate); }
    else {
      return pow((1-t), linerRate); }
  }

  float repeatBreathMovementEndless() {
    if (state == true) {
      //println("check!!!!");
      elapsedTime = currentTime() - localtime;
      if (elapsedTime>int(limit)) {
        elapsedTime = int(limit);
        if(repeatTime < 1 && breathState) {
          state = false; }
        else {
          breathState = !breathState;
          startTimer();
        }
      }
    }

    float t = float(elapsedTime)/limit;
    if(!breathState) {
      return pow(t, linerRate); }
    else {
      return pow((1-t), linerRate); }
  }

  void setLinerRate(float r) { linerRate = r; }

  void setRepeatTime(int t) { repeatTime = t; }

  boolean startTimer() {
    if (state == true) {
      localtime = currentTime();
      elapsedTime = 0;
      return false;
    }
    else {
      localtime = currentTime();
      state=true;
      elapsedTime = 0;
      return true;
    }
  }

  void turnOffTimer() {
    localtime = currentTime() - limit;
    state = false;
  }

  int currentTime() {
    return millis();
  }

  void setLoop() { loop = true; }
  void set1() { elapsedTime = limit; }
}



// class TimeLine {
//   boolean state;
//   int localtime;
//   int limit;
//   int elapsedTime;
//   int repeatTime = 1;
//   boolean breathState = false;
//   boolean loop = false;
//
//   float linerRate = 1;
//
//   TimeLine(int sec) {
//     limit=sec;
//     state=false;
//   }
//
//   TimeLine(int sec, boolean _loop) {
//     limit = sec;
//     loop = _loop;
//     state = _loop;
//   }
//
//   float liner() {
//     if (state == true) {
//       elapsedTime = millis() - localtime;
//
//       if (elapsedTime>int(limit)) {
//         if( !loop ) {
//           elapsedTime = int(limit);
//           state=false;
//         }
//         else {
//           startTimer();
//         }
//       }
//     }
//
//
//     float ret = pow( float(elapsedTime)/limit,linerRate );
//     if( ret > 1)
//       ret = 1;
//     return ret;
//   }
//
//   float repeatBreathMovement() {
//     if (state == true) {
//       //println("check!!!!");
//       elapsedTime = millis() - localtime;
//       if (elapsedTime>int(limit)) {
//         elapsedTime = int(limit);
//         if(repeatTime < 2 && breathState) {
//           state = false; }
//         else {
//           if(breathState == true) {
//             repeatTime-- ;
//           }
//           breathState = !breathState;
//           startTimer();
//         }
//       }
//     }
//
//     float t = float(elapsedTime)/limit;
//     if(!breathState) {
//       return pow(t, linerRate); }
//     else {
//       return pow((1-t), linerRate); }
//   }
//
//   float repeatBreathMovementEndless() {
//     if (state == true) {
//       //println("check!!!!");
//       elapsedTime = millis() - localtime;
//       if (elapsedTime>int(limit)) {
//         elapsedTime = int(limit);
//         if(repeatTime < 1 && breathState) {
//           state = false; }
//         else {
//           breathState = !breathState;
//           startTimer();
//         }
//       }
//     }
//
//     float t = float(elapsedTime)/limit;
//     if(!breathState) {
//       return pow(t, linerRate); }
//     else {
//       return pow((1-t), linerRate); }
//   }
//
//   void setLinerRate(float r) { linerRate = r; }
//
//   void setRepeatTime(int t) { repeatTime = t; }
//
//   boolean startTimer() {
//     if (state == true) {
//       localtime = currentTime();
//       elapsedTime = 0;
//       return false;
//     }
//     else {
//       localtime = currentTime();
//       state=true;
//       elapsedTime = 0;
//       return true;
//     }
//   }
//
//   void turnOffTimer() {
//     localtime = millis() - limit;
//     state = false;
//   }
//
//   int currentTime() {
//     return millis();
//   }
//
//   void setLoop() { loop = true; }
//   void set1() { elapsedTime = limit; }
// }
