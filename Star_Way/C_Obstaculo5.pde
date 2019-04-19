class C_Obstaculo5 {// obstaculo simpels, é um portao rectanguloar que impede o caminho da nave. quando ativo, desloca-se desimpedindo o caminho
  float x, y, lado, alt, osc, orio;
  PShape p1;
  boolean ativo=false;

  C_Obstaculo5(float _x, float _y, float _lado, float _alt) {
    alt=_alt;
    lado=_lado;
    osc=0;
    orio=1;
    x=_x;
    y=_y;
    //criamos o rectangulo com recurso a shape, porque com shape temos facil acesso aos certices do obstaculo. precisamos disto para fazer colisão entre todas as linahs do obstaculo e a linha da nave
    p1=createShape();
    p1.beginShape();
    p1.fill(0, 0, 0, 200);
    p1.stroke(255);
    p1.vertex(0, 0);
    p1.vertex(lado, 0);
    p1.vertex(lado, alt);
    p1.vertex(0, alt);
    p1.endShape(CLOSE);
  }

  void desenha() {
    //colocar o bstaculo no sitio desejado
    pushMatrix();
    translate(x, y+osc);
    shape(p1);
    popMatrix();
    
    //oscila levemente quando não ativo
    if(!ativo){
    if (osc>10) {
      orio=-1;
    } else if (osc<0) {
      orio=1;
    }
    osc+=random(0.05,0.1)*orio;
    }else{//quando se ativa, desloca-se
      orio=-1;
      if(osc>-alt/4*3){
      osc+=1*orio;
      }
    }
  }
  
  void ativo(){//ativa
    ativo=true;
  }

  boolean colisao(PShape nave, float nx, float ny) {//colisao que é explicada na classe meteoro
    PVector vv; //Utilizado para guardar vertices da nave
    PVector ww; //Utilizado para guardar vertices do inimigo
    float x3=0; //Linha do inimigo
    float y3=0;
    float x4=0; //Fim da linha do inimigo
    float y4=0;
    for (int j=0; j<p1.getVertexCount(); j++) {
      PVector w=p1.getVertex(j); //Primeiro vertice da linha atual
      if (j==p1.getVertexCount()- 1) {
        ww=p1.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=p1.getVertex(j+1); //Caso contrario é o vertice atual +1
      }
      x3 = w.x+x; //Linha do inimigo
      y3 = w.y+osc+y;
      x4 = ww.x+x; //Fim da linha do inimigo
      y4 = ww.y+osc+y;
      if (dist(x3, y3, nx, ny)<=alt || dist(x4, y4, nx, ny)<=alt) { //Se a distancia entre o inicio ou o fim da linha do inimigo e o centro da nave estiver dentro destes valores, começa a ser detectada colisão

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
