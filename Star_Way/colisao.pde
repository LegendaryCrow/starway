void verifica_colisao(int tipocolisao) { //verifica colisão entre a nave e diversos obstaculos
  if (tipocolisao==0) { //se o tipo de colisão for 0 (meteoros)
    for (int i=0; i<meteoro.size(); i++) { //percorre todos os meteoros para verificar colisões
      if (meteoro.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
  if (tipocolisao==1) { //se o tipo de colisão for 1 (inimigo1)
    for (int i=0; i<i1.size(); i++) { //percorre todos os inimigos para verificar colisões
      if (i1.get(i).colisaonave(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
  if (tipocolisao==2) { //se o tipo de colisão for 2 (obstaculo1)
    for (int i=0; i<obstaculo1.size(); i++) { //percorre todos os obstaculos para verificar colisões

      if (obstaculo1.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) {
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }


      for (int j=0; j<tiros.size(); j++) {//percorre todos os tiros
        if (tiros.get(j).getsai() && tiros.get(j).getativo() && obstaculo1.get(i).colisaotiro(tiros.get(j).getang(), tiros.get(j).getdist(), tiros.get(j).getx(), tiros.get(j).gety())) {//verifica se algum está dentro do obstaculo
          tiros.get(j).setativo(false);
          if (obstaculo1.get(i).navedentro(nave.getP(), nave.getX(), nave.getY())) { //envia o x e y da nave
            obstaculo1.remove(i);
            j=tiros.size();
          }
        }
      }
    }
  }

  if (tipocolisao==3) {//se o tipo de colisão for 3 (obstaculo2)
    for (int i=0; i<obstaculo2.size(); i++) {
      if (obstaculo2.get(i).geto()>160 && obstaculo2.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
  if (tipocolisao==4) {//se o tipo de colisão for 3 (obstaculo2)
    for (int i=0; i<obstaculo3.size(); i++) {
      if (obstaculo3.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
  if (tipocolisao==5) {//se o tipo de colisão for 3 (obstaculo2)
    for (int i=0; i<obstaculo4.size(); i++) {
      if (obstaculo4.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
  if (tipocolisao==6) {//se o tipo de colisão for 3 (obstaculo2)
    for (int i=0; i<obstaculo5.size(); i++) {
      if (obstaculo5.get(i).colisao(nave.getP(), nave.getX(), nave.getY())) { //envia a shape da nave, o seu x e y
        morto=true;
        ping_morte.reset(nave.getX(), nave.getY(), 0, 0);
        nave.setMorto(mouseX, mouseY);
        sound(3);
      }
    }
  }
}
