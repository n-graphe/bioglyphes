//
ArrayList<Branche> branches = new ArrayList<Branche>();
ArrayList<Branche> clusters = new ArrayList<Branche>();

class Branche{
  //
  int life = 0;
  int lifeTime;
  int level = 0;
  int invertLevel = 0;
  //
  boolean free = false;
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
  ArrayList<RPoint> internalVibrations = new ArrayList<RPoint>();
  ArrayList<RPoint> velocities = new ArrayList<RPoint>();
  //
  color strokeColor = color(0);
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
  void InitRoot(RPoint startingPosition, RPoint startingTangent){
    position = new RPoint(startingPosition);
    velocity = new RPoint(startingTangent);
    /*if(startingTangent.dist()>MAX_VELOCITY){
      startingTangent.normalize()
    }*/
    //velocity.rotate(random(0,TWO_PI));
    parent = this;
    positions.add(new RPoint(position));
    velocities.add(new RPoint(velocity));
    StrokeWeight();
    strokeColor = color(GREY_LEVEL,ALPHA_LEVEL);
  }
  // renvoie l'état "root" de la branche ou non.
  boolean isRoot(){ return parent == this; }
  //
  void StrokeWeight(){
    //
    //
    strokeWeight = (1+invertLevel)*STROKE_WEIGHT/MAX_LEVEL*800/fontSize;
    //
    //
  }
  void InitAsChild(Branche _parent){
    parent = _parent;
    position = new RPoint(parent.position);
    velocity = new RPoint(parent.velocity);
    strokeColor = parent.strokeColor;
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
      TryAddFreeChildren();
      return true;
    }
    if(life==lifeTime){
      life++;
      if(level<MAX_LEVEL){
        Divide();
      }
      clusters.add(this);
    }
    return false;
  }
  //
  //
  //
  // kill everything, every child
  //
  void StopPropagation(){
    life=lifeTime+1;
    clusters.add(this);
    //
    for(int b=0; b<children.size(); b++){
      children.get(b).StopPropagation();
    }
  }
  //
  //
  //
  //
  //
  //
  //  ajoute une mini branche libre
  //
  //
  void TryAddFreeChildren(){
  }
  //
  //
  //
  void Iteration(){
    //
    //
    //
    //
    //
    //
    RPoint natTg = NaturalTangent(position);
    natTg.scale(structureAttraction);
    //
    //
    velocity.add(natTg);
    velocity.rotate(random(-PI,PI)/misc+circonvolutionDirection*circonvolutionSpeed);
    if(velocity.dist(o)>MAX_VELOCITY){
      velocity.normalize();
      velocity.scale(MAX_VELOCITY);
    }
    //
    
    //
    RPoint internalVibration = new RPoint(velocity);
    internalVibration.rotate(random(1)<.5?PI/2:-PI/2);
    internalVibration.normalize();
    internalVibration.scale(random(INTERNAL_VIBRATION_LEVEL));
    //
    
    velocities.add(new RPoint(velocity));
    
    internalVibrations.add(internalVibration);
    
    position.add(velocity);
    //
    positions.add(new RPoint(position));

    view.fill(strokeColor);
    view.noStroke();
    view.ellipse(position.x+internalVibration.x,position.y+internalVibration.y,strokeWeight,strokeWeight);
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
      RPoint iv = new RPoint(internalVibrations.get(c));
      if(c<positions.size()-2){iv = new RPoint();}
      vertex(p.x+iv.x,p.y+iv.y);      
    }
    strokeWeight(strokeWeight);
    stroke(strokeColor);
    noFill();
    endShape();
  }
}
