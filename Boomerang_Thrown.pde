// For full documentation, see parent (Projectile) class.
class Boomerang_Thrown extends Projectile {
  // booleans for the states of the boomerang
  boolean returning, returned;
  Boomerang_Thrown(PVector position, float velocity, float theta, float xEnd, float yEnd) {
    super(position, velocity, theta, xEnd, yEnd);
  }

  void setReturning (boolean r) {
    returning = r;
  }

  // if the boomerang successfully returns, add a boomerang back to the inventory.
  void returned() {
    inventory.put("Boomerang", inventory.get("Boomerang") + 1);  
    toRemove = true;
  }

  void update() {
    // checks for boomerang hitting emus.
    for (Emu e : emus) {
      if (myPosition.x > e.getX() - e.getWidth()/2 && myPosition.x < e.getX() + e.getWidth()/2 && myPosition.y > e.getY() - e.getHeight()/2 && myPosition.y < e.getY() + e.getHeight()/2) {
        returning = true;
        e.reduceHP(100);
      }
    }

    // if the boomerang is not returning (still moving on its original velocity), checks if it has reached its end position yet.
    if (!returning) {
      if (myPosition.x > myXEnd - 30 && myPosition.x < myXEnd + 30 && myPosition.y > myYEnd - 30 && myPosition.y < myYEnd + 30) {
        returning = true;
      }
    }

    // mirrors the inital velocity of the boomerang to make it return to where it was thrown from
    if (returning) {
      myPosition.x += -myVelocity.x;
      myPosition.y += -myVelocity.y;
      
      // checks if the boomerang has reached the truck
      if (myPosition.x > truck.gunX() - 100 && myPosition.x < truck.gunX() + 100 && myPosition.y > truck.gunY() - 100 && myPosition.y < truck.gunY() + 100) {
        returned();
      }
    } else {
      myPosition.x += myVelocity.x;
      myPosition.y += myVelocity.y;
    }

    if (visible) {
      pushMatrix();
      imageMode(CENTER);
      translate(myPosition.x, myPosition.y);
      rotate(frameCount/3);
      image(boomerang, 0, 0);
      popMatrix();
    }
  }
}
