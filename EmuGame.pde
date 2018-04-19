/*******************************************************************************
 
 CALL OF DIDGERIDOO: EMU WARFARE
 
 2018
 BY: Dakota, Angus
 
 ********************************************************************************/

PImage lewisGun, miniGun, emuPhoto, emuPhotoFlipped, blood, explosion;
boolean isDone, autoFire, aiming, gameOver = false;
float gunInnac;
int level = 0;
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Emu> emus = new ArrayList();
ArrayList<Blood> bloods = new ArrayList();
ArrayList<Level> levels = new ArrayList();
Level lose = new LoseScreen();
ArrayList<Timer> timers = new ArrayList();

// TODO: Optimize how buttons are added or move them into a function
Button buttonOne = new Button(200, 250, 100, 75, "Test Level", color(100, 200, 250));

// TODO: initialize truck in level setup?
Truck truck = new Truck (5);
//Gun gun1 = new Gun();
Gun gun1 = new Gun_Lewisgun();

void setup() {
  fullScreen();
  cursor(CROSS);
  levels.add(new TitleScreen()); // Adds the title screen level
  thread("loadImages"); // Runs the loadImages function in another thread, this allows the loading screen to show while the images are being loaded.
}

// Loads all the images in another core thread, sets isDone to true after images are loaded to stop drawing of loading screen.
void loadImages() { // https://forum.processing.org/two/discussion/1360/how-to-speedup-loadimage
  lewisGun = loadImage("lewisgun.png");
  miniGun = loadImage("minigun.png");
  emuPhoto = loadImage("emu.png");
  emuPhotoFlipped = loadImage("emuflipped.png");
  blood = loadImage("blood.png");
  explosion = loadImage("explosion.png");
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
      emus.add(new Emu(mouseX, mouseY, (int) random(40, 100), random(0.1, 0.3)));
      break;
    case 82:    // Reloads gun
      gun1.reload();
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
    if (level == 0) {
      if (buttonOne.getDown()) {    // Level One button
        buttonOne.setDown(false);    // If the mouse is over the button and clicked, sets the level to one, adds a new level one instance, and sets it up.
        level = 1;
        levels.add(new LevelOne());
        for (Level l : levels) {
          l.setupLevel();
        }
      }
    }
  }
  if (level != 0) {              // If not on the title screen, clicking will operate the gun.
    if (mouseButton == LEFT) {
      if (gun1.getAmmo() > 0 && !gun1.getReloading()) {
        if (aiming) {
          bullets.add(new Bullet(new PVector(truck.gunX(), truck.gunY()), 30, gun1.getTheta(), mouseX, mouseY, true));    // Creates a new bullet
          gun1.shoot();    // Runs the shoot function for the gun
        }
      }
    }
    if (mouseButton == RIGHT) {    // When right clicking, the gun "aiming" is true, draws the white line and makes the gun more accurate.
      aiming = true;
    }
  }
}

void mouseReleased() {    // Sets aiming to false when not on the title screen and the right mouse button is released.
  if (level != 0) {
    if (mouseButton == RIGHT) aiming = false;
  }
}
