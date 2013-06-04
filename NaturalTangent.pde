RPoint NaturalTangent(RPoint sourcePoint){
  //
  // largeur de la zone de sensibilité
  int AREA_SIZE = 60;
  //
  //ellipse(sourcePoint.x,sourcePoint.y,AREA_SIZE*2,AREA_SIZE*2);
  //
  RPoint tangentMedium = new RPoint();
  //
  for(float c=0; c<1; c+=.005){
    // récupère les points de la shape ici chaque 0.5%
    //
    RPoint p = typo.getPoint(c);
    // calcule la distance entre la souris et le point
    float dist = sourcePoint.dist(p);
    //
    // si le point est dans la zone de sensibilité
    if(dist<AREA_SIZE){
      // je récupère sa tangente 
      RPoint t = typo.getTangent(c);
      // je lui applique une puissance pour filtrer sa distance proche/loin
      t.scale(pow((AREA_SIZE-dist)/AREA_SIZE,2));
      // variante avec mouse pressed
      if(!mousePressed){
        // le cas normal donc, je fait pointer les tangeante, vers le bas
        if(t.y<0){
          //t.rotate(PI);
        }
      }
      // j'ajoute la tengeante à la moyenne
      // add est ici une fontion géométrique (voir RPoint->add)
     tangentMedium.add(t);
     //
     // j'affiche les tangeantes locales
    //line(p.x,p.y,p.x+t.x,p.y+t.y);
    }

  }
   //
   if(tangentMedium.dist(o)>AREA_SIZE){
     // si la tengeante est trop grande, je la normalise
     tangentMedium.normalize();
     tangentMedium.scale(AREA_SIZE);
   }
   //line(sourcePoint.x-tangentMedium.x,sourcePoint.y-tangentMedium.y,sourcePoint.x+tangentMedium.x,sourcePoint.y+tangentMedium.y);
  return tangentMedium;
}
