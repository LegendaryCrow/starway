class C_Nave {
  //x, y, angulo em relacao ao rato, velocidade e velocidade maxima da nave
  float x, y, ang, aux, vel, velmax, aceleracao=0.0001, size=height/30, sizet=height/30;
  float x_morto, y_morto;
  //boost activo ou nao
  boolean boost=false;
  PShape p;
  boolean sound1=true;

  C_Nave() {
    x=width/2;
    y=height/2;
    vel=0;
    //velociade maxima da nave
    velmax=15;
    //criação de todos os pontos da nave, em torno de um ponto central (0,0)
    p = createShape();
    p.beginShape();
    p.fill(125);
    p.noStroke();
    p.vertex(0, -height/31.76);
    p.vertex(-height/77.14, 0);
    p.vertex(-height/40, height/77.14);
    p.vertex(-height/31.76, height/40);
    p.vertex(-height/77.14, height/45);
    p.vertex(-height/54, height/31.76);
    p.vertex(-height/154.28, height/40);
    p.vertex(-height/270, height/31.76);
    p.vertex(height/270, height/31.76);
    p.vertex(height/154.28, height/40);
    p.vertex(height/54, height/31.76);
    p.vertex(height/77.14, height/45);
    p.vertex(height/31.76, height/40);
    p.vertex(height/40, height/77.14);
    p.vertex(height/77.14, 0);
    p.endShape(CLOSE);

  }

  void desenha(boolean desenha) {
    if (desenha) {
      shapeMode(CORNER);
      //para mover a nave, "empurramos" a mesma para uma matriz diferente, que vai realizar uma translação.
      //a matriz tem a nave no seu centro (0,0)
      pushMatrix();
      translate(x, y);
      //a matriz está sempre virada para a posição do rato com uma rotação
      if (morto) {//enquanto estiver viva
        rotate(PI/2+atan2(y_morto-y, x_morto-x));
      } else {
        rotate(PI/2+atan2(mouseY-y, mouseX-x));
      }
      shape(p, 0, 0, sizet, sizet);
      popMatrix();
    }
  }

  void move() {//movimenta a nave
    //a posição x e y da nave incrementa na direção do cursor do rato consoante a velocidade atual
    x=cos(ang)*vel+x;
    y=sin(ang)*vel+y;

    if (boost && dist(mouseX, mouseY, x, y)>80) {//se a nave estiver a mais de 80px do cursor e o boost estiver ativo
      if (vel<velmax) {//se a velocidade atual for inferior à maxima
        vel+=aceleracao*(dist(mouseX, mouseY, x, y));//a velocidade aumenta. quanto maior a distancia entre o cursor e a nave, maior é o incremento
      }
      ang=atan2(mouseY-y, mouseX-x);  //o angulo de movimento da nave é igual ao angulo entre o cursor e a nave
    } else {//se a nave estiver a menos de 80px do cursor ou o boost estiver desativado
      if (vel>0.0) {//se velocidade maior que 0
        vel-=0.01;//velocidade reduz
        if (dist(mouseX, mouseY, x, y)<80) {//se a distancia entre a nave e o cursor for inferior a 80
          vel-=vel/9;//velocidade reduz muito
        }
      }
      if (vel<0.00001) {//para eliminar velocidade "residual" que possa restar
        vel=0;
      }
    }
  }

  boolean moveP(float _x, float _y) {
    //a posição x e y da nave incrementa na direção do cursor do rato consoante a velocidade atual
    x=cos(ang)*vel+x;
    y=sin(ang)*vel+y;
    ang=atan2(_y-y, _x-x);
    if (vel<=velmax)
      vel+=0.1;
    if (dist(_x, _y, x, y)>10) {//se a nave estiver a mais de 80px do cursor e o boost estiver ativo
      //o angulo de movimento da nave é igual ao angulo entre o cursor e a nave
      return false;
    } else {
      return true;
    }
  }

  void set_posicao(float _x, float _y) {
    x=_x;
    y=_y;
  }

  void set_velocidade(float _vel) {
    vel=_vel;
  }

  PShape getP() {
    return p;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getDim() {
    return sizet;
  }

  void setMorto(float mx, float my) {
    x_morto=mx;
    y_morto=my;
  }

  void diminui() {
    if (sizet>0) {
      sizet-=0.3;
    }
    if (sound1) {
      sound(6);
      sound1=false;
    }
  }
  void sound1_true() {
    sound1=true;
  }

  void resetDim() {
    sizet=size;
  }

  void setUpgrades(int n_velmax, int n_aceleracao) {
    velmax=15+n_velmax*2;
    aceleracao=(n_aceleracao+1)*0.0001;
  }
}
