class Boomerang_Thrown extends Projectile {
  boolean returning, returned;
  Boomerang_Thrown(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void setReturning(boolean r) {
    returning = r;
  }

  void returned() {
    inventory.put("Boomerang", inventory.get("Boomerang") + 1);  
    toRemove = true;
  }

  void update() {
    for (Emu e : emus) {
      if (myPosition.x > e.getX() - e.getWidth()/2 && myPosition.x < e.getX() + e.getWidth()/2 && myPosition.y > e.getY() - e.getHeight()/2 && myPosition.y < e.getY() + e.getHeight()/2) {
        returning = true;
        e.reduceHP(15);
      }
    }
    text(myXEnd, 1000, 1000);
    text(myYEnd, 1200, 1000);
    
    text(myPosition.x, 1000, 1050);
    text(myPosition.y, 1200, 1050);
    if (!returning) {
      if (myPosition.x > myXEnd - 20 && myPosition.x < myXEnd + 20 && myPosition.y > myYEnd - 20 && myPosition.y < myYEnd + 20) {
        returning = true;
        println(".");
      }
    }

    if (returning) {
      myPosition.x += -myVelocity.x;
      myPosition.y += -myVelocity.y;
      if (myPosition.x > truck.gunX() - 100 && myPosition.x < truck.gunX() + 100 && myPosition.y > truck.gunY() - 100 && myPosition.y < truck.gunY() + 100) {
        returned();
      }
    } else {
      myPosition.x += myVelocity.x;
      myPosition.y += myVelocity.y;
    }

    if (visible) {
      pushMatrix();
      translate(myPosition.x, myPosition.y);
      rotate(frameCount/3);
      image(boomerang, 0, 0);
      popMatrix();
      text(myPosition.x, 200, 100);
      text(myXEnd, 200, 200);
    }
  }
}
