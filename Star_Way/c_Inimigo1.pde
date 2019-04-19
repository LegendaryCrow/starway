class c_Inimigo1 {// objectos voadores que preseguem a nave tentando destruir a mesma com impacto. colidem uns com os outros, nao morrendo mas perdendo velocidade
  //x, y, angulo em relacao ao rato, velocidade e velocidade maxima da nave
  float x, y, ang, vel, opacidade=255;
  //pontos de vida
  int vida=1;
  //Está perto de um aliado
  boolean pertodoamigo=false;
  PShape p;

  c_Inimigo1(int _vida, float _vel, float _opac) {
    //Numero de vidas dos inimigos
    vida=_vida;
    //Velocidade dos inimigos
    vel=_vel;
    //Opacidade dos inimigos
    opacidade=_opac;
    //Posição dos inimigos
    x=random(width);
    if (random(1)<0.5) {
      y=-height/10;
    } else {
      y=height+height/10;
    }
    vel=3;
    //criação de todos os pontos da nave, em torno de um ponto central (0,0)
    p = createShape();
    p.beginShape();
    p.fill(60, 70, 50, opacidade);
    p.noStroke();
    p.vertex(-height/50, height/50);
    p.vertex(height/50, height/50);
    p.vertex(height/35, 0);
    p.vertex(height/50, -height/50);
    p.vertex(-height/50, -height/50);
    p.vertex(-height/35, 0);
    p.endShape(CLOSE);
  }

  void desenha() {
    shapeMode(CORNER);
    //para mover a nave, "empurramos" a mesma para uma matriz diferente, que vai realizar uma translação.
    //a matriz tem a nave no seu centro (0,0)
    pushMatrix();
    translate(x, y);
    shape(p, 0, 0);
    popMatrix();
    fill(90, 160, 70, opacidade);
    stroke(200, 200, 200, opacidade);
    ellipse(x, y, height/50, height/50);
  }

  void move(float navex, float navey) {//movimenta a nave
    ang=atan2(navey-y, navex-x);  //o angulo de movimento da nave é igual ao angulo entre o cursor e a nave
    if (pertodoamigo) {
      ang+=random(-PI/2, PI/2);
    }
    //a posição x e y da nave incrementa na direção do cursor do rato consoante a velocidade atual
    x=cos(ang)*vel+x;
    y=sin(ang)*vel+y;
    pertodoamigo=false;
  }

  void set_posicao(float _x, float _y) {
    x=_x;
    y=_y;
  }


  void set_velocidade(float _vel) {
    vel=_vel;
  }

  boolean pertodoamigo(float xamigo, float yamigo) {
    //Verifica se está perto dos aliados
    if (dist(x, y, xamigo, yamigo)<height/10) {
      return true;
    } else {
      return false;
    }
  }

  boolean colisaonave(PShape nave, float nx, float ny) {
    PVector vv; //Utilizado para guardar vertices da nave
    PVector ww; //Utilizado para guardar vertices do inimigo
    float x3=0; //Linha do inimigo
    float y3=0;
    float x4=0; //Fim da linha do inimigo
    float y4=0;
    for (int j=0; j<p.getVertexCount(); j++) {
      PVector w=p.getVertex(j); //Primeiro vertice da linha atual
      if (j==p.getVertexCount()- 1) {
        ww=p.getVertex(0); //Se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=p.getVertex(j+1); //Caso contrario é o vertice atual +1
      }
      x3 = w.x+x; //Linha do inimigo
      y3 = w.y+y;
      x4 = ww.x+x; //Fim da linha do inimigo
      y4 = ww.y+y;
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

  boolean colisaotiro(float ang, float dist, float tx, float ty) {
    //Verifica se colidiram com os tiros
    if (dist(x, y, cos(ang)*dist+tx, sin(ang)*dist+ty)<height/35) {
      return true;
    } else {
      return false;
    }
  }

  void menosvida() {
    //Retira vidas
    vida--;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
  int getvida() {
    return vida;
  }
  void setperto(boolean stp) {
    pertodoamigo=stp;
  }
}
