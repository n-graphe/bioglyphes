//
import processing.pdf.*;
import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;


ArrayList<Box> boxes;
//
String title = "archilab";
RShape typo;
int steps = 0;

void setup(){
  size(900,500);
  background(255);
  SetupTypo();
  SetupBox2D();
 // frameRate(3);
  //noSmooth();
  //noStroke();
  noFill();
  boxes = new ArrayList<Box>();
  //
}
void SetupTypo(){
  RG.init(this);
  typo = RG.getText(title,"heimatsansregular.ttf",200,CENTER);
  typo.translate(width/2,height/2+60);
}
void draw(){
  
  for(int i=0; i<10; i++){
    step();
  }
  
}
void step(){
  steps++;
      // Boxes fall from the top every so often
  // We must always step through time!
 // background(255);
  float gravityPow = 60;
  float speedRotation = 30;
  box2d.setGravity(gravityPow*sin(steps/speedRotation), gravityPow*cos(steps/speedRotation));
  //box2d.setGravity(0,-gravityPow);
  box2d.step();

  if (random(1) < 1  && boxes.size()<100) {
    Box p = new Box(random(0,width),random(200,350));
    boxes.add(p);
  }
  
    // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }
  fill(0);
  //typo.draw();

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      beginShape();
      noFill();
      stroke(0,80);
      strokeWeight(.1);
      for(int p=0; p<b.trajectoire.size(); p++){
        RPoint tp = b.trajectoire.get(p);
        vertex(tp.x,tp.y);
      }
      endShape();
      boxes.remove(i);
    }
  }
}
void keyPressed(){
  saveFrame("preview.png");
}
