class Timer {
  float seconds;
  boolean ended = false;
  
  Timer(float s) {
    seconds = s;
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
