class C_Obstaculo1 {
  float x, y, raio;
  float comp, alt, ang=0, velrot=PI/40;
  PShape turbina;

  C_Obstaculo1(float _x, float _y, float _raio, float _comp, float _alt) {
    x=_x;
    y=_y;
    raio=_raio;
    comp=_comp;
    alt=_alt;
    velrot=PI/100;

    turbina=createShape();
    turbina.beginShape();
    turbina.fill(0);
    turbina.stroke(255);
    turbina.vertex(-comp, -alt);
    turbina.vertex(comp, -alt);
    turbina.vertex(comp, alt);
    turbina.vertex(-comp, alt);
    turbina.endShape(CLOSE);
  }

  C_Obstaculo1(float _x, float _y, float _raio, float _comp, float _alt, float _velrot) {
    x=_x;
    y=_y;
    raio=_raio;
    comp=_comp;
    alt=_alt;
    velrot=_velrot;


    turbina=createShape();
    turbina.beginShape();
    turbina.fill(0);
    turbina.stroke(255);
    turbina.vertex(-comp, -alt);
    turbina.vertex(comp, -alt);
    turbina.vertex(comp, alt);
    turbina.vertex(-comp, alt);
    turbina.endShape(CLOSE);
  }

  void desenha() {
    noFill();
    strokeWeight(2);
    stroke(255, 0, 0, 150);
    ellipse(x, y, raio, raio);
    fill(0);
    strokeWeight(1);
    stroke(255);
    pushMatrix();
    translate(x, y);
    rotate(ang);
    shape(turbina);
    popMatrix();
    fill(255, 0, 0);
    ellipse(x, y, alt, alt);

    ang+=velrot;
  }

  boolean colisao(PShape nave, float nx, float ny) {
    PVector vv; //Utilizado para guardar vertices da nave
    PVector ww; //Utilizado para guardar vertices do inimigo
    float x3=0; //Linha do inimigo
    float y3=0;
    float x4=0; //Fim da linha do inimigo
    float y4=0;
    for (int j=0; j<turbina.getVertexCount(); j++) {
      PVector w=turbina.getVertex(j); //Primeiro vertice da linha atual
      if (j==turbina.getVertexCount()- 1) {
        ww=turbina.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=turbina.getVertex(j+1); //Caso contrario é o vertice atual +1
      }
      x3 = cos(ang+atan2(-(w.y), -(w.x)))*dist(0, 0, w.x, w.y)+x; //Linha do inimigo
      y3 = sin(ang+atan2(-(w.y), -(w.x)))*dist(0, 0, w.x, w.y)+y;
      x4 = cos(ang+atan2(-(ww.y), -(ww.x)))*dist(0, 0, ww.x, ww.y)+x; //Fim da linha do inimigo
      y4 = sin(ang+atan2(-(ww.y), -(ww.x)))*dist(0, 0, ww.x, ww.y)+y;
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

         /* strokeWeight(1); //Desenha linhas de colisão azuis á volta da nave e dos inimigo
          stroke(0, 0, 255);
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

  boolean navedentro(PShape nave, float nx, float ny) {
    PVector v=nave.getVertex(0);
    if (dist(x, y, cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+nx, sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+ny)<raio) {
      return true;
    } else {
      return false;
    }
  }
  boolean colisaotiro(float ang, float dist, float tx, float ty) {
    if (dist(x, y, cos(ang)*dist+tx, sin(ang)*dist+ty)<=raio) {
      return true;
    } else {
      return false;
    }
  }
}
