import java.util.Date;
import processing.pdf.*;

import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
//
String title = "NATURE";
Boolean[] letterDrawnd;
int letterDrawing = 0;
RShape typo;
RGroup rendu;
RPoint o = new RPoint(0,0); // origine du plan
//
float viewScale = 3;
float fontSize = 300;
boolean debug = false;
//
RPoint startingPoint;
//
//
ArrayList<branche> branches = new ArrayList<branche>();
//
int drawingCount = 0;
//
void setup(){
  size(1600,1000);
  background(255);
  //
  if(!debug){
    beginRecord(PDF,"record-"+timestamp()+".pdf");
  }
  //
  randomSeed(0);
  //
  fill(0);
  noStroke();
  SetupTypo();
  //
  //frameRate(4);
  //
  mousePressed();
  //

  //
  
}
//
void draw(){
  //
  for(int br=0; br < branches.size(); br++){
    branche b = branches.get(br);
    // pour chacunes des branches contenu dans la liste des branches (« mères »)
    // je la dessine 
    // > voir la fonction "draw" dans le fichier "branche"
    for(int n=0; n<1; n++){
      // accelere le dessin
      b.draw();
    }
  }
  //
  //
  for(int br=0; br < branches.size(); br++){
    branche b = branches.get(br);
    if(b.dead){
      branches.remove(b);
     }
  }
  //
  if(branches.size()==0){
    if(!debug){
        noStroke();
        fill(255);
        typo.draw();
		saveFrame("preview.png");
        endRecord();
        exit();
      }else{
        fill(255);
        //typo.draw();
      }
  }
}

//
//
//
//
//
void mousePressed(){
  // initialise au clic
  background(255);
  setupAllBranches();
  if(debug){
    fill(220);
    typo.draw();
  }
  noFill();
  
}
void SetupTypo(){
  RG.init(this);
  rendu = new RGroup();
  //
  typo = RG.getText(title,"heimatsansbold.ttf",(int)fontSize,CENTER);
  typo.translate(width/2,height/2+fontSize/3);
  typo.draw();
  startingPoint = PointInShape(typo);
}

void setupAllBranches(){
 branches = new ArrayList<branche>();
 letterDrawnd = new Boolean[typo.children.length];
    for(int i=0; i<typo.children.length; i++){
       RShape letter = typo.children[i];
       letterDrawnd[i] = false;
       for(int j=0; j<3; j++){
       RPoint startingPoint = PointInShape(letter);
        //
        float startSpeed = maxSpeed();
        branches.add( new branche(startingPoint, new RPoint(random(-startSpeed,startSpeed),random(-.2*startSpeed,startSpeed)), 0,color(0)));
        //InitBranche(letter);
       }
  }
}

RPoint PointInShape(RShape shape){
  //
  // retourne un point au hasard DANS le corps de la typo
  //
  RPoint p = new RPoint();
  //
  while(!shape.contains(p)){
    p = new RPoint(random(shape.getX(),shape.getX()+shape.getWidth()),random(shape.getY(),shape.getY()+shape.getHeight()));
  }
  return p;
}

//
void InitBranche(RShape s){
    // fonction qui ajoute une nouvelle branche à la liste des branches.
    //
    // ajoute une branche DANS la typo
    //
    branches.add( new branche(PointInShape(s), new RPoint(random(-1,1),random(-1,1)), 0,color(random(128))));
    //
    // ajoute une branche en un centre
    //
    //branches.add( new branche(new RPoint(width/2,height*1/3), new RPoint(random(-1,1),random(.1,1)), 0,color(0,255*random(0,1))));
    //
    // Attention, les valeurs en attributs sont importantes. la class new Branche prend 3 arguments, 2 points, et un niveau)
    // 1/ position initiale
    // 2/ vélocité initiale random entre -1 et 1 en X et .1 et 1 en Y pour avoir une tendance initiale à tomber
    // 3/ niveau 0
    
}
//
void keyPressed(){
  // sauvegarde une frame
  if(key=='s'){
    saveFrame("line-"+timestamp()+".png");
  }
}
long timestamp(){
  return (new Date()).getTime();
}
