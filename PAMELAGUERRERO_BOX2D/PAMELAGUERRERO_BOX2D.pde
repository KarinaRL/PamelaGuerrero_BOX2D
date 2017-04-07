//CLICK IN THE SCREEN
//PRESS 1,HOW TO PLAY
//PRESS 2 STRART GAME/ X TO QUICK
//AND b GO BACK TO THE MAIN MENU :)
//

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

//Box2D Variables
Box2DProcessing mBox2D;
Ground ground;
Point gem_sprite; 
H hero;
ArrayList<BEL> b;
ArrayList<Particle> particles;
ArrayList<Point> points;
ArrayList<Boundary> boundaries;
int playerScore = 0;
////////////////////////////////////////////
final int stateMenu = 0;
final int Intructions = 1;
final int Game = 2;
int state = stateMenu;
////////////////////////
PImage game;
int y;
PImage heart;

void setup(){
  background(1);
  size(500,850);
  smooth();
  mBox2D = new Box2DProcessing(this);
  mBox2D.createWorld();
  mBox2D.setGravity(0.0f,-5.8f);
 ////////////////////////
   game = loadImage("GAMEB1.jpg");
   heart= loadImage("BACK.jpg");
  //////////////////////
  gem_sprite = new Point(mBox2D);
  hero = new H(100, 60, mBox2D);
  ground = new Ground(mBox2D);
  /////////////////////////
  b = new ArrayList<BEL>();
  b.add(new BEL(width/3,height-740,width/6-2,10,3));
  b.add(new BEL(4*width/5,height-730,width/3-4,10,6));
  //
  b.add(new BEL(width/9,height-450,width/6-2,10,3));
  b.add(new BEL(4*width/5,height-430,width/3-5,10,6));
  //
  b.add(new BEL(width/3,height-350,width/4-2,10,3));
  b.add(new BEL(4*width/6,height-180,width/3-5,10,6));
  //
  b.add(new BEL(width/8,height-130,width/6-2,10,6));
  ///////////////////////////////////////
  particles = new ArrayList<Particle>();
  points =  new ArrayList<Point>();
  points.add(gem_sprite);
  ////////////////////////////
  mBox2D.world.setContactListener(new CustomListener());
 /////////////////////////////////////
  boundaries = new ArrayList<Boundary>();
  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/7,height-750,width/6-10,15,3));
  boundaries.add(new Boundary(3*width/6,height-705,width/6-10,15,3));
  boundaries.add(new Boundary(3*width/5,height-605,width/6-10,15,10));
  //
  boundaries.add(new Boundary(width/3,height-550,width/3-15,15,0));
  boundaries.add(new Boundary(5*width/6,height-515,width/5-20,15,0));
  boundaries.add(new Boundary(width/15,height-520,width/8-10,15,15));
  boundaries.add(new Boundary(width/4,height-440,width/8-10,15,3));
   boundaries.add(new Boundary(width/2,height-430,width/6-10,15,0));
  //
  boundaries.add(new Boundary(width/7,height-350,width/8-10,15,10));
  boundaries.add(new Boundary(width/3.5,height-250,width/8-10,15,0));
  boundaries.add(new Boundary(2*width/4,height-290,width/6-10,15,3));
  boundaries.add(new Boundary(3*width/4,height-300,width/6-10,15,10));
  boundaries.add(new Boundary(2*width/2,height-350,width/4-10,15,0));
  // 
  boundaries.add(new Boundary(width/2,height-850,width/0.5-100,0,0));
  boundaries.add(new Boundary(width-1,height/2,0,height,0));
  boundaries.add(new Boundary(1,height/2,0,height,0));
}
////////////////////////////////////////////////////////////////////////////////////
void draw(){
  background(0);  
  mBox2D.step();
  ////////////////////////////
   switch (state) {
  case stateMenu:
    Menu();
    break;
  case Intructions:
    hIntructions();
    break;
  case Game:
   hGame();
   display();
    
    break;
  } 
  
}
////////////////////////////////////////////////////////
void drawType()
{
  fill(255);
  textSize(20);
  String score = "SCORE: " + playerScore;
  pushMatrix();
    translate(20,30);
    text(score,0,0);
  popMatrix();  
}
/////////////////////////////////////////////////////////////
void keyPressed() {
  switch (state) {
  case stateMenu:
    keyStateMenu();
    break;
  case Intructions:
    keyIntructions();
    break;
  case Game:
    keySGame();
    break;
  }
   switch (keyCode){
     case 37:
    if (keyCode == LEFT)  {
       hero.move("left");
    }
    break; case 39:
    if (keyCode == RIGHT) {
      hero.move("right");
    }
   break; case 38:
     if (keyCode == UP) {
     hero.move("up");
     }
     break;
   }
  }

void keyReleased() {
  switch (keyCode){
     case 37:
    if (keyCode == LEFT)  {
       hero.stopMove("left");
    }
    break; case 39:
    if (keyCode == RIGHT) {
      hero.stopMove("right");
    }
   break; case 38:
     if (keyCode == UP) {
      hero.stopMove("up");
     }
     break;
  }
}

void mouseReleased(){
  hero.stopMove();
}
//////////////////////////////////////////
  void keyStateMenu() {
  //
  switch(key) {
  case '1':
    state =Intructions;
    break;
  case '2':
    state = Game;
    break;
  case 'x':
  case 'X':
    // quit
    exit();
    break;
  }
} 
void keyIntructions() {
  // any key is possible
  switch(key) {
 case'b':
    state = stateMenu;
    break;
  } 
} 
void keySGame(){
  // any key is possible
  switch(key) {
    case'b':
    state = stateMenu;
    break;
  }
}
//////////////////////////////////////////////////////////////////
void display(){
  
  drawType();
  hero.update();
  ground.draw();
  hero.draw();
  
  for (BEL wall: b) {
    wall.display();
  }
  if (mousePressed) {
    hero.applyVelocity(mouseX,mouseY);
  } 
  
  if (random(1) < 0.1) {
    float sz = random(4, 8);
    particles.add(new Particle(random(width), 10, sz));
  }
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }
   // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  //point
  for(int i = points.size()-1; i>= 0; i--)
  {
    Point p = points.get(i);
    p.draw();
    if(p.done())
    {
      points.remove(i);
      points.add(new Point(mBox2D));
    }
  }
}
////////////////////////////////////////////////
void Menu() {
  background(game);
  y++;
  if (y > height) {
    y = 0; 
  }  
  //background (171,192,35);
  //------
  noStroke();
  fill(1);
  rectMode(CENTER);
  rect(0,395,1000,110);
  textSize(100);
  fill(random(243),47,195);
  text(" ĞΦŦCĦΛ ", 10, 440, 3);
  
  textSize(20);
  textAlign(CENTER);
  fill(103,280,255);
  text("HΦW TΦ PL∂Y", 270, 480);//1
  text("SŦ∂RŦ G∂MЭ",270,500);//2
  //

  textAlign(LEFT);
  text("► β", 10, 780);//b
  text("► ×", 10, 800);//x
  
} 

void hIntructions() {
  background(heart);
  y++;
  if (y > height) {
    y = 0; 
  }
  //background (132,34,189); 
  //
  textSize(50);
  fill(random(264),103,253);
  text(" HOW TO PLAY", 70, 80, 5);
  textSize(20);
  //fill(#EFC0FA);
  //text("...",220,140);
  fill(#C792ED);
  text("Try to trap as many hearts you can",70,170);
  text("to become a human being",120,200);
  text("Use mouse ",120,280);
  fill(random(264),103,253);
  textSize(50);
  text("↗",240,300);
   fill(#C792ED);
  textSize(20);
  text("to move ",300,280);
  text("Do not let the",70,370);
  text("touch the ground",250,370);
  fill(random(264),103,253);
   textSize(50);
  text("♥",205,370);
  textSize(15);
  text("NOTE:",250,670);
    text("Also, you can use ←↑→to move",250,690);
  textSize(20);
  fill(200,56,241);
  text("► β", 450, 800);//b
}
void hGame(){
 background(heart);
  y++;
  if (y > height) {
    y = 0; 
  } 
  //background (48,216,222);
  textSize(20);
  fill(200,56,241);
  text("► β ", 450, 800);//b
} 