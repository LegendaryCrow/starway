void oficina() { //Desenha o menu da oficina
  image(menu_fundo, 0, 0);
  if (gold_a!=gold) { //Animaçao do gold
    if (gold_a>gold+50)
      gold_a-=50;
    else
      gold_a--;
    inter.get(1).remake(""+gold_a, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false); 
    if (gold_a==gold) { //Efeito sonoro acaba
      stop_music(2);
      sound(9);
    }
  }

  for (int i=0; i<oficina_texto.size(); i++) { //Desenha todos os textos do menu oficina
    oficina_texto.get(i).desenha();
  }
  rectMode(CORNER);
  for (int i=0; i<n_upgrade_velocidade; i++) { //Desenha todos os retangulos dos upgrades de velocidade
    if (i<upgrade_velocidade) { //Desenha a verde o numero de upgrades comprados
      fill(125, 255, 125);
    } else if (i<comprar_upgrade_velocidade+upgrade_velocidade) {  //Desenha a vermelho o numero de upgrades que pertende-se comprar
      fill(255, 125, 125);
    } else { //Desenha a branco caso nenhuma das condiçoes anteriores aconteça
      fill(255);
    }
    rect(oficina_texto.get(4).getEnd()+conv_width(50*i), conv_height(220), conv_width(40), conv_height(20));
  }
  for (int i=0; i<n_upgrade_recarga; i++) { //Desenha todos os retangulos dos upgrades de recarga
    if (i<upgrade_recarga) { //Desenha a verde o numero de upgrades comprados
      fill(125, 255, 125);
    } else if (i<comprar_upgrade_recarga+upgrade_recarga) {  //Desenha a vermelho o numero de upgrades que pertende-se comprar
      fill(255, 125, 125);
    } else { //Desenha a branco caso nenhuma das condiçoes anteriores aconteça
      fill(255);
    }
    rect(oficina_texto.get(5).getEnd()+conv_width(50*i), conv_height(320), conv_width(40), conv_height(20));
  }
  for (int i=0; i<n_upgrade_aceleracao; i++) { //Desenha todos os retangulos dos upgrades de aceleração
    if (i<upgrade_aceleracao) { //Desenha a verde o numero de upgrades comprados
      fill(125, 255, 125);
    } else if (i<comprar_upgrade_aceleracao+upgrade_aceleracao) {  //Desenha a vermelho o numero de upgrades que pertende-se comprar
      fill(255, 125, 125);
    } else { //Desenha a branco caso nenhuma das condiçoes anteriores aconteça
      fill(255);
    }
    rect(oficina_texto.get(6).getEnd()+conv_width(50*i), conv_height(420), conv_width(40), conv_height(20));
  }

  //Desenho do sprite da moeda
  sprite_coin.desenha(oficina_texto.get(7).getEnd(), conv_height(220)-conv_height(10), int(conv_height(40)), int(conv_height(40)));
  sprite_coin.desenha(oficina_texto.get(8).getEnd(), conv_height(320)-conv_height(10), int(conv_height(40)), int(conv_height(40)));
  sprite_coin.desenha(oficina_texto.get(9).getEnd(), conv_height(420)-conv_height(10), int(conv_height(40)), int(conv_height(40)));
  sprite_coin.desenha(oficina_texto.get(11).getEnd(), conv_height(500)-conv_height(30), int(conv_height(40)), int(conv_height(40)));
  sprite_coin.sprite();
  sprite_coin.desenha();
  inter.get(1).desenha();
  //Desenhar dialogos
  if (dialogos_ativos==true)
    textos_oficina.get(controlo).desenha();
}

void effects_oficina_mouse() { //Verifica se o utlizador clica em algum dos textos e faz uma açao baseada nisso
  //Upgrade + Velocidade
  if (oficina_texto.get(7).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_velocidade+upgrade_velocidade<n_upgrade_velocidade) { //Aumenta os upgrades que se pertende comprar de velocidade
      comprar_upgrade_velocidade++;
      custo+=preco_upgrade_velocidade*(upgrade_velocidade+comprar_upgrade_velocidade);
      oficina_atualiza_preco(0);
    }
    if (comprar_upgrade_velocidade+upgrade_velocidade==n_upgrade_velocidade)
      sound(10);
    else
      sound(11);
  }
  //Upgrade + Recarga
  else if (oficina_texto.get(8).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_recarga+upgrade_recarga<n_upgrade_recarga) { //Aumenta os upgrades que se pertende comprar de recarga
      comprar_upgrade_recarga++;
      custo+=preco_upgrade_recarga*(upgrade_recarga+comprar_upgrade_recarga);
      oficina_atualiza_preco(1);
    }
    if (comprar_upgrade_recarga+upgrade_recarga==n_upgrade_recarga)
      sound(10);
    else
      sound(11);
  }
  //Upgrade + aceleracao
  else if (oficina_texto.get(9).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_aceleracao+upgrade_aceleracao<n_upgrade_aceleracao) { //Aumenta os upgrades que se pertende comprar de aceleração
      comprar_upgrade_aceleracao++;
      custo+=preco_upgrade_aceleracao*(upgrade_aceleracao+comprar_upgrade_aceleracao);
      oficina_atualiza_preco(2);
    }
    if (comprar_upgrade_aceleracao+upgrade_aceleracao==n_upgrade_aceleracao)
      sound(10);
    else
      sound(11);
  }
  //Upgrade - Velocidade
  else if (oficina_texto.get(4).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_velocidade+upgrade_velocidade>upgrade_velocidade) { //Reduz os upgrades que se pertende comprar de velocidade
      custo-=preco_upgrade_velocidade*(upgrade_velocidade+comprar_upgrade_velocidade);
      comprar_upgrade_velocidade--;
      oficina_atualiza_preco(0);
    }
    if (comprar_upgrade_velocidade+upgrade_velocidade==0)
      sound(10);
    else
      sound(11);
  }
  //Upgrade - Recarga
  else if (oficina_texto.get(5).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_recarga+upgrade_recarga>upgrade_recarga) { //Reduz os upgrades que se pertende comprar de recarga
      custo-=preco_upgrade_recarga*(upgrade_recarga+comprar_upgrade_recarga);
      comprar_upgrade_recarga--;
      oficina_atualiza_preco(1);
    }
    if (comprar_upgrade_recarga+upgrade_recarga==0)
      sound(10);
    else
      sound(11);
  }
  //Upgrade - Aceleração
  else if (oficina_texto.get(6).mouseHover(mouseX, mouseY)) {
    if (comprar_upgrade_aceleracao+upgrade_aceleracao>upgrade_aceleracao) { //Reduz os upgrades que se pertende comprar de aceleração
      custo-=preco_upgrade_aceleracao*(upgrade_aceleracao+comprar_upgrade_aceleracao);
      comprar_upgrade_aceleracao--;
      oficina_atualiza_preco(2);
    }
    if (comprar_upgrade_aceleracao+upgrade_aceleracao==0)
      sound(10);
    else
      sound(11);
  }
  //Menu
  else if (oficina_texto.get(13).mouseHover(mouseX, mouseY)) { //Reset em todas as variáveis e volta ao menu
    comprar_upgrade_velocidade=0;
    comprar_upgrade_recarga=0;
    comprar_upgrade_aceleracao=0;
    custo=0;
    opcao=0;
    oficina_atualiza_preco(3);
    sound(0);
    controlo=0;
    inter.get(1).remake(""+gold, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false); //Atualiza o texto do gold
    if (gold_a!=gold) //Pára o som caso ativo
      stop_music(2);
  }
  //Comprar
  else if (custo!=0 && oficina_texto.get(12).mouseHover(mouseX, mouseY)) {
    if (custo<=gold) { //Caso o custo dos upgrades seja inferior ou igual ao dinheiro do jogador
      gold-=custo; //Atualiza o dinheiro do jogador
      custo=0; //Atualiza o custo total
      oficina_atualiza_preco(3); //Atualiza os textos
      //Define o numero de upgrades ativados atualmente
      upgrade_velocidade+=comprar_upgrade_velocidade;
      comprar_upgrade_velocidade=0;
      upgrade_recarga+=comprar_upgrade_recarga;
      comprar_upgrade_recarga=0;
      upgrade_aceleracao+=comprar_upgrade_aceleracao;
      comprar_upgrade_aceleracao=0;
      //Ativa o dialogos com o Mecânico
      dialogos_ativos=true;
      controlo=1;
      //Ativa os upgrades na nave
      nave.setUpgrades(upgrade_velocidade, upgrade_aceleracao);
      m_inc=2500+1000*upgrade_recarga;
      //Ativa a musica para a animação do dinheiro
      music(2);
    } else { //Se não tiver dinheiro suficiente
      sound(10); //Som de erro
      //Ativa o dialogos com o Mecânico
      dialogos_ativos=true;
      controlo=0;
    }
  }
}

void oficina_atualiza_preco(int n) { //Atualiza os textos da oficina baseado na variável recebida na função
  if (n==0) { //Atualiza texto de velocidade
    if (upgrade_velocidade+comprar_upgrade_velocidade==n_upgrade_velocidade)
      oficina_texto.get(7).remake("+ MAX", zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), oficina_texto.get(4).getEnd()+conv_width(50*n_upgrade_velocidade));
    else
      oficina_texto.get(7).remake("+ "+preco_upgrade_velocidade*(1+upgrade_velocidade+comprar_upgrade_velocidade), zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), oficina_texto.get(4).getEnd()+conv_width(50*n_upgrade_velocidade));
  } else if (n==1) { //Atualiza texto de recarga
    if (upgrade_recarga+comprar_upgrade_recarga==n_upgrade_recarga)
      oficina_texto.get(8).remake("+ MAX", zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), oficina_texto.get(5).getEnd()+conv_width(50*n_upgrade_recarga));
    else
      oficina_texto.get(8).remake("+ "+preco_upgrade_recarga*(1+upgrade_recarga+comprar_upgrade_recarga), zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), oficina_texto.get(5).getEnd()+conv_width(50*n_upgrade_recarga));
  } else if (n==2) { //Atualiza texto de aceleração
    if (upgrade_aceleracao+comprar_upgrade_aceleracao==n_upgrade_aceleracao)
      oficina_texto.get(9).remake("+ MAX", zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao));
    else
      oficina_texto.get(9).remake("+ "+preco_upgrade_aceleracao*(1+upgrade_aceleracao+comprar_upgrade_aceleracao), zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao));
  } else if (n==3) { //Atualiza todos os textos
    if (upgrade_velocidade+comprar_upgrade_velocidade==n_upgrade_velocidade)
      oficina_texto.get(7).remake("+ MAX", zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), oficina_texto.get(4).getEnd()+conv_width(50*n_upgrade_velocidade));
    else
      oficina_texto.get(7).remake("+ "+preco_upgrade_velocidade*(1+upgrade_velocidade+comprar_upgrade_velocidade), zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), oficina_texto.get(4).getEnd()+conv_width(50*n_upgrade_velocidade));
    if (upgrade_recarga+comprar_upgrade_recarga==n_upgrade_recarga)
      oficina_texto.get(8).remake("+ MAX", zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), oficina_texto.get(5).getEnd()+conv_width(50*n_upgrade_recarga));
    else
      oficina_texto.get(8).remake("+ "+preco_upgrade_recarga*(1+upgrade_recarga+comprar_upgrade_recarga), zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), oficina_texto.get(5).getEnd()+conv_width(50*n_upgrade_recarga));
    if (upgrade_aceleracao+comprar_upgrade_aceleracao==n_upgrade_aceleracao)
      oficina_texto.get(9).remake("+ MAX", zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao));
    else
      oficina_texto.get(9).remake("+ "+preco_upgrade_aceleracao*(1+upgrade_aceleracao+comprar_upgrade_aceleracao), zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao));
  }
  //Atualiza o texto do custo
  oficina_texto.get(11).remake(""+custo, zorque, 255, false, conv_height(500), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao));
}
