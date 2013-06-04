class branche{
  //
  RPoint position;
  RPoint velocity;
  //
  branche(RPoint init, RPoint initV){
    position = new RPoint(init);
    velocity = new RPoint(initV);
  }
  void Update(){
    position.add(velocity);
    point(position.x,position.y);
  }
}
