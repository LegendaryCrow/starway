void menu() { //Desenha o menu principal
  image(menu_fundo, 0, 0);
  //Desenha a chuva de meteoros
  for (int i=0; i<chuva_meteoro.size(); i++) {
    if (chuva_meteoro.get(i).getY()>height+height/10) { //Remove os meteoros quando chegam ao fundo da janela e gera um novo
      chuva_meteoro.remove(i);
      gera_chuva_meteoro();
    }
    chuva_meteoro.get(i).desenha();
    chuva_meteoro.get(i).move_random(); // Move os meteoros de forma aleatoria
  }
  //Desenha o numero de fps
  fps();
  // Desenha o dinheiro atual e a animaçao da moeda
  sprite_coin.desenha();
  sprite_coin.sprite();
  inter.get(1).desenha();
  //Desenha todos os textos do menu
  for (int i=0; i<menu_texto.size(); i++) {
    menu_texto.get(i).desenha();
  }
}

void pausa() { //Desenha o texto da pausa
  inter.get(0).desenha();
  inter.get(2).desenha();
  inter.get(3).desenha();
}
