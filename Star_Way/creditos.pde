void creditos() {
  image(menu_fundo, 0, 0);
  //Desenhar texto da pontuação  
  for (int i=0; i<creditos_texto.size(); i++) {
    creditos_texto.get(i).desenha();
  }
}

void effects_creditos_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  if (creditos_texto.get(5).mouseHover(mouseX, mouseY)) {
    link("https://paypal.me/RealStarWay"); //Abrir link
  }
  if (creditos_texto.get(6).mouseHover(mouseX, mouseY)) { //Dá reset a todo o jogo quando se acaba o jogo
    opcao=0;
    //Reset do gold
    gold=0;
    //Reset dos upgrades
    upgrade_velocidade=0;
    upgrade_recarga=0;
    upgrade_aceleracao=0;
    nave.setUpgrades(upgrade_velocidade, upgrade_aceleracao);
    m_inc=2500+1000*upgrade_recarga;
    //Reescreve textos
    menu_texto.get(2).remake("Continuar", zorque, 69, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 69, conv_width(640), conv_height(480), conv_height(35), true);
    inter.get(1).remake(""+gold, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false);
  }
}
