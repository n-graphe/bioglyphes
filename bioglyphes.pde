void setup(){
  size(1600,1000);
  background(255);
  SetupGeomerative();
  noStroke();
  fill(0,10);
  typo.draw();
}
void draw(){
  long time = timestamp();
  //while((timestamp()-time<100)){
    for(Branche b:branches){
      b.Draw();
    }
  //}
}
void mousePressed(){
  AddRoot(new RPoint(mouseX,mouseY));
}
void AddRoot(RPoint p){
  Branche b = new Branche();
  b.InitRoot(p);
  branches.add(b);
}
