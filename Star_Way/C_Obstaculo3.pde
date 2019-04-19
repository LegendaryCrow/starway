class C_Obstaculo3 {//obstaculo indestrutivel, dois triangulos com espaço entre si, oscilam levamente em repouso e deslocam-se rapidamente um contra o outro quando a nave se aproxima
  float x, y, dist, lado, accel, oria, osc, orio;
  PShape q1, q2;
  boolean ativo=false;

  C_Obstaculo3(float _x, float _y, float _lado, float _dist) {
    dist=_dist;
    lado=_lado;
    accel=8;
    osc=0;
    orio=1;
    x=_x;
    y=_y;
    //um triangulo
    q1=createShape();
    q1.beginShape();
    q1.fill(0, 0, 0, 200);
    q1.stroke(255);
    q1.vertex(0, 0);
    q1.vertex(lado, 0);
    q1.vertex(lado/2, lado);
    q1.endShape(CLOSE);
    //outro triangulo
    q2=createShape();
    q2.beginShape();
    q2.fill(0, 0, 0, 200);
    q2.stroke(255);
    q2.vertex(lado/2, dist);
    q2.vertex(lado, dist+lado);
    q2.vertex(0, dist+lado);
    q2.endShape(CLOSE);
  }

  void desenha() {
    //matrix om translate para colocar o obstaculo no sitio desejado
    pushMatrix();
    translate(x, y+osc);
    shape(q1);
    popMatrix();
    pushMatrix();
    translate(x, y-osc);
    shape(q2);
    popMatrix();

    //se não estiver ativo, apenas oscila levemente dentro de um certo limite
    if (!ativo) {
      if (osc>10) {
        orio=-1;
      }else if(osc<0){
        orio=1;
      }
      osc+=dist/1000*orio;
    } else {//caso contrario, desloca-se rapidaemnte, colidindo e tentando impedir a passagem da nave
      if(osc<dist/2){
      osc+=dist/50;
      }else{
        ativo=false;
      }
    }
  }
  boolean prox(float nx, float ny){//recebe coordenadas da nave
    if(ny>y+osc && ny<y+dist-osc && nx>x-dist/4 && nx<x+dist/4){//deteta proximidade da nave
     return true; 
    }
    return false;
  }
  void ativo(){//ativa o obstaculo
   ativo=true; 
  }
  
  boolean colisao(PShape nave, float nx, float ny) {//colisao que é explicada na classe meteoro
    PVector vv; //Utilizado para guardar vertices da nave
    PVector ww; //Utilizado para guardar vertices do inimigo
    float x3=0; //Linha do inimigo
    float y3=0;
    float x4=0; //Fim da linha do inimigo
    float y4=0;
    for (int j=0; j<q1.getVertexCount(); j++) {
      PVector w=q1.getVertex(j); //Primeiro vertice da linha atual
      if (j==q1.getVertexCount()- 1) {
        ww=q1.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=q1.getVertex(j+1); //Caso contrario é o vertice atual +1
      }
      x3 = w.x+x; //Linha do inimigo
      y3 = w.y+osc+y;
      x4 = ww.x+x; //Fim da linha do inimigo
      y4 = ww.y+osc+y;
      if (dist(x3, y3, nx, ny)<=height/31 || dist(x4, y4, nx, ny)<=height/20) { //Se a distancia entre o inicio ou o fim da linha do inimigo e o centro da nave estiver dentro destes valores, começa a ser detectada colisão

        for (int i=0; i<nave.getVertexCount(); i++) { //Percorre os vertices todos da nave

          PVector v=nave.getVertex(i); //Primeiro vertice da linha atual
          if (i==nave.getVertexCount()- 1) {
            vv=nave.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
          } else {
            vv=nave.getVertex(i+1); //Caso contrario é o vertice atual +1
          }

          float x1 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+nx; //Linha da nave
          float y1 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+ny;
          float x2 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+nx; //Fim da linha da nave
          float y2 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+ny;

          /*strokeWeight(1); //Desenha linhas de colisão azuis á volta da nave e dos inimigo
           line(x1, y1, x2, y2);
           line(x3, y3, x4, y4);*/

          //Calcula a distancia até ao ponto de interceção mais proximo
          float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
          float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

          //Se uA e uB estiverem entre 0 e 1, as linhas estão a colidir
          if (uA > 0 && uA < 1 && uB > 0 && uB < 1) {
            return true;
          }
        }
      }
    }
    for (int j=0; j<q2.getVertexCount(); j++) {
      PVector w=q2.getVertex(j); //Primeiro vertice da linha atual
      if (j==q2.getVertexCount()- 1) {
        ww=q2.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=q2.getVertex(j+1); //Caso contrario é o vertice atual +1
      }
      x3 = w.x+x; //Linha do inimigo
      y3 = w.y-osc+y;
      x4 = ww.x+x; //Fim da linha do inimigo
      y4 = ww.y-osc+y;
      if (dist(x3, y3, nx, ny)<=height/31 || dist(x4, y4, nx, ny)<=height/20) { //Se a distancia entre o inicio ou o fim da linha do inimigo e o centro da nave estiver dentro destes valores, começa a ser detectada colisão

        for (int i=0; i<nave.getVertexCount(); i++) { //Percorre os vertices todos da nave

          PVector v=nave.getVertex(i); //Primeiro vertice da linha atual
          if (i==nave.getVertexCount()- 1) {
            vv=nave.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
          } else {
            vv=nave.getVertex(i+1); //Caso contrario é o vertice atual +1
          }

          float x1 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+nx; //Linha da nave
          float y1 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+ny;
          float x2 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+nx; //Fim da linha da nave
          float y2 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+ny;

          /*strokeWeight(1); //Desenha linhas de colisão azuis á volta da nave e dos inimigo
           line(x1, y1, x2, y2);
           line(x3, y3, x4, y4);*/

          //Calcula a distancia até ao ponto de interceção mais proximo
          float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
          float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

          //Se uA e uB estiverem entre 0 e 1, as linhas estão a colidir
          if (uA > 0 && uA < 1 && uB > 0 && uB < 1) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
