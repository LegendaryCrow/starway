void morrer() { //Desenho do menu da morte
  rectMode(CENTER);
  if (opacidade<=255) { //Aumenta a opacidade do ecra até ao máximo
    opacidade+=2;
    ping_morte.desenha();
    if (ping_morte.morte() && desenha_nave) desenha_nave=false; //Pára de desenhar a nave após a explosao
  }
  //Desenha um rect por cima do jogo
  fill(0, opacidade);
  noStroke();
  rect(conv_width(640), conv_height(360), width, height);
  if (opacidade>255) { //Caso a opacidade chegue ao máximo desenha o texto
    for (int i=0; i<morte_texto.size(); i++) {
      morte_texto.get(i).desenha();
    }
  }
}

void sair_monitor() { //Mata a nave caso esta saia dos limites do monitor
  if (nave.getX()<-height/30 || nave.getX()>width+height/30 || nave.getY()<-height/30 && nave.getY()>height+height/30) {
    morto=true;
    sound(3);
  }
}
