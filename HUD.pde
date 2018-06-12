class HUD {
  boolean HP, ammo, items, emusKilled;
  PImage boomerangIcon;
  int selectedItem = 0;
  HUD (boolean hp, boolean a, boolean i, boolean e) {
    HP = hp;
    ammo = a;
    items = i;
    emusKilled = e;
  }
  void showFPS() {
    text("FPS: " + (int) frameRate, 10, 30);
  }
  void showHP() {
    text("Truck Condition: " + (int) (truck.getHP()*100) + "%", 150, 30);
  }

  void showAmmo() {
    for (Gun g : guns) {
      if (g.getReloading()) {
        text("Reloading", 500, 30);
      } else {
        text("Ammo: " + (int) g.getAmmo() + " | " + (int) g.getMaxAmmo(), 500, 30);
      }
    }
  }

  void showEmusKilled() {
    for (Level l : levels) {
      text("Emus Killed: " + l.getEmusKilled(), 1100, 30);
    }
  }

  void setSelectedItem(int x) {
    selectedItem = x;
  }

  int getSelectedItem() {
    return selectedItem;
  }
  void showItems() {
    for (int i = 0; i < 5; i++) {
      stroke(10);
      fill(220);
      rectMode(CORNER);
      rect(75*i, height-75, 75, 75);
    }
    fill(100, 100);
    rect(selectedItem*75, height-75, 75, 75);
    textAlign(CENTER);

    if (!boomerangTimer.isDone()) {
      fill(0, 100);
      rect(0, height-75, 75, 75);
    }

    fill(0);
    if (inventory.get("Boomerang") > 0) {
      image(boomerang, 30, height-30);
      text(inventory.get("Boomerang"), 10, height-50);
    }
    if (inventory.get("Vegemite") > 0) {
      image(vegemite, 115, height-30);
      text(inventory.get("Vegemite"), 85, height-50);
    }

    if (inventory.get("Grenade") > 0) {
      image(grenade, 190, height-30);
      text(inventory.get("Grenade"), 160, height-50);
    }

    if (inventory.get("Landmine") > 0) {
      image(landmine, 265, height-30);
      text(inventory.get("Landmine"), 235, height-50);
    }

    if (inventory.get("Gas") > 0) {
      image(grenade, 340, height-30);
      text(inventory.get("Gas"), 310, height-50);
    }
  }

  void showEmusAlive() {
    text("Emus Alive: " + emusAlive(), 900, 30);
  }

  void update() {
    textFont(stamp30);
    fill(0);
    textAlign(LEFT);
    showFPS();
    showHP();
    showAmmo();
    showEmusAlive();
    showEmusKilled();

    showItems();
  }
}