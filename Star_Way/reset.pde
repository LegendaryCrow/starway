void reset_nivel(int level) {
  if (level==0) { //Tutorial
    //Desativar a morte caso ativa
    morto=false;
    //Reposicionar a nave
    nave.set_posicao(conv_width(100), conv_height(360));
    //Colocar o jogador no local onde estava caso tenha clicado em "Recomeçar" após morrer
    if (controlo==0 || controlo==1) {
      controlo=0;
      pos_dialogo=0;
    } else if (controlo==2 || controlo==3) {
      controlo=2;
      pos_dialogo=3;
    } else if (controlo==4) {
      controlo=3;
      pos_dialogo=4;
    }
    //Ativar dialogos
    dialogos_ativos=true;
    //Definir a velocidade da nave para 0
    nave.set_velocidade(0);
    //Repor tiros
    a_tiros=n_tiros;
    fase=0;
    for (int i=0; i<n_tiros; i++) {
      tiros.get(i).setsai(false);
      tiros.get(i).setativo(true);
      tiros.get(i).setdist(0);
    }
    reloading=false;
    //Reposicionar a nave
    nave.resetDim();
    //Remover todos os inimigos do tipo 1 caso exista
    for (; i1.size()!=0; ) {
      i1.remove(0);
    }
    //Repor a variavel de spawn de inimigos
    nivel_spawn=false;
  } else if (level==1) { //Nivel 1
    if (controlo==0) {
      controlo=0;
      pos_dialogo=0;
    }
    //Desativar a morte caso ativa
    morto=false;
    //Ativar o modo jogo
    jogar=true;
    //Reposicionar a nave
    nave.set_posicao(conv_width(100), conv_height(360));
    //Repor dimensão da nave
    nave.resetDim();
    //Repor variaveis de controlo de objetivos
    controlo=0;
    //Repor variaveis de controlo dos dialogos
    pos_dialogo=0;
    dialogos_ativos=false;
    //Ativar efeitos sonoros de passagem de nível
    nave.sound1_true(); //Nave
    portal.sound_true(); //Portal
    //Definir a velocidade da nave para 0
    nave.set_velocidade(0);
    //Repor tiros
    a_tiros=n_tiros;
    for (int i=0; i<n_tiros; i++) {
      tiros.get(i).setsai(false);
      tiros.get(i).setativo(true);
      tiros.get(i).setdist(0);
    }
    reloading=false;
    //Remover todos os obstaculos do tipo 1 e 2 caso exista
    for (; obstaculo1.size()!=0; ) {
      obstaculo1.remove(0);
    }
    for (; obstaculo2.size()!=0; ) {
      obstaculo2.remove(0);
    }
    //Remover todos os inimigos do tipo 1 caso exista
    for (; i1.size()!=0; ) {
      i1.remove(0);
    }
    //Repor a variavel de spawn de inimigos
    nivel_spawn=false;
  } else if (level==2) { //Nivel 2
    if (controlo==0) {
      controlo=0;
      pos_dialogo=0;
    }
    //Desativar a morte caso ativa
    morto=false;
    //Ativar o modo jogo
    jogar=true;
    //Reposicionar a nave
    nave.set_posicao(conv_width(100), conv_height(360));
    //Repor dimensão da nave
    nave.resetDim();
    //Repor variaveis de controlo de objetivos
    controlo=0;
    //Repor variaveis de controlo dos dialogos
    pos_dialogo=0;
    dialogos_ativos=false;
    //Ativar efeitos sonoros de passagem de nível
    nave.sound1_true(); //Nave
    portal.sound_true(); //Portal
    //Definir a velocidade da nave para 0
    nave.set_velocidade(0);
    //Repor tiros
    a_tiros=n_tiros;
    for (int i=0; i<n_tiros; i++) {
      tiros.get(i).setsai(false);
      tiros.get(i).setativo(true);
      tiros.get(i).setdist(0);
    }
    reloading=false;
    //Remover todos os obstaculos do tipo 1 e 2 caso exista
    for (; obstaculo1.size()!=0; ) {
      obstaculo1.remove(0);
    }
    for (; obstaculo2.size()!=0; ) {
      obstaculo2.remove(0);
    }
    //Remover todos os inimigos do tipo 1 caso exista
    for (; i1.size()!=0; ) {
      i1.remove(0);
    }
    //Repor a variavel de spawn de inimigos
    nivel_spawn=false;
  } else if (level==3) { //Nivel 3
    if (controlo==0) {
      controlo=0;
      pos_dialogo=0;
    }
    //Desativar a morte caso ativa
    morto=false;
    //Ativar o modo jogo
    jogar=true;
    //Reposicionar a nave
    nave.set_posicao(conv_width(100), conv_height(360));
    //Repor dimensão da nave
    nave.resetDim();
    //Repor variaveis de controlo de objetivos
    controlo=0;
    //Repor variaveis de controlo dos dialogos
    pos_dialogo=0;
    dialogos_ativos=false;
    //Ativar efeitos sonoros de passagem de nível
    nave.sound1_true(); //Nave
    portal.sound_true(); //Portal
    //Definir a velocidade da nave para 0
    nave.set_velocidade(0);
    //Repor tiros
    a_tiros=n_tiros;
    for (int i=0; i<n_tiros; i++) {
      tiros.get(i).setsai(false);
      tiros.get(i).setativo(true);
      tiros.get(i).setdist(0);
    }
    reloading=false;
    //Remover todos os obstaculos caso existam
    for (; obstaculo1.size()!=0; ) {
      obstaculo1.remove(0);
    }
    for (; obstaculo2.size()!=0; ) {
      obstaculo2.remove(0);
    }
    for (; obstaculo3.size()!=0; ) {
      obstaculo3.remove(0);
    }
    for (; obstaculo4.size()!=0; ) {
      obstaculo4.remove(0);
    }
    for (; obstaculo5.size()!=0; ) {
      obstaculo5.remove(0);
    }
    //Remover todos os inimigos do tipo 1 caso exista
    for (; i1.size()!=0; ) {
      i1.remove(0);
    }
    //Repor a variavel de spawn de inimigos
    nivel_spawn=false;
  }
  timer_pausa=0;
}
