class C_Tiro {
  //x,y,angulo de direção,distancia em relacao à sua posicao inicial e velocidade
  float x, y, ang, dist, vel;
  //determinar se o tiro está ativo e se já saiu
  boolean ativo=true, sai=false;

  C_Tiro() {
    rectMode(CENTER);
    //velocidade dos tiros é 15
    vel=20;
    //distancia inicial é 0, portanto o tiro está dentro da nave
    dist=0;
  }

  void desenha(float _x, float _y) {//recebe o x e o y da nave
    if (ativo) {//se o tiro estiver ativo
      if (!sai) {//se ainda não tiver saido
        ang=atan2(mouseY-_y, mouseX-_x);//define o angulo do moviemnto do tiro
        //define o x e o y do tiro
        x=_x;
        y=_y;
      }
      if (sai) {//se ja tiver saido
        dist+=vel;//a distancia do tiro em relação à sua posição inicial aumenta
      }
      if (cos(ang)*dist+x <0 || cos(ang)*dist+x >width || sin(ang)*dist+y < 0 || sin(ang)*dist+y >height) {//se o tiro sair do ecra
        ativo = false; //deixa de estar ativo
      }
      //desenha o tiro
      stroke(255);
      strokeWeight(3);
      line(cos(ang)*dist+x, sin(ang)*dist+y, cos(ang)*(dist+height/100)+x, sin(ang)*(dist+height/100)+y);
      strokeWeight(1);
    } else {//se o tiro não estiver ativo
      // o tiro volta para dentro da nave, guardando a proxima direção de movimento
      ang=atan2(mouseY-_y, mouseX-_x);
      x=_x;
      y=_y;
    }
  }

  void dispara() {//dispara o tiro
    if (ativo) {//se estiver ativo
      sai=true;//sai da nave
    }
  } 
  boolean getsai() {
    return sai;
  }

  boolean getativo() {
    return ativo;
  }

  float getx() {
    return x;
  }

  float gety() {
    return y;
  }

  float getang() {
    return ang;
  }

  float getdist() {
    return dist;
  }

  void setx(float _x) {
    x=_x;
  }

  void sety(float _y) {
    y=_y;
  }

  void setdist(float _dist) {
    dist=_dist;
  }

  void setativo(boolean _ativo) {
    ativo=_ativo;
  }

  void setsai(boolean _sai) {
    sai=_sai;
  }
}
