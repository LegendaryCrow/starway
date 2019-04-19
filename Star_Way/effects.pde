void effects_menu_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  //Novo Jogo
  if (menu_texto.get(1).mouseHover(mouseX, mouseY)) { //Inicia o jogo e dá reset em todas as variáveis
    timer=millis();
    sound(0);
    opcao=1;
    nivel=0;
    controlo=0;
    reset_nivel(0);
    jogar=true;
    stop_music(0);
    music(1);
    //Reset
    gold=0;
    upgrade_velocidade=0;
    upgrade_recarga=0;
    upgrade_aceleracao=0;
    nave.setUpgrades(upgrade_velocidade, upgrade_aceleracao);
    m_inc=2500+1000*upgrade_recarga;
    menu_texto.get(2).remake("Continuar", zorque, 69, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 69, conv_width(640), conv_height(480), conv_height(35), true);
    inter.get(1).remake(""+gold, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false);

    for (; meteoro.size()!=0; ) { //Remove todos os meteoros do menu
      meteoro.remove(0);
    }
    gera_meteoros(); //Criação dos meteoros
  }
  //Continuar
  else if (nivel!=0 && menu_texto.get(2).mouseHover(mouseX, mouseY)) {
    timer=millis();
    sound(0);
    opcao=1;
    controlo=0;
    reset_nivel(nivel);
    stop_music(0);
    music(1);
    for (; meteoro.size()!=0; ) {
      meteoro.remove(0);
    }
    gera_meteoros();
  }
  //Oficina
  else if (nivel!=0 && menu_texto.get(3).mouseHover(mouseX, mouseY)) {
    sound(0);
    gold_a=gold;
    opcao=2;
  }
  //Sair
  else if (menu_texto.get(4).mouseHover(mouseX, mouseY)) {
    sound(0);
    exit();
  }
}

void effects_dialogos_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  if (opcao==2) {
    if (textos_oficina.get(controlo).verifica_end()==false) {
      textos_oficina.get(controlo).set_pos(textos_oficina.get(controlo).get_tam());
    } else {
      textos_oficina.get(controlo).set_pos(0);
      dialogos_ativos=false;
    }
  } else if (fase==0) {
    if (textos_tutorial.get(pos_dialogo).verifica_end()==false) {
      textos_tutorial.get(pos_dialogo).set_pos(textos_tutorial.get(pos_dialogo).get_tam());
    } else {
      textos_tutorial.get(pos_dialogo).set_pos(0);
      pos_dialogo++;
    }
  } else if (fase==1) {
    if (textos_pontuacao.get(pos_dialogo).verifica_end()==false) {
      textos_pontuacao.get(pos_dialogo).set_pos(textos_pontuacao.get(pos_dialogo).get_tam());
    } else {
      textos_pontuacao.get(pos_dialogo).set_pos(0);
      pos_dialogo++;
    }
  }
}

void effects_pontuacao_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  //Continuar
  if (pontuacao_texto.get(5).mouseHover(mouseX, mouseY)) {
    sound(0);
    stop_music(2);
    nivel++;
    pontuacao=false;
    opcao=1;
  } else
    //Menu
    if (pontuacao_texto.get(6).mouseHover(mouseX, mouseY)) {
      sound(0);
      stop_music(2);
      nivel++;
      pontuacao=false;
      opcao=0;
    }
}

void effects_pausa_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  if (inter.get(3).mouseHover(mouseX, mouseY)) {
    sound(0);
    pausa=false;
    stop_music(1);
    music(0);
    opcao=0;
  }
}

void effects_morrer_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  desenha_nave=true;
  //Recomeçar
  if (morte_texto.get(1).mouseHover(mouseX, mouseY)) {
    sound(0);
    opacidade=0;
    reset_nivel(nivel);
  } else
    //Desistir
    if (morte_texto.get(2).mouseHover(mouseX, mouseY)) {
      sound(0);
      opcao=0;
      controlo=0;
      dialogos_ativos=false;
      nave.set_velocidade(0);
      morto=false;
      opacidade=0;
      stop_music(1);
      music(0);
      reloading=false;
      a_tiros=n_tiros;
    }
}

void sound(int n) { //Dá play num sound effect baseado no valor recebido
  if (n==0) {
    effect1.rewind();
    effect1.play();
  } else if (n==1) {
    effect2.rewind();
    effect2.play();
  } else if (n==2) {
    effect3.rewind();
    effect3.play();
  } else if (n==3) {
    effect4.rewind();
    effect4.play();
  } else if (n==4) {
    effect5.rewind();
    effect5.play();
  } else if (n==5) {
    effect6.rewind();
    effect6.play();
  } else if (n==6) {
    effect7.rewind();
    effect7.play();
  } else if (n==7) {
    effect8.rewind();
    effect8.play();
  } else if (n==8) {
    effect9.rewind();
    effect9.play();
  } else if (n==9) {
    effect10.rewind();
    effect10.play();
  } else if (n==10) {
    effect11.rewind();
    effect11.play();
  } else if (n==11) {
    effect12.rewind();
    effect12.play();
  }
}

void music(int n) { //Dá play em uma música baseado no valor recebido
  if (n==0) {
    theme_s_m.loop();
  } else if (n==1) {
    ambient_s_m.loop();
  } else if (n==2) {
    effect9.loop();
  }
}

void stop_music(int n) { //Dá stop em uma música baseado no valor recebido
  if (n==0) {
    theme_s_m.pause();
    theme_s_m.rewind();
  } else if (n==1) {
    ambient_s_m.pause();
    ambient_s_m.rewind();
  } else if (n==2) {
    effect9.pause();
    effect9.play();
  }
}
