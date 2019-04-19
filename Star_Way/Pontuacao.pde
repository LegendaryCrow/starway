void concluir_nivel() {
  int segundos=int((millis()-timer+timer_pausa)/1000); //Converte para segundos o tempo demorado a passar de nível
  int minutos=segundos/60; //Converte para minutos o tempo demorado a passar de nível
  segundos=segundos-minutos*60; //Remove os minutos deixando apenas os segundos
  
  //Dá restar nas variaveis do nivel atual e do próximo
  reset_nivel(nivel);
  reset_nivel(nivel+1);
  //Ativa o ecra de pontuacao
  pontuacao=true;
  //Calcula o numero de gold que vai receber
  total_score=(2000+500*nivel)-int((millis()-timer+timer_pausa)/1000)*nivel;
  score=0;
  fase++;
  //Adiciona o gold a carteira do jogador
  gold+=total_score;
  //Reescreve o texto
  inter.get(1).remake(""+gold, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false);

  if (total_score!=score) music(2); //Efeito sonoro das moedas

  //Reescreve os textos no menu pontuaçao
  if (segundos<10)
    pontuacao_texto.get(4).remake(minutos+":0"+segundos, game_played, 255, true, conv_height(360), conv_height(25), conv_width(800));
  else
    pontuacao_texto.get(4).remake(minutos+":"+segundos, game_played, 255, true, conv_height(360), conv_height(25), conv_width(800));

  if (nivel!=0)
    pontuacao_texto.get(0).remake("Nivel "+nivel+" Completo", pdark, 255, conv_width(640), conv_height(200), conv_height(60), true);
  else
    pontuacao_texto.get(0).remake("Tutorial Completo", pdark, 255, conv_width(640), conv_height(200), conv_height(60), true);
}

void pontuacao() {
  image(menu_fundo, 0, 0);
  //Animação do score
  if (score<total_score) {
    if (score>=total_score-10)
      score++;
    else
      score+=10;
    pontuacao_texto.get(2).remake(""+score, game_played, 255, true, conv_height(300), conv_height(25), conv_width(800));
    if (score==total_score-1) {
      stop_music(2);
      sound(9);
    }
  }

  //Desenhar texto da pontuação  
  for (int i=0; i<pontuacao_texto.size(); i++) {
    pontuacao_texto.get(i).desenha();
  }

  //Desenho do sprite da moeda
  sprite_coin.desenha(conv_width(800), conv_height(300)-conv_height(25), int(conv_height(35)), int(conv_height(35)));
  sprite_coin.sprite();
  
  //Dialogos de quando se completa o tutorial
  if (nivel==0 && dialogos_ativos) {
    if (pos_dialogo<textos_pontuacao.size())
      textos_pontuacao.get(pos_dialogo).desenha();
    else 
    dialogos_ativos=false;
  }
}
