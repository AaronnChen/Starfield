Particle[] particles = new Particle[1000];

int initialSec = second(); //for time
int secPassed = 0; //for time

float eSize = 0; //for wave
int eColor = 75; //for wave
int eWeight = 4; //for wave
int eTime = 3; //for wave

//orb
float orbSize = 75;
int orbBright = 0;

boolean comeIn = false; //for click
int secPassedSinceClick = 0;
int clickSec;

void setup() {
  size(800, 800);
  background(20, 20, 20);
  
  for(int i = 0; i < particles.length; i++) {
    if (i % 5 == 0) particles[i] = new OddballParticle();
    else particles[i] = new Particle();
  }
  
} //END OF SETUP()
void draw()
{
  background(20, 20, 20);
  
  if(initialSec == second() - 1 || initialSec == second() + 59) { //TIME
    secPassed++;
    initialSec = second();
  }
  
  if(secPassed >= eTime) { //WAVE
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
      if(eWeight >= 2) { eWeight -= 2; }
    }
    
  }
  
  if(secPassed >= eTime) { //PARTICLES
    for(int i = 0; i < particles.length; i++) {
      particles[i].move();
      particles[i].show();
      
    }
  }
  
  if(clickSec != 0){
    secPassedSinceClick = secPassed - clickSec;
  }
  
  System.out.println("secPassedSinceClick: " + secPassedSinceClick);
  System.out.println("secPassed: " + secPassed);
  System.out.println("clickSec: " + clickSec);
  
  if(comeIn == true && clickSec == secPassed) {
  
  }
  if(comeIn == false && secPassedSinceClick < 3) { //ORB
    noStroke();
    fill(orbBright, 255, 255);
    ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), orbSize, orbSize);
    
    orbSize /= 1.02;
    orbBright += 2;
  } else if((secPassed > 3 && comeIn == true) || (secPassedSinceClick == 3)) {
    noStroke();
    fill(orbBright, 255, 255);
    ellipse((float)(400 + ((Math.random() * 7) - 3)), (float)(400 + ((Math.random() * 7) - 3)), orbSize, orbSize);
    
    if(orbSize <= 75) {
      orbSize *= 1.02;
    } orbBright -= 2;
    
  }
 
} //END OF DRAW()

void mousePressed() {
  
  if(secPassed >= eTime) {
    clickSec = secPassed;
    
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
   myColor = color(0, 255, 255);
   
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
    myColor = color(0, 102, 204);
  }
   
} //END OF ODDBALLPARTICLE
