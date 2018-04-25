class HUD {
  boolean HP, ammo, items;
  PImage boomerangIcon;
  int selectedItem = 0;
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
