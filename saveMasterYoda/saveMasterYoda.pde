//fonts for texts

import processing.sound.*;

PFont myFont;

//state variable
int state = 0;

//score variables
int pScore = 0;

int pScoreX;
int pScoreY;

//winning score
int winScore = 3;

// dead animation pos vars
float deadX;
float deadY;

//declare sound vars
//SoundFile homeScreenMusic;
SoundFile backgroundMusic;
SoundFile blasterShot;
SoundFile homeScreenMusic;
SoundFile failScreenMusic;
SoundFile winScreenMusic;

//Images Declared
PImage homeBackground;
PImage mainBackground;
PImage failScreenImage;
PImage winScreen;

PImage[] deadImages = new PImage[3];
Animation deadAnimation;

PImage bulletImage;
PImage yodaImage;
PImage vaderImage;
PImage gunLeft;
PImage gunRight;

//declaring my vars
int enemySize = 150;
int yodaSize = enemySize;

Enemy e1;
Enemy e2;
Enemy e3;
Enemy e4;
Enemy e5;

Yoda yo1;
Yoda yo2;

Player p1;

ArrayList<Bullet> bulletList;
ArrayList<Enemy> enemyList;
ArrayList<Yoda> yodaList;

//making timer vars
int startTime;
int currentTime;
int interval = 2500;

int startTimeC;
int currentTimeC;
int intervalC = 1000;

int x;
int y;
int w;
int h;
color c;

boolean enemiesOnScreen = true;
boolean yodaOnScreen = true;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(75);
  imageMode(CENTER);
  
  myFont = createFont("MV Boli", 50);
  textFont(myFont);
  textAlign(CENTER, CENTER);

  //initialize ray of images
  for (int index = 0; index < deadImages.length; index++) {
    deadImages[index] = loadImage("dead" + index + ".png");
  }
  
    deadAnimation = new Animation(deadImages, 0.05, 5.0);


  //score keeping
  pScoreX = width - 100;
  pScoreY = height - 100;

  //images
  homeBackground = loadImage("homescreen.jpeg");
  homeBackground.resize(800, 600);

  mainBackground = loadImage("maingame.jpg");
  mainBackground.resize(800, 600);

  failScreenImage = loadImage("failscreen.jpg");
  failScreenImage.resize(800, 600);

  winScreen = loadImage("winscreen.jpg");
  winScreen.resize(800, 600);

  bulletImage = loadImage("bullet.png");
  bulletImage.resize(100, 100);

  yodaImage = loadImage("Yoda.png");
  yodaImage.resize(250, 250);

  vaderImage = loadImage("Vader.png");
  vaderImage.resize(225, 225);
  
  gunLeft = loadImage("gunleft.png");
  gunLeft.resize(325,325);
  
  gunRight = loadImage("gunright.png");
  gunRight.resize(325,325);

  //music
  //homeScreenMusic = new SoundFile(this, "swtheme.mp3");
  backgroundMusic = new SoundFile(this, "imperialmarch.wav");

  blasterShot = new SoundFile(this, "blastersound.wav");

  homeScreenMusic = new SoundFile(this, "swtheme.mp3");

  failScreenMusic = new SoundFile(this, "cantinaband.mp3");

  winScreenMusic = new SoundFile(this, "winmusic.mp3");

  //sound setup
  startTime = millis();
  startTimeC = millis();

  //enemy setup
  e1 = new Enemy(100, height/3, enemySize);
  e2 = new Enemy(200, height/3, enemySize);
  e3 = new Enemy(300, height/3, enemySize);
  e4 = new Enemy(400, height/3, enemySize);
  e5 = new Enemy(500, height/3, enemySize);


  enemyList = new ArrayList<Enemy>();
  enemyList.add(e1);
  enemyList.add(e2);
  enemyList.add(e3);
  enemyList.add(e4);
  enemyList.add(e5);


  //Yoda setup
  yo1 = new Yoda(600, height/3, yodaSize);
  yo2 = new Yoda(700, height/3, yodaSize);
  yodaList = new ArrayList<Yoda>();
  yodaList.add(yo1);
  yodaList.add(yo2);


  //Player setup
  p1 = new Player(width/2, height/2 + height/3);

  //Bullet setup
  bulletList = new ArrayList<Bullet>();
}

void draw() {
  background(42);

  switch(state) {
    //homescreen
  case 0:
    drawStartScreen();
    if (homeScreenMusic.isPlaying() == false && state == 0) {
      homeScreenMusic.play();
    }
    break;


  case 1:

    enemySize = 175;
    yodaSize = enemySize;
    drawMainScreen();
    drawScore(pScore, width - 75, height - 75, color(255));
    winScore = 10;

    currentTime = millis();
    currentTimeC = millis();

    //sound

    if (backgroundMusic.isPlaying() == false && state == 1) {
      backgroundMusic.play();
      homeScreenMusic.stop();
    }

    //timer action
    if (currentTime - startTime > interval) {
      println("timer triggered");

      //reset my timer
      startTime = millis();

      //change timer
      if (enemiesOnScreen && yodaOnScreen) {
        //println("done");

        //Remove enemies/yoda
        enemyList.clear();
        yodaList.clear();
        enemiesOnScreen = false;
        yodaOnScreen = false;
      } else {
        //println("goodbye");

        //respawn enemies/yoda at random location

        int randNum = int(random(0, 2));
        int randomX1 = width/4;
        //int randomX2 = 400;
        int randomX3 = width/2 + width/4;

        if (randNum == 0) {
          randomX1 = width/4;
          //randomX2 = 400;
          randomX3 = width/2 + width/4;
        } else if (randNum == 1) {
          randomX1 = width/2 + width/4;
          //randomX2 = 200;
          randomX3 = width/4;
        }

        e1 = new Enemy(randomX1, height/3, enemySize);
        //e2 = new Enemy(randomX2, height/3, enemySize);
        yo1 = new Yoda(randomX3, height/3, yodaSize);

        enemyList.add(e1);
        //enemyList.add(e2);
        yodaList.add(yo1);

        enemiesOnScreen = true;
        yodaOnScreen = true;
      }
    }

    //enemy for loop
    for (Enemy anEnemy : enemyList) {
      anEnemy.render();
      image(vaderImage, anEnemy.enemyX, anEnemy.enemyY);
    }

    //yoda for loop
    for (Yoda aYoda : yodaList) {
      aYoda.render();
      image(yodaImage, aYoda.yodaX, aYoda.yodaY);
    }

    //bullet control for loop
    for (Bullet aBullet : bulletList) {
      aBullet.render();
      image(bulletImage, aBullet.x, aBullet.y);
      aBullet.move();
      aBullet.checkRemove();


      for (Enemy anEnemy : enemyList) {
        anEnemy.render();
        aBullet.shootEnemy(anEnemy);

        for (Yoda aYoda : yodaList) {
          aYoda.render();
          aBullet.shootYoda(aYoda);
        }
      }
    }

    //for loop checking for unwanted bullets
    for (int i = bulletList.size()-1; i >= 0; i--) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    //for loop checking for unwanted enemies
    for (int i = enemyList.size()-1; i >= 0; i--) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        deadX = anEnemy.enemyX;
        deadY = anEnemy.enemyY;

        enemyList.remove(anEnemy);
        println("GOTTEM!");
        pScore += 1;
        deadAnimation.isAnimating = true;
      }
    }

    if (deadAnimation.isAnimating == true) {
      deadAnimation.display(int(deadX), int(deadY));
    }

    //checking if Yoda is shot
    for (int i = yodaList.size()-1; i >= 0; i--) {
      Yoda aYoda = yodaList.get(i);

      if (aYoda.shouldRemove == true) {
        yodaList.remove(aYoda);
        println("NAUR!");
        state = 4;
      }
    }

    if (pScore == winScore) {
      state = 5;
    }


    //player control    
    if(mouseX < width/2){
     image(gunLeft, p1.x + 23, p1.y); 
    }
    
    else{
     image(gunRight, p1.x - 23, p1.y); 
    }
    
    break;

  case 2:

    enemySize = 150;
    yodaSize = enemySize;
    drawMainScreen();
    drawScore(pScore, width - 75, height - 75, color(255));
    winScore = 25;

    currentTime = millis();
    currentTimeC = millis();

    //sound
    if (backgroundMusic.isPlaying() == false && state == 2) {
      backgroundMusic.play();
      homeScreenMusic.stop();
    }

    //timer action
    if (currentTime - startTime > interval) {
      println("timer triggered");

      //reset my timer
      startTime = millis();

      //change timer
      if (enemiesOnScreen && yodaOnScreen) {
        //println("done");

        //Remove enemies/yoda
        enemyList.clear();
        yodaList.clear();
        enemiesOnScreen = false;
        yodaOnScreen = false;
      } else {
        //println("goodbye");

        //respawn enemies/yoda at random location

        int randNum = int(random(0, 3));
        int randomX1 = 200;
        int randomX2 = 400;
        int randomX3 = 600;

        if (randNum == 0) {
          randomX1 = 200;
          randomX2 = 400;
          randomX3 = 600;
        } else if (randNum == 1) {
          randomX1 = 600;
          randomX2 = 200;
          randomX3 = 400;
        } else if (randNum == 2) {
          randomX1 = 400;
          randomX2 = 600;
          randomX3 = 200;
        }

        e1 = new Enemy(randomX1, height/3, enemySize);
        e2 = new Enemy(randomX2, height/3, enemySize);
        yo1 = new Yoda(randomX3, height/3, yodaSize);

        enemyList.add(e1);
        enemyList.add(e2);
        yodaList.add(yo1);

        enemiesOnScreen = true;
        yodaOnScreen = true;
      }
    }

    //enemy for loop
    for (Enemy anEnemy : enemyList) {
      anEnemy.render();
      anEnemy.render();
      image(vaderImage, anEnemy.enemyX, anEnemy.enemyY);
    }

    //yoda for loop
    for (Yoda aYoda : yodaList) {
      aYoda.render();
      image(yodaImage, aYoda.yodaX, aYoda.yodaY);
    }

    //bullet control for loop
    for (Bullet aBullet : bulletList) {
      aBullet.render();
      image(bulletImage, aBullet.x, aBullet.y);
      aBullet.move();
      aBullet.checkRemove();


      for (Enemy anEnemy : enemyList) {
        anEnemy.render();
        aBullet.shootEnemy(anEnemy);

        for (Yoda aYoda : yodaList) {
          aYoda.render();
          aBullet.shootYoda(aYoda);
        }
      }
    }

    //for loop checking for unwanted bullets
    for (int i = bulletList.size()-1; i >= 0; i--) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    //for loop checking for unwanted enemies
    for (int i = enemyList.size()-1; i >= 0; i--) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        deadX = anEnemy.enemyX;
        deadY = anEnemy.enemyY;

        enemyList.remove(anEnemy);
        println("GOTTEM!");
        pScore += 1;
        deadAnimation.isAnimating = true;
      }
    }

    if (deadAnimation.isAnimating == true) {
      deadAnimation.display(int(deadX), int(deadY));
    }

    //checking if Yoda is shot
    for (int i = yodaList.size()-1; i >= 0; i--) {
      Yoda aYoda = yodaList.get(i);

      if (aYoda.shouldRemove == true) {
        yodaList.remove(aYoda);
        println("NAUR!");
        state = 4;
      }
    }

    if (pScore == winScore) {
      state = 5;
    }

    //player control
    if(mouseX < width/2){
     image(gunLeft, p1.x + 23, p1.y); 
    }
    
    else{
     image(gunRight, p1.x - 23, p1.y); 
    }
    break;

  case 3:
    enemySize = 75;
    yodaSize = enemySize;
    drawMainScreen();
    drawScore(pScore, width - 75, height - 75, color(255));
    winScore = 50;
    yodaImage.resize(150, 150);
    vaderImage.resize(125, 125);


    currentTime = millis();
    currentTimeC = millis();

    //sound
    if (backgroundMusic.isPlaying() == false && state == 3) {
      backgroundMusic.play();
      homeScreenMusic.stop();
    }

    //timer action
    if (currentTime - startTime > interval) {
      println("timer triggered");

      //reset my timer
      startTime = millis();

      //change timer
      if (enemiesOnScreen && yodaOnScreen) {
        //println("done");

        //Remove enemies/yoda
        enemyList.clear();
        yodaList.clear();
        enemiesOnScreen = false;
        yodaOnScreen = false;
      } else {

        //respawn enemies/yoda at random location

        int randNum = int(random(0, 8));
        int randomX1 = 100;
        int randomX2 = 200;
        int randomX3 = 300;
        int randomX4 = 400;
        int randomX5 = 500;
        int randomX6 = 600;
        int randomX7 = 700;


        if (randNum == 0) {
          randomX1 = 100;
          randomX2 = 200;
          randomX3 = 300;
          randomX4 = 400;
          randomX5 = 500;
          randomX6 = 600;
          randomX7 = 700;
        } else if (randNum == 1) {
          randomX1 = 700;
          randomX2 = 100;
          randomX3 = 200;
          randomX4 = 300;
          randomX5 = 400;
          randomX6 = 500;
          randomX7 = 600;
        } else if (randNum == 2) {
          randomX1 = 600;
          randomX2 = 700;
          randomX3 = 100;
          randomX4 = 200;
          randomX5 = 300;
          randomX6 = 400;
          randomX7 = 500;
        } else if (randNum == 3) {
          randomX1 = 500;
          randomX2 = 600;
          randomX3 = 700;
          randomX4 = 100;
          randomX5 = 200;
          randomX6 = 300;
          randomX7 = 400;
        } else if (randNum == 4) {
          randomX1 = 400;
          randomX2 = 500;
          randomX3 = 600;
          randomX4 = 700;
          randomX5 = 100;
          randomX6 = 200;
          randomX7 = 300;
        } else if (randNum == 5) {
          randomX1 = 300;
          randomX2 = 400;
          randomX3 = 500;
          randomX4 = 600;
          randomX5 = 700;
          randomX6 = 100;
          randomX7 = 200;
        } else if (randNum == 6) {
          randomX1 = 300;
          randomX2 = 400;
          randomX3 = 500;
          randomX4 = 600;
          randomX5 = 700;
          randomX6 = 100;
          randomX7 = 200;
        }

        e1 = new Enemy(randomX1, height/3, enemySize);
        e2 = new Enemy(randomX2, height/3, enemySize);
        e3 = new Enemy(randomX6, height/3, enemySize);
        e4 = new Enemy(randomX4, height/3, enemySize);
        e5 = new Enemy(randomX7, height/3, enemySize);
        yo1 = new Yoda(randomX3, height/3, yodaSize);
        yo2 = new Yoda(randomX5, height/3, yodaSize);


        enemyList.add(e1);
        enemyList.add(e2);
        enemyList.add(e3);
        enemyList.add(e4);
        enemyList.add(e5);
        yodaList.add(yo1);
        yodaList.add(yo2);

        enemiesOnScreen = true;
        yodaOnScreen = true;
      }
    }

    //enemy for loop
    for (Enemy anEnemy : enemyList) {
      anEnemy.render();
      anEnemy.render();
      anEnemy.render();
      anEnemy.render();
      anEnemy.render();
      image(vaderImage, anEnemy.enemyX, anEnemy.enemyY);
    }

    //yoda for loop
    for (Yoda aYoda : yodaList) {
      aYoda.render();
      aYoda.render();
      image(yodaImage, aYoda.yodaX, aYoda.yodaY);
    }

    //bullet control for loop
    for (Bullet aBullet : bulletList) {
      aBullet.render();
      image(bulletImage, aBullet.x, aBullet.y);
      aBullet.move();
      aBullet.checkRemove();


      for (Enemy anEnemy : enemyList) {
        anEnemy.render();
        aBullet.shootEnemy(anEnemy);

        for (Yoda aYoda : yodaList) {
          aYoda.render();
          aBullet.shootYoda(aYoda);
        }
      }
    }

    //for loop checking for unwanted bullets
    for (int i = bulletList.size()-1; i >= 0; i--) {
      Bullet aBullet = bulletList.get(i);

      if (aBullet.shouldRemove == true) {
        bulletList.remove(aBullet);
      }
    }

    //for loop checking for unwanted enemies
    for (int i = enemyList.size()-1; i >= 0; i--) {
      Enemy anEnemy = enemyList.get(i);

      if (anEnemy.shouldRemove == true) {
        deadX = anEnemy.enemyX;
        deadY = anEnemy.enemyY;

        enemyList.remove(anEnemy);
        println("GOTTEM!");
        pScore += 1;
        deadAnimation.isAnimating = true;
      }
    }

    if (deadAnimation.isAnimating == true) {
      deadAnimation.display(int(deadX), int(deadY));
    }

    //checking if Yoda is shot
    for (int i = yodaList.size()-1; i >= 0; i--) {
      Yoda aYoda = yodaList.get(i);

      if (aYoda.shouldRemove == true) {
        yodaList.remove(aYoda);
        println("NAUR!");
        state = 4;
      }
    }

    if (pScore == winScore) {
      state = 5;
    }

    //player control
    if(mouseX < width/2){
     image(gunLeft, p1.x + 23, p1.y); 
    }
    
    else{
     image(gunRight, p1.x - 23, p1.y); 
    }
    break;

  case 4:
    drawFailScreen();
    if (failScreenMusic.isPlaying() == false && state == 4) {
      failScreenMusic.play();
      backgroundMusic.stop();
    }
    break;

  case 5:
    drawWinScreen();

    if (winScreenMusic.isPlaying() == false && state == 5) {
      winScreenMusic.play();
      backgroundMusic.stop();
    }
    
  case 6:
  drawHowToScreen();
  homeScreenMusic.stop();
  }
}

void mousePressed() {
  if (state == 1 || state == 2 || state == 3) {
    Bullet newBullet = new Bullet(p1.x, p1.y);
    newBullet.dx = mouseX - newBullet.x;
    newBullet.dy = mouseY - newBullet.y;
    bulletList.add(newBullet);
    blasterShot.play();
  }
}

void keyPressed() {
  if (key == 'h') {
    if (state == 4 || state == 5 || state == 6) {
      state = 0;
      enemyList.clear();
      yodaList.clear();
      homeScreenMusic.play();
      backgroundMusic.stop();
      failScreenMusic.stop();
      winScreenMusic.stop();
      pScore = 0;
      yodaImage.resize(250, 250);
      vaderImage.resize(225, 225);
    }
  }
  if (key == 'e') {
    if (state == 0) {
      state = 1;
      enemyList.clear();
      yodaList.clear();
    }
  }

  if (key == 'm') {
    if (state == 0) {
      state = 2;
      enemyList.clear();
      yodaList.clear();
    }
  }

  if (key == 'i') {
    if (state == 0) {
      state = 3;
      enemyList.clear();
      yodaList.clear();
    }
  }
  
  if (key == 'l'){
   if(state == 0){
    state = 6; 
   }
  }
}

void drawStartScreen() {
  image(homeBackground, width/2, height/2);
  textSize(75);
  fill(255);
  text("Easy: Press 'e'", width/2, height/3);
  text("Medium: Press 'm'", width/2, height/2);
  text("Impossible: Press 'i'", width/2, height/2 + height/6);
  textSize(50);
  text("Learn how to play: Press 'L'", width/2, height - 50);
}

void drawMainScreen() {
  image(mainBackground, width/2, height/2);
}

void drawFailScreen() {
  image(failScreenImage, width/2, height/2);
  fill(0);
  textSize(40);
  text("Failed me you have!", 250, 45);
  text("Saved me, you have not!", 250, 80);
  fill(0,255,0);
  textSize(30);
  text("Press 'h' for Home", width/2 + width/4, 450);
}

void drawWinScreen() {
  image(winScreen, width/2, height/2);
  fill(255);
  textSize(55);
  text("Saved me you have!", 275, 75);
  text("Respect you, I must!", width - 250, height - 50);
}

void drawHowToScreen(){
  background(0);
  textSize(100);
  fill(#FEFF00);
  text("How to Play", width/2, 50);
  textSize(30);
  text("1: Select a level by pressing 'e', 'm', or 'i'", width/2, 150);
  text("2: Aim for Vader! Shoot all Vader's to earn points", width/2, 200);
  text("3: If you shoot Yoda, you lose and must restart!", width/2, 250);
  textSize(100);
  text("How to Win", width/2, 325);
  textSize(50);
  fill(#079B00);
  text("Easy", width/2 - width/3, 415);
  fill(#FEFF00);
  text("Medium", width/2, 415);
  fill(#A00000);
  text("Impossible", width/2 + width/3, 415);
  textSize(30);
  text("Kill 50 Vaders", width/2 + width/3, 450);
  fill(#FEFF00);
  text("Kill 25 Vaders", width/2, 450);
  fill(#079B00);
  text("Kill 10 Vaders", width/2 - width/3, 450);
  textSize(35);
  text("Do or do not, there is no try - Master Yoda", width/2, height - 50);
}

void drawScore(int score, int x, int y, color c) {
  fill(c);
  text(score, x, y);
}

//chatGPT help
//How do I clear my arrayList in processingIDE?
//In Processing, you can clear an ArrayList by calling the clear() method on it.
//This method removes all elements from the list, leaving it empty.

//Spawn enemies in one of four random locations: width/2, width/2+width/4, width/4 (not used, still citing)
//int randomX1 = width/4 * (int(random(3)) + 1);
//e1 = new Enemy(randomX1, height/3, enemySize);

//int randomX2 = (width/2 + width/4) * (int(random(3)) + 1);
//e2 = new Enemy(randomX2, height/3, enemySize);


//enemyList = new ArrayList<Enemy>();
//enemyList.add(e1);
//enemyList.add(e2);


////Yoda setup
//int randomX3 = width/4 * (int(random(3)) + 1);
//yo1 = new Yoda(randomX3, height/3, yodaSize);
//yodaList = new ArrayList<Yoda>();
//yodaList.add(yo1);

//int randomX1 = width/2 * (int(random(3)) + 1);
//int randomX2 = (width/2 + width/4) * (int(random(3)) + 1);
//int randomX3 = width/4 * (int(random(3)) + 1);

//Make this ball move diagnolly using my ball class (insert code)
//float dx = mouseX - x;
//float dy = mouseY - y;

// Calculate distance to the mouse
//float distance = sqrt(dx * dx + dy * dy);

//if (distance > 1) {
//  float speedX = dx / distance * speed;
//  float speedY = dy / distance * speed;
//  x += speedX;
//  y += speedY;
//}
