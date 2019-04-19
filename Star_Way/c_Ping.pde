class C_Ping {
  //Variaveis
  float x, y, tam, op;
  color c;
  boolean effect=false; //Animaçao

  C_Ping(float _x, float _y, float _tam, float _op, color _c) {
    x=_x;
    y=_y;
    tam=_tam;
    op=_op;
    c=_c;
  }

  void desenha() {
    fill(c, op);
    noStroke();
    if (tam>0)
      ellipse(x, y, tam, tam);
  }

  boolean verifica_colide(float _x, float _y) { //Verifica colisao com o ping
    if (dist(x, y, _x, _y)<50) {
      return true;
    } else return false;
  }

  void aumenta() { //Animaçao de aumentar
    tam++;
    op--;
    if (tam==100 && op==0) {
      tam=0;
      op=100;
    }
  }

  boolean morte() { //Animaçao da morte
    if (tam>=0) {
      op+=8;
      if (effect==false) {
        tam+=3;
      } else {
        tam-=3;
      }
    }
    if (tam>height/77.14*7) effect=!effect;
    return effect;
  }

  void reset(float _x, float _y, float _tam, float _op) { //Resetar variaveis
    x=_x;
    y=_y;
    tam=_tam;
    op=_op;
    effect=false;
  }
}
