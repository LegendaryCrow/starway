class C_Obstaculo2 {
  float x, y, raio, raiot;
  int fase=0, opacidade=0;
  boolean sound=true;

  C_Obstaculo2(float _x, float _y, float _raio) {
    x=_x;
    y=_y;
    raio=_raio;
    raiot=_raio;
  }

  void desenha() {
    fill(0, 0, 0, opacidade/3);
    stroke(125, 125, 125, opacidade/3);
    ellipse(x, y, raiot*2, raiot*2);

    if (opacidade<765) {
      opacidade++;
    }
  }

  void effects() {
    if (fase==1) {
      raiot+=2;
    } else if (fase==2) {
      raiot-=2;
    }
  }


  float getx() {
    return x;
  }
  float gety() {
    return y;
  }
  float getraiot() {
    return raiot;
  }
  float geto() {
    return opacidade;
  }
  void setx(float _x) {
    x=_x;
  }
  void sety(float _y) {
    y=_y;
  }



  boolean ativa_effects(float _x, float _y) {
    if (fase==0 && dist(_x, _y, x, y)<=raio*2) {
      sound(7);
      fase=1;
    } else if (fase==1 && raiot>=raio*2) {
      fase=2;
    } else if (fase==2 && raiot<=2) {
      return true;
    }
    return false;
  }

  boolean colisao(PShape nave, float nx, float ny) {
    PVector v;
    for (int i=0; i<nave.getVertexCount(); i++) { //Percorre os vertices todos da nave
      v=nave.getVertex(i); //Primeiro vertice da linha atual

      if (dist(x, y, cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+nx, sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+ny)<raiot) {
        return true;
      }
    }
    return false;
  }
}
