//
import processing.pdf.*;
import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;


ArrayList<Box> boxes;
//
String title = "archilab";
RShape typo;

void setup(){
  size(900,500);
  background(255);
  SetupTypo();
  SetupBox2D();
 // frameRate(3);
  //noSmooth();
  noStroke();
  boxes = new ArrayList<Box>();
  //
}
void SetupTypo(){
  RG.init(this);
  typo = RG.getText(title,"heimatsansregular.ttf",200,CENTER);
  typo.translate(width/2,height/2+60);
}
void draw(){
    // Boxes fall from the top every so often
  // We must always step through time!
 // background(255);
  box2d.step();

  fill(0,100);
  if (random(1) < 0.3 && boxes.size()<400) {
    Box p = new Box(random(0,width),random(200,300));
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
      boxes.remove(i);
    }
  }
  
}
void keyPressed(){
  saveFrame("preview.png");
}
