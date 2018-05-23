class GroundItem {
  String myType;
  int myLifeSpan;
  int alpha = 100;
  float myX, myY;
  boolean pickedUp, alphaIncreasing;
  PImage icon;
  GroundItem (String type, int life, float x, float y) {
    myType = type;
    myLifeSpan = life;
    myX = x;
    myY = y;

    switch (myType) {
    case "Boomerang":
      icon = boomerang.copy();
      break;
    case "Vegemite":
      icon = vegemite.copy();
      break;
    case "Grenade": 
      icon = grenade.copy();
      break;
    case "Landmine":
      icon = landmine.copy();
      break;
    case "Gas": 
      icon = grenade.copy();
      break;
    default:
      icon = boomerang.copy();
      break;
    }
  }

  void pickup () {
    if (truck.getX() < myX + 150 && truck.getX() > myX - 150 && truck.getY() < myY + 150 && truck.getY() > myY - 150) {
      inventory.put(myType, inventory.get(myType) + 1);
      pickedUp = true;
    }
  }

  boolean toRemove() {
    return pickedUp;
  }

  void update() {
    if (alphaIncreasing) {
      alpha+=3;
    } else {
      alpha-=3;
    }

    if (alpha < 100 || alpha > 200) {
      alphaIncreasing = !alphaIncreasing;
    }

    tint(alpha);
    image(icon, myX, myY);
    noTint();
    pickup();
  }
}