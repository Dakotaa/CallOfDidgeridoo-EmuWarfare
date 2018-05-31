class Rain {
  float myX, myY;
  Rain () {
    myX = random(0, width);
    myY = random (-height, 0);
  }

  void update() {
    myY += 10;
    myX += 1;
    fill(40, 40, 255);
    rect(myX, myY, 3, 6);
    if (myY > height) {
      myY = -10; 
      myX = random(0, width);
    }
  }
}