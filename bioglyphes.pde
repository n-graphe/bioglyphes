import geomerative.*;

RShape archi;

int fc = 0;

int w = 1000;
int h = 500;
ArrayList<LivingLetter2> livingLetters = new ArrayList<LivingLetter2>();
LivingLetter2 livingShape;

void setup() {
  size(w, h);
  RG.init(this);
  background(255);
  archi = RG.loadShape("archi.svg");
  //
  //RG.setPolygonizer(RG.UNIFORMLENGTH);
  //RG.setPolygonizerLength(10);
  //
  randomSeed(200);
  for(RShape shape:archi.children){
    livingLetters.add(new LivingLetter2(shape));
  }
  livingShape = new LivingLetter2(archi);
}

RPoint lastPoint = new RPoint();
void draw() {
  background(255);
  fc = frameCount;
  //translate(-300,-200);
  //scale(2);
  translate(100,100);
  
  noFill();
  beginShape();
  
  //*
    randomSeed(0);
  for(LivingLetter2 letter:livingLetters){
    //for(int i=0; i<15; i++){
      letter.Update();
    //}
  }
  //*/
  /*//println(frameCount);
  for(int i=0; i<10; i++){
      toShape.Update();
   }// */
  
  //
  endShape();
  
}


void keyPressed(){
  if(key=='s'){
    saveFrame("preview.png");
  }
}
