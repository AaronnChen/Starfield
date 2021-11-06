Particle[] particles = new Particle[1000];

int initialSec = second(); //for time
int secPassed = 0; //for time

float eSize = 0; //for wave
int eColor = 75; //for wave
int eWeight = 4; //for wave
int eTime = 3; //for wave

//orb
float orbSize = 50;

boolean comeIn = false; //for click
int secPassedSinceClick = 0;
int timeOut;
int clickSec;
int comeInTime;

void setup() {
  size(800, 800);
  background(20, 20, 20);
 
  for(int i = 0; i < particles.length; i++) {
    if (i % 5 == 0) particles[i] = new OddballParticle();
    else particles[i] = new Particle();
  }
 
} //END OF SETUP()
void draw() {
  //VARIABLES
  if(initialSec == second() - 1 || initialSec == second() + 59) { //TIME
    secPassed++;
    initialSec = second();
  }
  
  if(clickSec != 0){
    secPassedSinceClick = secPassed - clickSec - 3;
  }
  
  if(comeIn == false && secPassed >= eTime) {
    timeOut = (secPassed - 3) - clickSec;
  }
  //END VARIABLES

  //background(20, 20, 20);
  
  //WAVE
  if(secPassed >= eTime) {
    noFill();
    stroke(0, eColor, eColor);
    strokeWeight(eWeight);
    ellipse(400, 400, eSize, eSize);

    if(comeIn == false) {
      eColor += 2;
      eSize += 15;
      eWeight += 1;
    } else {
      if(eColor >= 75) { eColor -= 2; }
      if(eSize >= 0) { eSize -= 15; }
      if(eWeight >= 2) { eWeight -= 1; }
    }
   
  }
  //END WAVE
 
  //PARTICLES
   if(secPassed >= eTime) {
     for(int i = 0; i < particles.length; i++) {
       particles[i].move();
       particles[i].show();
     }
   }
  //END PARTICLES
  /*
  //ORB
  noStroke();
  fill(122, 244, 255);

  if(secPassed < eTime) {
     ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), orbSize, orbSize);
     if(orbSize >= 1) {
       orbSize /= 1.02;
     }
  }
  
  if(secPassed > eTime) {
    if(comeIn == false) {
         ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), orbSize, orbSize);
         if(orbSize >= 1) {
           orbSize /= 1.08;
         }
    }
      
    if(comeIn == true && secPassedSinceClick >= timeOut - 1) {
      if(orbSize <= 50) {
        orbSize *= 1.04;
     } 
       
      if(orbSize >= 40) {
        ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), (float)(orbSize + (Math.random() * 23)) - 11, (float)(orbSize + (Math.random() * 23) - 11));
      } 
       
      else {
        ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), orbSize, orbSize);
      }
    }
  } */
  //END ORB

} //END OF DRAW()

void mousePressed() {
 
  if(secPassed >= eTime) {
    clickSec = secPassed - 3;
    
    if(comeIn == true) {
    comeIn = false;
    } else {
    comeIn = true;
    }
  }

} //END OF MOUSEPRESSED()

class Particle
{
 
  double myX, myY, myAngle, mySpeed; // baseline properties
  int dirX, dirY; //direction of particle X and Y
  boolean first = true; //tracker
  color myColor; //color property
 
  Particle() {
   
   myX = 400.0;
   myY = 400.0;
   myAngle = Math.random() * 2.0 * Math.PI;
   mySpeed = (Math.random() * 5) + 0.0001;
   myColor = color(255);
   
  }
 
  void move() {
   
    if(comeIn == false) { //regular move
      myX = (Math.cos(myAngle) * mySpeed) + myX;
      myY = (Math.sin(myAngle) * mySpeed) + myY;
    } else { //move inwards when clicked
        if(dirX == 1 && myX >= 400) { //if right bound and not crossed middle
          myX = myX - (Math.cos(myAngle) * mySpeed);
        } else if(dirX == -1 && myX <= 400) { //if left bound and not crossed middle
          myX = myX - (Math.cos(myAngle) * mySpeed);
        } if(dirY == 1 && myY >= 400) { //if down bound and not crossed middle
          myY = myY - (Math.sin(myAngle) * mySpeed);  
        } else if(dirY == -1 && myY <= 400) { //if up bound and not crossed middle
          myY = myY - (Math.sin(myAngle) * mySpeed);
        }
    }
   
    if(first == true) { //determine direction of particle
     
      if((myX - 400) > 0) { //X
        dirX = 1; //right bound
      } else if((myX - 400) < 0) {
        dirX = -1; //left bound
      }
     
      if((myY - 400) > 0) { //Y
        dirY = 1; //down bound
      } else if((myY - 400) < 0) {
        dirY = -1; //up bound
      }
       
      first = false;
    }

  }
 
  void show() {
   
    noStroke();
    fill(myColor);
    ellipse((float)myX, (float)myY, 6, 6);
   
  }
} //END OF PARTICLE CLASS

class OddballParticle extends Particle
{
  OddballParticle() {
   myX = 400.0;
   myY = 400.0;
   myAngle = Math.random() * 2.0 * Math.PI;
   mySpeed = (Math.random() * 5) + 0.0001;
   myColor = color(0, 234, 255);
  }
   
} //END OF ODDBALLPARTICLE
