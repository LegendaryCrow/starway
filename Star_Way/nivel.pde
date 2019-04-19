void desenha_nivel(int nivel) {
  if (nivel==0) {
    tutorial();
    if (!morto && jogar==true) {
      //recarrega tiros, na aba "dispara"
      recarrega();
      //verifica a colisão entre a nave e varios objectos
      //0-meteoros
      //1-xxxx
      //2-xxxx
      verifica_colisao(0);
      verifica_colisao(1);
      sair_monitor();
    }
  } else if (nivel==1) {
    nivel1();
    if (!morto && jogar==true) {
      //recarrega tiros, na aba "dispara"
      recarrega();
      //verifica a colisão entre a nave e varios objectos
      //0-meteoros
      //1-xxxx
      //2-xxxx
      verifica_colisao(0);
      verifica_colisao(2);
      verifica_colisao(1);
      if (i1.size()==0) {
        verifica_colisao(3);
      }
      sair_monitor();
    }
  } else if (nivel==2) {
    nivel2();
    if (!morto && jogar==true) {
      //recarrega tiros, na aba "dispara"
      recarrega();
      //verifica a colisão entre a nave e varios objectos
      //0-meteoros
      //1-xxxx
      //2-xxxx
      verifica_colisao(0);
      verifica_colisao(1);
      verifica_colisao(2);
      if (obstaculo1.size()==0) {
        verifica_colisao(3);
      }
      sair_monitor();
    }
  } else if (nivel==3) {
    nivel3();
    if (!morto && jogar==true) {
      //recarrega tiros, na aba "dispara"
      recarrega();
      //verifica a colisão entre a nave e varios objectos
      //0-meteoros
      //1-xxxx
      //2-xxxx
      verifica_colisao(0);
      verifica_colisao(1);
      verifica_colisao(2);
      if (obstaculo1.size()==0) {
        verifica_colisao(3);
      }
      verifica_colisao(4);
      verifica_colisao(5);
      verifica_colisao(6);
      sair_monitor();
    }
  } else if (nivel==4) {
    nivel4();
    if (!morto) {
      sair_monitor();
    }
  }
}

void tutorial() {
  image(menu_fundo, 0, 0);
  //desenha todos os meteoros
  for (int i=0; i<meteoro.size(); i++) {
    meteoro.get(i).desenha();
  }
  //Caso tenha acabado o tutorial desenha o portal
  if (controlo==6) {
    portal.desenha();
    portal.move();
    if (portal.getDim()<1)
      portal.nasce();
    if (portal.colide(nave.getX(), nave.getY())) {
      if (nave.moveP(portal.getX(), portal.getY())) {
        nave.set_velocidade(0);
        if (nave.getDim()<=0) {
          controlo++;
        }
      }
      jogar=false;
      nave.diminui();
    }
  }
  
  //Caso tenha entrado no portal passa de nivel
  if (controlo==7) {
    concluir_nivel();
    dialogos_ativos=true;
    //Ativa os textos do menu
    menu_texto.get(2).remake("Continuar", zorque, 255, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 255, conv_width(640), conv_height(480), conv_height(35), true);
  }
  
  //Desenha os tiros
  tiros();
  //Desenha a nave
  nave.desenha(desenha_nave);

  //Pular para o proximo evento depois do dialogo
  if ((controlo==0 && pos_dialogo==3) || (controlo==2 && pos_dialogo==4) || (controlo==3 && pos_dialogo==5) || (controlo==5 && pos_dialogo==6)) { 
    controlo++;
    dialogos_ativos=false;
  }

  // Desenha dialogos
  if (dialogos_ativos==true) {
    textos_tutorial.get(pos_dialogo).desenha();
  }

  //Ensinar a controlar a nave
  if (controlo==1) {
    if (ping1.verifica_colide(nave.getX(), nave.getY())) {
      controlo++;
      dialogos_ativos=true;
      nave.set_velocidade(0);
    }
    ping1.desenha();
    ping1.aumenta();
  }

  //Ensinar a disparar
  if (controlo>=2) {
    balas();
  }
  
  //Quando termina de aprender a disparar
  if (a_tiros==5 && controlo==3) {
    nave.set_velocidade(0);
    dialogos_ativos=true;
  }

  //Inimigos do tutorial
  if (controlo==4) {
    if (!nivel_spawn) {
      for (int i=0; i<5; i++) {//cria inimigos
        i1.add(new c_Inimigo1(1, 3, 150));
      }
      nivel_spawn=true;
    } else if (i1.size()==0) {
      controlo++;
      dialogos_ativos=true;
    }
    for (int i=0; i<i1.size(); i++) {
      i1.get(i).desenha();
      i1.get(i).move(nave.getX(), nave.getY());
      for (int j=0; j<i1.size(); j++) { //Cada inimigo1 percorre todos os seus amigos para verificar se se encotnra perto de algum
        if (i!=j) {
          if (i1.get(i).pertodoamigo(i1.get(j).getX(), i1.get(j).getY())) {
            i1.get(i).setperto(true);
          }
        }
      }
      for (int k=0; k<n_tiros; k++) { //Colisao dos tiros com os inimigos
        if (tiros.get(k).getsai() && tiros.get(k).getativo() && i1.get(i).colisaotiro(tiros.get(k).getang(), tiros.get(k).getdist(), tiros.get(k).getx(), tiros.get(k).gety())) {
          tiros.get(k).setativo(false);
          i1.get(i).menosvida();
        }
      }
      if (i1.get(i).getvida()<=0) {
        i1.remove(i);
      }
    }
  }
  
  //Desenha o texto dos fps e do timer
  fps();
  timer();
  
  if (morto) { //Effeito de morte caso morto
    morrer();
  } else if (dialogos_ativos==false && jogar) { //Permite mover a nave caso nao esteja em nenhum dialogo
    nave.move();
  }
}

void nivel1() {
  //desenha o fundo
  image(menu_fundo, 0, 0);
  //desenha todos os meteoros
  for (int i=0; i<meteoro.size(); i++) {
    meteoro.get(i).desenha();
  }

  //NIVEL 1
  if (controlo==0) {//variavel que controla a fase do nivel
    if (!nivel_spawn) { //Dá spawn nos inimigos
      obstaculo1.add(new C_Obstaculo1(width/2, height/2, conv_width(40), conv_width(60), conv_height(5)));//obstaculo 1
      for (int i=0; i<2; i++) {
        i1.add(new c_Inimigo1(1, 8, 200));//inimigo 1
      }
      obstaculo2.add(new C_Obstaculo2(width/1.2, height/2, conv_width(80)));//obstaculo 2
      portal.mudaPos(width/1.2, height/2);//muda a posicao do portal
      nivel_spawn=true;
      timer=millis();//grava o millis atual para temporizar o nivel
    }
    if (obstaculo1.size()!=0) {
      obstaculo1.get(0).desenha();//desenha obstaculo
    } else if (i1.size()!=0) {
      for (int i=0; i<i1.size(); i++) {
        i1.get(i).desenha();//desenha inimigo1
        i1.get(i).move(nave.getX(), nave.getY());//movimenta inimigo1
        for (int j=0; j<i1.size(); j++) {//cada inimigo1 percorre todos os seus amigos para verificar se se encotnra perto de algum
          if (i!=j) {
            if (i1.get(i).pertodoamigo(i1.get(j).getX(), i1.get(j).getY())) {
              i1.get(i).setperto(true);//diz que o inimigo está perto de outro inimigo
            }
          }
        }
        for (int k=0; k<n_tiros; k++) {//verifica a destruicao dos inimigos
          if (tiros.get(k).getsai() && tiros.get(k).getativo() && i1.get(i).colisaotiro(tiros.get(k).getang(), tiros.get(k).getdist(), tiros.get(k).getx(), tiros.get(k).gety())) {
            tiros.get(k).setativo(false);
            i1.get(i).menosvida();
          }
        }
        if (i1.get(i).getvida()<=0) {//verifica a quantidade de vidas dos inimigos
          i1.remove(i);
        }
      }
    } else if (obstaculo2.size()!=0) {
      obstaculo2.get(0).desenha();
      obstaculo2.get(0).effects();
      if (obstaculo2.get(0).ativa_effects(nave.getX(), nave.getY())) {
        obstaculo2.remove(0);
      }
    } else {
      portal.desenha();
      portal.move();
      if (portal.getDim()<1)
        portal.nasce();
      if (portal.colide(nave.getX(), nave.getY())) {
        if (nave.moveP(portal.getX(), portal.getY())) {
          nave.set_velocidade(0);
          if (nave.getDim()<=0) {
            controlo++;
          }
        }
        jogar=false;
        nave.diminui();
      }
    }
    balas();
    if (desenha_nave==true) {
      tiros();
      //desenha a nave
      nave.desenha(desenha_nave);
    }
  } else if (controlo==1) {
    concluir_nivel();
    dialogos_ativos=false;

    menu_texto.get(2).remake("Continuar", zorque, 255, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 255, conv_width(640), conv_height(480), conv_height(35), true);
  }

  if (morto) {
    morrer();
  } else if (jogar==true) {
    nave.move();
  }


  fps();
  timer();
}

void nivel2() {
  image(menu_fundo, 0, 0);
  //desenha todos os meteoros
  for (int i=0; i<meteoro.size(); i++) {
    meteoro.get(i).desenha();
  }

  //NIVEL 2
  if (controlo==0) {
    if (!nivel_spawn) {//adiciona elementos ao nivel
      for (int i=0; i<3; i++) {
        obstaculo1.add(new C_Obstaculo1(random(width/15*(i+1)*2, width/15*(i+1)*4), random(height/15*2, height/15*13), conv_width(40), conv_width(60), conv_height(5)));
      }
      i1.add(new c_Inimigo1(1, 8, 200));
      for (int i=0; i<3; i++) {
        obstaculo2.add(new C_Obstaculo2(random(width/15*(i+1)*2, width/15*(i+1)*4), random(height/15*2, height/15*13), conv_width(80)));
      }
      auxauxaux = int(random(3));//numero gerado aleatoreamente
      portal.mudaPos(obstaculo2.get(auxauxaux).getx(), obstaculo2.get(auxauxaux).gety());//portal mufica atras de um buraco negro ao calhas
      nivel_spawn=true;
      timer=millis();//grava o millis atual para temporizar o nivel
    }
    if (i1.size()!=0) {//inimigos1 aparecem durante todo o nivel!
      for (int i=0; i<1; i++) {
        i1.get(i).desenha();
        i1.get(i).move(nave.getX(), nave.getY());
        for (int j=0; j<i1.size(); j++) {//cada inimigo1 percorre todos os seus amigos para verificar se se encotnra perto de algum
          if (i!=j) {
            if (i1.get(i).pertodoamigo(i1.get(j).getX(), i1.get(j).getY())) {
              i1.get(i).setperto(true);
            }
          }
        }
        for (int k=0; k<n_tiros; k++) {
          if (tiros.get(k).getsai() && tiros.get(k).getativo() && i1.get(i).colisaotiro(tiros.get(k).getang(), tiros.get(k).getdist(), tiros.get(k).getx(), tiros.get(k).gety())) {
            tiros.get(k).setativo(false);
            i1.get(i).menosvida();
          }
        }
        if (i1.get(i).getvida()<=0) {
          i1.remove(i);
          i1.add(new c_Inimigo1(1, 8, 200));
        }
      }
    }
    if (obstaculo1.size()!=0) {
      if (i1.size()!=0) {
        for (int i=0; i<obstaculo1.size(); i++) {
          obstaculo1.get(i).desenha();
        }
      }
    } else if (obstaculo2.size()!=0) {
      for (int i=0; i<obstaculo2.size(); i++) {
        obstaculo2.get(i).desenha();
        obstaculo2.get(i).effects();
        if (obstaculo2.get(i).ativa_effects(nave.getX(), nave.getY())) {
          obstaculo2.remove(i);
          if (i==auxauxaux) {
            auxauxaux=900;//se o oobstaculo2 por detraz do qual o portal está for destruido, auxauxaux fica igual a 900
          }
        }
      }
    } 
    if (auxauxaux==900) {// se auxauxaux== 900, o portal aparece
      portal.desenha();
      portal.move();
      if (portal.getDim()<1)
        portal.nasce();
      if (portal.colide(nave.getX(), nave.getY())) {
        if (nave.moveP(portal.getX(), portal.getY())) {
          nave.set_velocidade(0);
          if (nave.getDim()<=0) {
            controlo++;
          }
        }
        jogar=false;
        nave.diminui();
      }
    } else {//se o sistema anterior der erro, o portal aparece no centro
      if (obstaculo2.size()==0) {
        portal.mudaPos(width/2, height/2);
        portal.desenha();
        portal.move();
        if (portal.getDim()<1)
          portal.nasce();
        if (portal.colide(nave.getX(), nave.getY())) {
          if (nave.moveP(portal.getX(), portal.getY())) {
            nave.set_velocidade(0);
            if (nave.getDim()<=0) {
              controlo++;
            }
          }
          jogar=false;
          nave.diminui();
        }
      }
    }
    balas();
    if (desenha_nave==true) {
      tiros();
      //desenha a nave
      nave.desenha(desenha_nave);
    }
  } else if (controlo==1) {
    concluir_nivel();
    dialogos_ativos=false;

    menu_texto.get(2).remake("Continuar", zorque, 255, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 255, conv_width(640), conv_height(480), conv_height(35), true);
  }

  if (morto) {
    morrer();
  } else if (jogar==true) {
    nave.move();
  }


  fps();
  timer();
}

void nivel3() {
  background(spaceship_fundo);
  //desenha todos os meteoros
  for (int i=0; i<meteoro.size(); i++) {
    meteoro.get(i).desenha();
  }

  //NIVEL 3
  if (controlo==0) {
    if (!nivel_spawn) {//adiciona elementos ao nivel
      for (int i=0; i<5; i++) {
        obstaculo3.add(new C_Obstaculo3(width/4*1.5+width/12*(i+1), nave.getY()-height/10, height/50, height/5));
      }
      obstaculo4.add(new C_Obstaculo4(width/40, nave.getY()-height/10-height/16, width/6*5, height/40));
      obstaculo4.add(new C_Obstaculo4(width/40, nave.getY()+height/10+height/20, width/6*1.1, height/40));
      obstaculo4.add(new C_Obstaculo4(width/6*1.4, nave.getY()+height/10+height/20, width/6*3.5, height/40));

      obstaculo5.add(new C_Obstaculo5(width/40+width/6*1.1, nave.getY()+height/10+height/20, width/6*1.5-(width/40+width/6*1.2), height/3));

      obstaculo1.add(new C_Obstaculo1(width/8*1, nave.getY()-height/3, conv_width(40), conv_width(60), conv_height(5)));
      obstaculo2.add(new C_Obstaculo2(width/8*1, nave.getY()+height/2.5, conv_width(80)));
      portal.mudaPos(width/8*1, nave.getY()+height/3);
      for (int i=0; i<20; i++) {
        i1.add(new c_Inimigo1(1, 10, 255));
      }
      nivel_spawn=true;
      timer=millis();//grava o millis atual para temporizar o nivel
    }

    for (int i=0; i<obstaculo3.size(); i++) {
      obstaculo3.get(i).desenha();
      if (obstaculo3.get(i).prox(nave.getX(), nave.getY())) {
        obstaculo3.get(i).ativo();
      }
    }
    for (int i=0; i<obstaculo4.size(); i++) {
      obstaculo4.get(i).desenha();
    }
    for (int i=0; i<obstaculo5.size(); i++) {
      obstaculo5.get(i).desenha();
    }
    for (int i=0; i<obstaculo1.size(); i++) {
      obstaculo1.get(i).desenha();
    }

    if (obstaculo1.size()==0) {//aparecem os inimigos quando o obstaculo1 é destruido
      for (int i=0; i<i1.size(); i++) {
        i1.get(i).desenha();
        i1.get(i).move(nave.getX(), nave.getY());
        for (int j=0; j<i1.size(); j++) {//cada inimigo1 percorre todos os seus amigos para verificar se se encotnra perto de algum
          if (i!=j) {
            if (i1.get(i).pertodoamigo(i1.get(j).getX(), i1.get(j).getY())) {
              i1.get(i).setperto(true);
            }
          }
        }
        for (int k=0; k<n_tiros; k++) {
          if (tiros.get(k).getsai() && tiros.get(k).getativo() && i1.get(i).colisaotiro(tiros.get(k).getang(), tiros.get(k).getdist(), tiros.get(k).getx(), tiros.get(k).gety())) {
            tiros.get(k).setativo(false);
            i1.get(i).menosvida();
          }
        }
        if (i1.get(i).getvida()<=0) {
          i1.remove(i);
        }
      }
      obstaculo5.get(0).ativo();
    }

    for (int i=0; i<obstaculo2.size(); i++) {// coisas para obstaculo2
      obstaculo2.get(i).desenha();
      obstaculo2.get(i).effects();
      if (obstaculo2.get(i).ativa_effects(nave.getX(), nave.getY())) {
        obstaculo2.remove(i);
        if (i==auxauxaux) {
          auxauxaux=900;//se o oobstaculo2 por detraz do qual o portal está for destruido, auxauxaux fica igual a 900
        }
      }
    }
    if (obstaculo2.size()==0) {
      portal.desenha();
      portal.move();
      if (portal.getDim()<1)
        portal.nasce();
      if (portal.colide(nave.getX(), nave.getY())) {
        if (nave.moveP(portal.getX(), portal.getY())) {
          nave.set_velocidade(0);
          if (nave.getDim()<=0) {
            controlo++;
          }
        }
        jogar=false;
        nave.diminui();
      }
    }

    balas();
    if (desenha_nave==true) {
      tiros();
      //desenha a nave
      nave.desenha(desenha_nave);
    }
  } else if (controlo==1) {
    concluir_nivel();
    dialogos_ativos=false;

    menu_texto.get(2).remake("Continuar", zorque, 255, conv_width(640), conv_height(400), conv_height(35), true);
    menu_texto.get(3).remake("Loja", zorque, 255, conv_width(640), conv_height(480), conv_height(35), true);
  }

  if (morto) {
    morrer();
  } else if (jogar==true) {
    nave.move();
  }


  fps();
  timer();
}


void nivel4() {//nivel de creditos finais!
  image(menu_fundo, 0, 0);
  opcao=3;
}

void tiros() {
  if (morto==false && jogar) {
    //desenha os tiros todos na sua posicao inicial
    for (int i=0; i<tiros.size(); i++) {
      tiros.get(i).desenha(nave.getX(), nave.getY());
    }
  }
}

void balas() {
  for (int i=0; i<a_tiros; i++) {
    image(bala, (bala.width*i+bala.width/2*(i+1)), bala.height/2);
  }
}

void fps() {//mostra os fps
  fps_texto.atualiza_Texto("FPS: "+int(frameRate));
  fps_texto.desenha();
}

void timer() {//timer que conta o tempo de cada nivel
  int segundos=int((millis()-timer+timer_pausa)/1000);
  int minutos=segundos/60;
  segundos=segundos-minutos*60;
  if (segundos<10)
    timer_texto.atualiza_Texto("Tempo: "+minutos+":0"+segundos);
  else
    timer_texto.atualiza_Texto("Tempo: "+minutos+":"+segundos);
  timer_texto.desenha();
}
