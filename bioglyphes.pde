import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
//
String title = "R";
RShape typo;
RGroup rendu;
RPoint o = new RPoint(0,0); // origine du plan
//
RPoint startingPoint;
//
ArrayList<branche> branches = new ArrayList<branche>();
//
int drawingCount = 0;
//
void setup(){
  size(1000,1000);
  noFill();
  //
  SetupTypo();
  //
  mousePressed();
}
//
void draw(){
  //
  for(branche b:branches){
    // pour chacunes des branches contenu dans la liste des branches (« mères »)
    // je la dessine 
    // > voir la fonction "draw" dans le fichier "branche"
    b.draw();
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
}
void SetupTypo(){
  RG.init(this);
  rendu = new RGroup();
  //
  typo = RG.getText(title,"heimatsansregular.ttf",800,CENTER);
  typo.translate(width/2,height/2+300);
  typo.draw();
  startingPoint = PointInTypo();
}
void setupAllBranches(){
 branches = new ArrayList<branche>();
    for(int i=0; i<20; i++){
    InitBranche();
  }
}

RPoint PointInTypo(){
  //
  // retourne un point au hasard DANS le corps de la typo
  //
  RPoint p = new RPoint();
  while(!typo.contains(p)){
    p = new RPoint(random(0,width),random(0,height));
  }
  return p;
}

//
void InitBranche(){
    // fonction qui ajoute une nouvelle branche à la liste des branches.
    //
    // ajoute une branche DANS la typo
    branches.add( new branche(PointInTypo(), new RPoint(random(-1,1),random(-.2,1)), 0,color(0)));
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
    saveFrame("frame#####.png");
    RSVG svg = new RSVG();
    svg.fromGroup(rendu);
    rendu.setStroke(true);
    rendu.setStrokeWeight(4);
    rendu.setStroke(0x000000);
    println(rendu.elements.length);
    svg.saveGroup("rendu"+frameCount+".svg",rendu);
    //String xml = svg
  }
}
