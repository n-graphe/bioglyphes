//
ArrayList<Branche> branches = new ArrayList<Branche>();

class Branche{
  //
  int life = 0;
  int lifeTime;
  int level = 0;
  int invertLevel = 0;
  //
  RPoint position;
  RPoint velocity;
  //
  float strokeWeight;
  //
  float misc;
  //
  float circonvolutionSpeed;
  float circonvolutionDirection;
  //
  float structureAttraction;
  //
  Branche parent;
  ArrayList<Branche> children = new ArrayList<Branche>();
  //
  ArrayList<RPoint> positions = new ArrayList<RPoint>();
  ArrayList<RPoint> velocities = new ArrayList<RPoint>();
  //
  Branche(){
    lifeTime=LIFE_TIME;
    strokeWeight = STROKE_WEIGHT;
    misc = sqrt(MISC_LEVEL);
    circonvolutionSpeed = TWO_PI/CIRCONVOLUTION_LEVEL;
    circonvolutionDirection = random(1)<.5?-1:1;
    structureAttraction = STRUCTURE_ATTRACTION/fontSize;
    invertLevel = MAX_LEVEL;
    invertLevel = MAX_LEVEL-1;
  }
  //
  // démarre une branche racine (root)
  //
  void InitRoot(RPoint startingPosition){
    position = new RPoint(startingPosition);
    velocity = new RPoint(0,STARTING_VELOCITY);
    velocity.rotate(random(0,TWO_PI));
    parent = this;
    positions.add(new RPoint(position));
    velocities.add(new RPoint(velocity));
    StrokeWeight();
  }
  // renvoie l'état "root" de la branche ou non.
  boolean isRoot(){ return parent == this; }
  //
  void StrokeWeight(){
    strokeWeight = (1+invertLevel)*STROKE_WEIGHT/MAX_LEVEL*800/fontSize;
  }
  void InitAsChild(Branche _parent){
    parent = _parent;
    position = new RPoint(parent.position);
    velocity = new RPoint(parent.velocity);
    level = parent.level+1;
    invertLevel = MAX_LEVEL-level;
    positions.add(new RPoint(position));
    velocities.add(new RPoint(velocity));
    StrokeWeight();
  }
  //
  boolean Draw(){
    boolean isDrawing = DrawCurrent();
    return DrawChildren() || isDrawing;
  }
  boolean DrawChildren(){
    //
    boolean isChildrenDrawing = false;
    for(int b=0; b<children.size(); b++){
      isChildrenDrawing |= children.get(b).Draw();
    }
    //
    return isChildrenDrawing;
  }
  boolean DrawCurrent(){
    //
    //
    if(life<lifeTime){
      Iteration();
      return true;
    }
    if(life==lifeTime){
      life++;
      if(level<MAX_LEVEL){
        Divide();
      }
      DrawCluster();
    }
    return false;
  }
  void Iteration(){
    //
    if(debug){
     // ellipse(position.x,position.y,strokeWeight,strokeWeight);
    }
    //
    //
    //
    //
    //
    RPoint natTg = NaturalTangent(position);
    natTg.scale(structureAttraction);
    stroke(0,100);
    //
    velocity.add(natTg);
    velocity.rotate(random(-PI,PI)/misc+circonvolutionDirection*circonvolutionSpeed);
    if(velocity.dist(o)>MAX_VELOCITY){
      velocity.normalize();
      velocity.scale(MAX_VELOCITY);
    }
    
    velocities.add(new RPoint(velocity));
    
    position.add(velocity);
    //
    positions.add(new RPoint(position));

    stroke(255,0,0,50);
    //line(position.x,position.y,position.x+velocity.x,position.y+velocity.y);
    //
    
    //
    //
    //
    life++;
    //
    
  }
  void Divide(){
    for(int i=0; i<MAX_CHILDREN; i++){
      Branche branche = new Branche();
      branche.InitAsChild(this);
      children.add(branche);
    }
  }
  void DrawCluster(){
    beginShape();
    RPoint start = positions.get(0);
    vertex(start.x,start.y);
    for(int c=1; c<positions.size()-1; c++){
      RPoint p = positions.get(c);
      RPoint v = new RPoint(velocities.get(c));
      vertex(p.x,p.y);      
    }
    strokeWeight(strokeWeight);
    stroke(0);
    noFill();
    endShape();
  }
}
