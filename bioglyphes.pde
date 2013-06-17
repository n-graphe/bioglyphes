
void setup(){
  size(1600,1000);
  background(BACKGROUND_COLOR);
  SetupControls();
  SetupGeomerative();
  //
  //
  view.noStroke();
  view.fill(0);
}
void draw(){
  long time = timestamp();
  //
   view.beginDraw();
   GUI.beginDraw();
    for(Branche b:branches){
      b.Draw();
   }
   view.endDraw();
   GUI.endDraw();
   background(BACKGROUND_COLOR);
   //
    noStroke();
    fill(255-BACKGROUND_COLOR,10);
    typo.draw();
    //
   image(view,0,0);
   image(GUI,0,0);
   //
}
RPoint startDrag=null;
void mousePressed(){
  if(mouseX>110){
    startDrag = new RPoint(mouseX,mouseY);
  }
}
void mouseDragged(){
  mouseMoved();
  if(startDrag!=null){
    GUI.stroke(255-BACKGROUND_COLOR,128);
    GUI.ellipseMode(CENTER);
    GUI.ellipse(startDrag.x,startDrag.y,10,10);
    GUI.line(mouseX,mouseY,startDrag.x,startDrag.y);
  }
}
void mouseReleased(){
  if(startDrag!=null){
    GUI.clear();
    RPoint t = new RPoint(mouseX,mouseY);
    t.sub(startDrag);
    t.scale(.1);
    //
    //
    AddRoot(new RPoint(startDrag.x,startDrag.y),t);
  }
  startDrag = null;
}
void mouseMoved(){
  RPoint nt = NaturalTangent( new RPoint(mouseX,mouseY));
  GUI.clear();
  GUI.stroke(0,128,255,128);
  GUI.strokeWeight(1);
  GUI.fill(255-BACKGROUND_COLOR,20);
  GUI.line(mouseX,mouseY,mouseX+nt.x,mouseY+nt.y);
  GUI.noStroke();
  GUI.ellipseMode(CENTER); 
  GUI.ellipse(mouseX,mouseY,NATURAL_TANGENT_AREA_SIZE*2,NATURAL_TANGENT_AREA_SIZE*2);
}
void AddRoot(RPoint p, RPoint t){
  Branche b = new Branche();
  b.InitRoot(p,t);
  branches.add(b);
}
