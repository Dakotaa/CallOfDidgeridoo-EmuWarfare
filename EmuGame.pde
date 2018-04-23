/*******************************************************************************
 
 CALL OF DIDGERIDOO: EMU WARFARE
 
 2018
 BY: Dakota, Angus
 
 ********************************************************************************/

PImage lewisGun, miniGun, emuPhoto, emuPhotoFlipped, blood, explosion, boomerang;
PImage[] emuRun = new PImage[34];    // https://processing.org/discourse/beta/num_1192465513.html
PImage[] emuRunFlip = new PImage[34];
boolean isDone, autoFire, aiming, gameOver = false;
float gunInnac;
int level = 0;

ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Emu> emus = new ArrayList();
ArrayList<Blood> bloods = new ArrayList();
ArrayList<Gun> guns = new ArrayList();
ArrayList<Level> levels = new ArrayList();
ArrayList<Button> buttons = new ArrayList();
ArrayList<Timer> timers = new ArrayList();
ArrayList<Projectile> projectiles = new ArrayList();
HashMap<String, Integer> inventory = new HashMap<String, Integer>();    // https://codereview.stackexchange.com/questions/148821/inventory-of-objects-with-item-types-and-quantities
HUD hud = new HUD(true, true, true);
Level lose = new LoseScreen();
// TODO: Optimize how buttons are added or move them into a function

// TODO: initialize truck in level setup?
Truck truck = new Truck (5);
//Gun gun1 = new Gun();
//Gun gun1 = new Gun_Lewisgun();

void setup() {
  fullScreen();
  frameRate(60);
  //((PGraphicsOpenGL)g).textureSampling(3); // https://forum.processing.org/two/discussion/8075/why-are-text-and-graphics-so-ugly-and-blocky
  cursor(CROSS);
  levels.add(new TitleScreen()); // Adds the title screen level
  thread("loadImages"); // Runs the loadImages function in another thread, this allows the loading screen to show while the images are being loaded.
  buttons.add(new Button(200, 250, 100, 75, "Test Level", color(100, 200, 250), 2, new LevelOne()));
  buttons.add(new Button(350, 250, 100, 75, "Minigun Test", color(100, 200, 250), 2, new LevelTwo()));
  inventory.put("Boomerang", 5);
}

// Loads all the images in another core thread, sets isDone to true after images are loaded to stop drawing of loading screen.
void loadImages() { // https://forum.processing.org/two/discussion/1360/how-to-speedup-loadimage
  lewisGun = loadImage("lewisgun.png");
  miniGun = loadImage("minigun.png");
  emuPhoto = loadImage("emu.png");
  boomerang = loadImage("Boomerang.png");
  boomerang.resize((int) (boomerang.width*0.15), (int) (boomerang.height*0.15));
  emuPhotoFlipped = loadImage("emuflipped.png");
  blood = loadImage("blood.png");
  explosion = loadImage("explosion.png");
  for (int i = 1; i < emuRun.length; i++) {
    emuRun[i] = loadImage(dataPath("EmuRun/EmuRun" + i + ".png"));    // https://forum.processing.org/two/discussion/4160/is-it-possible-to-load-files-from-a-folder-inside-the-data-folder
  }

  for (int i = 1; i < emuRunFlip.length; i++) {
    emuRunFlip[i] = loadImage(dataPath("EmuRunFlip/EmuRunFlip" + i + ".png"));    // https://forum.processing.org/two/discussion/4160/is-it-possible-to-load-files-from-a-folder-inside-the-data-folder
  }

  lewisGun.resize((int) (lewisGun.width*0.5), (int) (lewisGun.height*0.5));
  blood.resize(200, 200);
  isDone = true;
}

void draw() {
  if (!isDone) {  // If loading is not done, show the "LOADING..." screen.
    background(0);
    pushMatrix();
    textAlign(CENTER);
    textSize(50);
    text("LOADING...", width/2, height/2);
    popMatrix();
  } else {  // If not loading, draw all the levels (only one level should be in the ArrayList at any time)
    if (!gameOver) {
      for (Level l : levels) {
        l.update();
        //text(truck.getSpeed(), 100, 100);
      }
    } else {
      lose.update();
    }
  }
}


// KeyPressed function to control truck
void keyPressed() {
  if (level != 0) {
    switch(keyCode) {
    case 49: 
      hud.setSelectedItem(0);
      break;
    case 50: 
      hud.setSelectedItem(1);
      break;
    case 51: 
      hud.setSelectedItem(2);
      break;
    case 52: 
      hud.setSelectedItem(3);
      break;
    case 53: 
      hud.setSelectedItem(4);
      break;
    case 65: 
      truck.setLeft(true);
      break;
    case 68:
      truck.setRight(true);
      break;
    case 87:
      truck.setUp(true);
      break;
    case 83:
      truck.setDown(true);
      break;
    case 69:
      throwBoomerang();
      break;
    }
  }
}

void throwBoomerang() {
  if (hud.getSelectedItem() == 0) {
    for (Gun g : guns) {
      if (inventory.get("Boomerang") > 0) {
        projectiles.add(new Boomerang_Thrown(new PVector(truck.gunX(), truck.gunY()), 15, g.getTheta(), mouseX, mouseY));
        inventory.put("Boomerang", inventory.get("Boomerang") - 1);
      }
    }
  }
}

// KeyReleased function to control truck, add new emu, leave level, etc.
void keyReleased() {
  if (level != 0) {  // Keys only work when not on the title screen
    switch(keyCode) {
    case 65:    // Moves truck left
      truck.setLeft(false);
      break;
    case 68:    // Moves truck right
      truck.setRight(false);
      break;
    case 87:    // Moves truck up
      truck.setUp(false); 
      break;
    case 81:
      emus.add(new Emu(mouseX, mouseY, random(0.05, 0.5)));
      break;
    case 82:    // Reloads gun
      for (Gun g : guns) {
        g.reload();
      }
      break;
    case 83:    // Moves truck down
      truck.setDown(false);
      break;
    case 192:    // Leave to title screen
      level = 0;
      for (Level l : levels) {    // Clears all levels
        l.clearLevel();
      }
      levels.clear();
      levels.add(new TitleScreen()); // Adds the title screen level
      gameOver = false;
      break;
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (level == 0) {    // If in the title screen, buttons can be clicked.
      for (Button b : buttons) {
        if (b.getDown()) {
          b.pressed();
        }
      }
    } else {
      for (Gun g : guns) {
        if (g.getAmmo() > 0 && !g.getReloading()) {
          if (aiming) {
            bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, g.getTheta(), mouseX, mouseY, true));    // Creates a new bullet
            g.shoot();    // Runs the shoot function for the gun
          }
        }
      }
    }
  }

  if (mouseButton == RIGHT) {    // When right clicking, the gun "aiming" is true, draws the white line and makes the gun more accurate.
    aiming = true;
  }
}


void mouseReleased() {    // Sets aiming to false when not on the title screen and the right mouse button is released.
  if (level != 0) {
    if (mouseButton == RIGHT) aiming = false;
  }
}
