class HUD {
  boolean HP, ammo, items;
  PImage boomerangIcon;
  HUD (boolean hp, boolean a, boolean i) {
    HP = hp;
    ammo = a;
    items = i;
    //boomerangIcon = boomerang.copy(); 
    //boomerangIcon.resize(75, 75);
  }
  void showFPS() {
    text("FPS: " + (int) frameRate, 10, 20);
  }
  void showHP() {
    text("Truck Condition: " + (int) (truck.getHP()*100) + "%", 100, 20);
  }

  void showAmmo() {
    for (Gun g : guns) {
      if (g.getReloading()) {
        text("Reloading", 400, 20);
      } else {
        text("Ammo: " + (int) g.getAmmo() + " | " + (int) g.getMaxAmmo(), 400, 20);
      }
    }
  }

  void showItems() {
    for (int i = 0; i < 5; i++) {
      stroke(10);
      fill(220);
      rectMode(CORNER);
      rect(75*i, height-75, 75, 75);
    }
    textAlign(CENTER);
    fill(0);
    if (inventory.get("Boomerang") > 0) {
      image(boomerang, 30, height-30);
      text(inventory.get("Boomerang"), 10, height-50);
    }
  }

  void update() {
    fill(0);
    textSize(20);
    textAlign(LEFT);
    showFPS();
    showHP();
    showAmmo();
    showItems();
  }
}
