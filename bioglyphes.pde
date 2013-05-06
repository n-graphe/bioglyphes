ArrayList<branche> branches = new ArrayList<branche>();
void setup(){
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
setupAllBranches();
}
void draw(){
  translate(width/2,height/2);
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
    mousePressed();
  }
}
void mousePressed(){
  background(255);
  setupAllBranches();
}
void setupAllBranches(){
  branches = new ArrayList<branche>();
    for(int i=0; i<15; i++){
    InitBranche();
  }
}
void InitBranche(){
    branches.add( new branche(new PVector(), new PVector(random(-1,1),random(-1,1)), 0));
}
