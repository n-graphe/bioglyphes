class branche {
  //
  //
  //
  // état de "vie ou de mort" de la branche
  boolean dead = false;
  // étape constitutive de la branche
  int t=0;
  // durée de vie (en étapes) de la branche
  int lifeTime = 40;
  // durée de vie (entre 0 et 1) de la branche (time = t/lifetime)
  float time = 0;
  //
  // niveau de la branche, dans la hiérarchie. les branches parentes, initiale ont le niveau 0. leurs enfants 1, en ainsi de suite
  int level = 0;
  // le niveau maximum de récursion, 4 = arriere-grand-mère
  int MAX_LEVEL = 6;
  // position de la branche
  RPoint position = new RPoint(0, 0);
  // velocité, direction, cap, vitesse instantanée, de la branche
  RPoint velocity = new RPoint(0, 0);
  //
  // grappe de points qui seront les points à dessiner, à relier.
  ArrayList<RPoint> cluster = new ArrayList();
  //
  // misc -> miscellaneous -> du latin miscellaneus, « choses mêlées »
  // c’est une constante de "mélange" que j'utilise pour controller l'aspect chaotique ou non, de la vélocité
  float misc = .04;
  // variable qui permet de modifier le niveau de chaos dans la forme de la branche
  float miscLevel = 0;
  //
  float maxSpeed = 2;
  //
  // angle de rotation en cas de sortie de la lettre;
  float returnOutAngle = PI/2;
  float retourRandom = 1;
  boolean inside = true;
  // 
  float strokeWeight = 0;
  //
  // liste des branches DIRECTEMENT enfantes de la branche actuelle.
  ArrayList<branche> sub = new ArrayList<branche>();
  //
  //
  //
  color c;
  //
  branche(RPoint start, RPoint startV, int l, color _c) {
    //
    //
    level = l;
    c = _c;
    //
    // établie une durée de vie aléatoire pour chaque branche.
    lifeTime = (int) random(10, 60);
    //
    position = new RPoint(start.x, start.y); // initialise la position initiale
    cluster.add(new RPoint(position));
    velocity = new RPoint(startV.x, startV.y); // initialise la vélocité initiale
    miscLevel = misc*(2+(MAX_LEVEL-level)*(level+1)); // initialise le niveau de "mélange" de la branche, 
    // en fonction de son niveau dans la hiérarchie
    // plus une branche est enfante, plus elle est chaotique
    //
    strokeWeight = fontSize/400*(MAX_LEVEL-level+2);
    //
    maxSpeed = (MAX_LEVEL-level+4)*fontSize/800;
    //
    returnOutAngle = ((random(1)<.5)?-1:1)*PI/random(6,24);
    retourRandom = random(1,30);
    // angle de rotation en cas de sortie de la lettre;
  }
  boolean draw() {
    // fonction de dessin, renvoie sont état boolean de "vie"
    update();   
    return dead;
  }
  void update() {
    //
    // fonction principale de la branche
    //
    //
    if (!dead) {
      // si la branche n'est pas morte
      //
      //
      // si la branche à des enfants
      if (sub.size()>0) {
        //
        // va tester si toutes ses branches enfantes sont mortes
        boolean allDead = true;
        //
        for (branche b:sub) {
          // je teste la vie des sous branche en lanceant un draw sur celle-ci,
          // draw renvoit le "dead" = true, si elle est morte. 
          // j'ai un peu "compilé" 3 actions en une, ce qui ne facilite pas la lecture.
          // 
          allDead &= b.draw();
          //
          // plus "lisible" peut-être…
          // c'est équivalent à :
          //
          // b.draw(); // dessine la lettre
          // allDead = allDead & b.dead; // effectue l'opération booleene
          //
        }
        if (allDead) {
          // si toutes les branches enfantes sont mortes, alors je considère que la branche est morte.
          // et je lance le Kill !
          Kill();
        }
        // si la branche est vivante
      }
      else {
        // j'ajoute un au compteur
        t++;
        // je calcule le time (entre 0 et 1)
        time = (float)t/lifeTime;
        //
        // je modifie la vélocité, en fonction du degrée de miscellaneus
        if (velocity.dist(o)>(maxSpeed)) {
          velocity.normalize();
          velocity.scale(maxSpeed);
        } 
        velocity.add(new RPoint(random(-miscLevel, miscLevel), random(-miscLevel*.2*(MAX_LEVEL-level)/MAX_LEVEL, miscLevel*level/MAX_LEVEL)));
        //
        //     
        // operations concernant le teste de typo, je les ai laissé en commentaires
        /*RPoint destination = new RPoint(position);
         //
         destination.add(velocity);
         if(inside && !typo.contains(destination)){
         while(!typo.contains(destination) && !(random(1)<.05)){
         destination = new RPoint(position);
         velocity = new RPoint(random(-1,1),random(-.8,1));
         destination.add(velocity);
         }
         }*/
        //
        RPoint destination = new RPoint(position);
        //
        inside = typo.contains(destination);
        if ( !inside ) {
          //velocity.rotate(-PI);
          //velocity.rotate(random(-PI/4,PI/4));
          velocity.rotate(returnOutAngle/random(1,retourRandom));
          //velocity.scale(.999);
        }
        //
        // ajoute la vélocité (le déplacement, c'est un vecteur) à la position.
        // add est une opération du plan de "translation"
        // ça équivaut à 
        // position.x += velocity.x; 
        // position.y += velocity.y; 
        position.add(velocity);
        // test de typo
        //inside = typo.contains(position);
        //
        // ajoute la nouvelle position au cluster
        cluster.add(new RPoint(position));
        // avant je dessinait des éllipses au lieu de l'ajouter au cluster
        ///*
        if(debug){
          noStroke();
          fill(c);
          ellipse(position.x, position.y, strokeWeight, strokeWeight);
        }
        //*/
        //
        // si le t a dépassé la durée de vie
        if (t>lifeTime) {
          // si le niveau n'est pas le maximum possible
          if (level<MAX_LEVEL) {
            // je dessine le cluster
            if(!debug){
              DrawCluster();
            }
            // j'ajoute 2 branches enfantes (j'ai fait une boucle for, car on pourrait imaginer ajouter plus de branches)
            for (int q=0; q<=1; q++) {
              // ajoute UNE sous-branche à la liste
              sub.add(new branche(position, velocity, level+1, c));
            }
          }
          else {
            // si on a atteint le niveau maximum je Kill !
            // 
            Kill();
          }
        }
      }
    }
  }
  //
  //
  //
  void DrawCluster() {
    float sW = pow((MAX_LEVEL-level),2)*fontSize/600;
    // dessine les deux lignes
    strokeCap(SQUARE);
    DrawClusterWeight(sW*1.2,color(0));
    strokeCap(ROUND);
    DrawClusterWeight(sW, color(255));
  }

  void DrawClusterWeight(float n, color c) {
    // dessine une ligne à partir des points du cluster
    stroke(c);
    strokeWeight(n);
    beginShape();
    RGroup group = new RGroup();
    RContour contour = new RContour();
    contour.setStroke(true);
    contour.setStroke("#000000");
    contour.setStrokeWeight(n);
   contour.addClose();
   for (RPoint p:cluster) {
      vertex(p.x,p.y);
      //contour.addPoint(p.x, p.y);
    }
    //group.addElement(contour);
    contour.addClose();
    //contour.draw();
    rendu.addElement(contour);
    endShape();
  }

  void Kill() {
    dead = true;
  }
}

