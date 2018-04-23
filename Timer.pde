class Timer {
  float seconds;
  boolean ended = false;
  
  Timer(float s) {
    seconds = s;
  }

  void setSeconds(float s) {
    seconds = s;
    ended = false;
  }
  
  boolean isDone() {
    return ended;
  }

  void update() {
    if (seconds > 0) {
      if (frameCount%60 == 0) {
        seconds--;
      }
    } else {
      ended = true;
    }
  }
}
