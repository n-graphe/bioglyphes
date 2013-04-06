import processing.pdf.*;
import geomerative.*;

RShape archi;

int fc = 0;

int w = 1000;
int h = 600;
ArrayList<LivingLetter> livingLetters = new ArrayList<LivingLetter>();
LivingLetter livingShape;

void setup() {
  size(w, h);
  RG.init(this);
  background(255);
  noSmooth();
  archi = RG.loadShape("ArchiLab.svg");
  //
  //RG.setPolygonizer(RG.UNIFORMLENGTH);
  //RG.setPolygonizerLength(10);
  //
  //colorMode(HSB);
  randomSeed(200);
  for(RShape shape:archi.children){
    livingLetters.add(new LivingLetter(shape));
  }
  println(archi.countChildren());
  livingShape = new LivingLetter(archi);
}

RPoint lastPoint = new RPoint();
void draw() {
  //background(255);
  noFill();
  fc = frameCount;
  /*
  translate(-width*.5,-height*.5);
  scale(2);
  */
  noFill();
  
  
  beginShape();
  
  /*
  //randomSeed(0);
  for(LivingLetter letter:livingLetters){
    //for(int i=0; i<15; i++){
      letter.Update();
    //}
  }
  //*/
  //println(frameCount);
  for(int i=0; i<1; i++){
      livingShape.Update();
   }// */
  
  //
  endShape();
  //noLoop();
}

