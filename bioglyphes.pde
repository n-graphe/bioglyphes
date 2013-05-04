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
  
    step();
  
}
void step(){
  steps++;
      // Boxes fall from the top every so often
  // We must always step through time!
  background(255);
  float gravityPow = 60;
  float speedRotation = 30;
  //box2d.setGravity(gravityPow*sin(steps/speedRotation), gravityPow*cos(steps/speedRotation));
  box2d.setGravity(0,-gravityPow);
  box2d.step();

  if (mousePressed) {
    Box p = new Box(mouseX,mouseY);
    boxes.add(p);
  }
  
    // Display all the boxes
    noStroke();
  fill(0);
  for (Box b: boxes) {
    b.display();
  }
  fill(255,0,0);
  typo.draw();

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}
void keyPressed(){
  saveFrame("preview.png");
}
