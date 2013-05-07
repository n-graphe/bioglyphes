import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
//
String title = "aA";
RShape typo;
//
ArrayList<branche> branches = new ArrayList<branche>();
//
int drawingCount = 0;
//
void setup(){
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
    SetupTypo();

setupAllBranches();
}
int frameWait = 0;
void draw(){
  drawingCount = 0;
  for(branche b:branches){
    b.draw();
  }
  for(int bi =0; bi<branches.size(); bi++){
    branche b = branches.get(bi);
    if(b.dead){
      branches.remove(bi);
    }
  }
  if(branches.size()==0){
     // mousePressed();
  }
  print(" > "+drawingCount);
}
void mousePressed(){
  background(255);
  setupAllBranches();
}
void SetupTypo(){
  RG.init(this);
  typo = RG.getText(title,"heimatsansregular.ttf",800,CENTER);
  typo.translate(width/2,height/2+100);
  //typo.draw();
}
void setupAllBranches(){
  branches = new ArrayList<branche>();
    for(int i=0; i<20; i++){
    InitBranche();
  }
}
RPoint PointInTypo(){
  RPoint p = new RPoint();
  while(!typo.contains(p)){
    p = new RPoint(random(0,width),random(0,height));
  }
  return p;
}
void InitBranche(){
    branches.add( new branche(PointInTypo(), new RPoint(random(-1,1),random(-.2,1)), 0));
}
void keyPressed(){
  if(key=='s'){
    saveFrame("frame#####.png");
  }
}
