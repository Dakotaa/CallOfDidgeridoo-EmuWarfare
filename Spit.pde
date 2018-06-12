class Spit extends Projectile {
  Spit(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
    myPosition = position;
    myVelocity = new PVector(20, 20);
    myTheta = theta;
    this.velocity = velocity;
    myXEnd = xEnd;
    myYEnd = yEnd;
    if (xEnd >= myPosition.x) {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))));
      if (yEnd < myPosition.y) {
        myVelocity.y*=-1;
      }
    } else {
      myVelocity.y = ((float) ((velocity) * (Math.sin(Math.abs((myTheta))))));
      myVelocity.x = ((float) Math.sqrt((((velocity)*(velocity))-((myVelocity.y)*(myVelocity.y)))))*-1;
    }
  }
  
  void update() {
    super.update();
    rect(myPosition.x, myPosition.y, 30, 30);
  }
}