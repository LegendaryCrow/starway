class C_Portal {
  //Variaveis
  float x, y, c, l, dim, ang;
  PImage portal;
  boolean sound=true; //Efeito sonoro

  C_Portal(String nome, float _x, float _y) {
    portal=loadImage(nome);
    x=_x;
    y=_y;
    portal.resize(int(width/15), int(portal.height*width/15/portal.width));
    c=portal.width;
    l=portal.height;
    ang=0;
    dim=0;
  }

  void desenha() {
    pushMatrix();
    translate(x, y);
    rotate(ang);
    image(portal, -c/2*dim, -l/2*dim, c*dim, l*dim);
    popMatrix();
    if (sound==true) { //Faz o efeito sonoro caso true
      sound(5);
      sound=false;
    }
  }

  void move() { //Animaçao da rotaçao da imagem
    ang+=PI/50;
    if (ang>=TWO_PI) {
      ang=0;
    }
  }

  void nasce() { //Animaçao do nascimento do portal
    if (dim<1)
      dim+=0.02;
  }

  boolean colide(float _x, float _y) { //Verifica a colisao com o portal
    if (dist(x, y, _x, _y)<c) {
      return true;
    } else {
      return false;
    }
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getC() {
    return c;
  }

  float getL() {
    return l;
  }

  float getDim() {
    return dim;
  }

  void mudaPos(float _x, float _y) { //Altera a posicao do portal
    x=_x;
    y=_y;
  }

  void sound_true() { //Reativa o efeito sonoro
    sound=true;
  }
}
