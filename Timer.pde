class Timer {
  float seconds;
  int frameStart;
  int frameEnd;
  boolean ended = false;
  boolean started = false;

  Timer(float s) {
    seconds = s;
    frameStart = frameCount;
    frameEnd = frameStart + (int) (60*s);
  }

  void setStarted(boolean s) {
    started = s;
  }

  void setSeconds(float s) {
    seconds = s;
    frameStart = frameCount;
    frameEnd = frameStart + (int) (60*s);
    ended = false;
  }

  boolean isStarted() {
    return started;
  }

  boolean isDone() {
    return ended;
  }

  void update() {
    if (frameCount >= frameEnd) {
      ended = true;
    }
  }
}