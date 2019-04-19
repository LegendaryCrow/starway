class C_Meteoro {
  float x, y;
  PShape meteoro;
  //recebe posicao x e y, tamanho, numero de lados e cor do meteoro
  C_Meteoro(float _x, float _y, float _size, float _lados, color _c) {
    x=_x;
    y=_y;
    float angle = TWO_PI / _lados;
    meteoro=createShape();
    meteoro.beginShape();
    meteoro.noStroke();
    meteoro.fill(_c);
    //cria a shape com os varios vertices
    for (float a=0; a<TWO_PI; a+=angle) {
      float sx=_size+cos(a)*_size;
      float sy=_size+sin(a)*_size;
      meteoro.vertex(sx, sy);
    }
    meteoro.endShape(CLOSE);
  }

  void desenha() {
    shapeMode(CORNER);
    shape(meteoro, x, y);
  }
  //colisão entre o meteoro e a nave
  //recebe a shape da nave, assim como a sua posição x e y
  boolean colisao(PShape nave, float nx, float ny) {
    //a colisão funciona da seguinte forma:
    //pegamos no primeiro e segundo certice do meteoro, ou seja, uma linha do mesmo
    //se a nave estiver a uma certa distania do mesmo, começa a deteção de colisão
    //pegamos no primeiro e segundo vertice da nave, ou seja, uma linha da mesma
    //utilizamos formulas para detetar colisão entre as duas linhas
    //pegamos no segundo e terceiro ponto da nave (...)
    //até chegar à ultima linha da nave
    //se ainda não tiver sido detetada colisão passamos à segunda linha do meteoro e repetimos o processo

    PVector vv; //utilizado para guardar vertices da nave
    PVector ww; //utilizado para guardar vertices do meteoro
    float x3=0; // linha do meteoro
    float y3=0;
    float x4=0; //fim da linha do meteoro
    float y4=0;

    for (int j=0; j<meteoro.getVertexCount(); j++) {
      PVector w=meteoro.getVertex(j);//primeiro vertice da linha atual
      if (j==meteoro.getVertexCount()- 1) {
        ww=meteoro.getVertex(0);//se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
      } else {
        ww=meteoro.getVertex(j+1);//caso contrario é o vertice atual +1
      }

      x3 = w.x+x;  // linha do meteoro
      y3 = w.y+y;
      x4 = ww.x+x;  //fim da linha do meteoro
      y4 = ww.y+y;
      if (dist(x3, y3, nx, ny)<=height/31 || dist(x4, y4, nx, ny)<=height/20) {//se a distancia entre o inicio ou o fim da linha do meteoro e o centro da nave estiver dentro destes valores, começa a ser detectada colisão

        for (int i=0; i<nave.getVertexCount(); i++) {//percorre os vertices todos da nave

          PVector v=nave.getVertex(i);//primeiro vertice da linha atual
          if (i==nave.getVertexCount()- 1) {
            vv=nave.getVertex(0);//se estivermos na ultima linha da nave, o fim dessa linha é o primeiro vertice
          } else {
            vv=nave.getVertex(i+1);//caso contrario é o vertice atual +1
          }

          float x1 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+nx;    // linha da nave
          float y1 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(v.y), -(v.x))-PI/2)*dist(0, 0, v.x, v.y)+ny;
          float x2 = cos(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+nx;   // fim da linha da nave
          float y2 = sin(atan2(mouseY-ny, mouseX-nx)+atan2(-(vv.y), -(vv.x))-PI/2)*dist(0, 0, vv.x, vv.y)+ny;

          /*strokeWeight(1);    //desenha linhas de colisão azuis á volta da nave e dos meteoros
           line(x1, y1, x2, y2);
           line(x3, y3, x4, y4);*/

          //calcula a distancia até ao ponto de interceção mais proximo
          float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
          float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

          // se uA e uB estiverem entre 0 e 1, as linhas estão a colidir
          if (uA > 0 && uA < 1 && uB > 0 && uB < 1) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void move_random() { //Faz o meteoros se moverem aleatoriamente
    x+=random(2);
    y+=random(2);
  }

  float getY() {
    return y;
  }

  void reset_pos(float _x, float _y) {
    y=_y;
    x=_x;
  }
}
