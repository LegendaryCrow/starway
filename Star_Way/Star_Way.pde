void setup() {
  fullScreen(); //Jogo em fullscreen
  frameRate(60); //Frame rate
  cursor(CROSS); //Tipo de cursor usado durante o jogo
  load(); //Carrega todas as funcionalidades do jogo
}

void draw() {
  if (opcao==0) { //Menu
    menu(); //Desenha o menu
    noFill();
    stroke(255);
  } else if (opcao==1) { //Jogo
    //desenha meteoros, nave e tiros
    if (pontuacao) //Menu da pontuação
      pontuacao(); //Menu da pontuação
    else //Senão estiver no menu de pontuação 
    if (pausa) //Se estiver em pausa
      pausa(); //Menu de Pausa
    else //Senão estiver em pausa
    desenha_nivel(nivel); //Desenha Nível
  } else if (opcao==2) { //Opção da oficina
    oficina(); //Desenha Oficina
  } else if (opcao==3) { //Opção dos créditos
    creditos(); //Desenha Créditos
  }
}

void mousePressed() {
  if (opcao==0) {
    effects_menu_mouse(); //Efeitos do mouse no menu
  } else if (opcao==2) {
    if (dialogos_ativos==false)
      effects_oficina_mouse(); //Efeitos do mouse no oficina
    else
      effects_dialogos_mouse(); //Efeitos do mouse nos dialogos
  } else if (pontuacao) {
    if (!dialogos_ativos)
      effects_pontuacao_mouse(); //Efeitos do mouse na pontuação
    else
      effects_dialogos_mouse(); //Efeitos do mouse nos dialogos
  } else if (pausa==true) {
    effects_pausa_mouse(); //Efeitos do mouse na pausa
  } else if (jogar) {
    if (dialogos_ativos==false && morto==false) {
      nave.boost=true; //Ativa a aceleração da nave
    } else if (dialogos_ativos==true) {
      effects_dialogos_mouse(); //Efeitos do mouse nos dialogos
    }
  }
  if (morto==true && opacidade>255) {
    effects_morrer_mouse(); //Efeitos do mouse na morte
  }
  if (nivel==4) {
    effects_creditos_mouse();
  }
}

void mouseReleased() {
  if (jogar) {
    nave.boost=false; //Reativa a aceleração da nave
  }
}

void keyPressed() {
  //Colocar o jogo em pausa quando se clica no ESC
  if (keyCode==ESC) {
    key=0;
    if (jogar && !pontuacao) {
      pausa=!pausa; //Alterna entre a jogar e em pausa
      if (pausa==true)
        timer_pausa+=millis()-timer; //Guarda o tempo antes de colocar em pausa
      else
        timer=millis(); //Guarda o tempo atual após a pausa
    }
  }
  //Nave dispara tiros e altera a quantidade de tiros atual
  if ((nivel>0 || (nivel==0 && controlo>=2)) && jogar && disparar==true && pausa==false && morto==false && dialogos_ativos==false && key==' ') {
    a_tiros=dispara(a_tiros);
    disparar=false;
  }
}

void keyReleased() {
  //Após largar a barra de espaço reativar os tiros
  if (disparar==false) {
    disparar=true;
  }
}
