//--- Classes
C_Nave nave; //Declaração da classe da nave
C_Ping ping1; //Declaração da classe do ping
C_Ping ping_morte; //Declaração da classe do ping para a morte
C_Portal portal;
C_Textos fps_texto;
C_Textos timer_texto;
ArrayList<C_Obstaculo1> obstaculo1=new ArrayList();
ArrayList<C_Obstaculo2> obstaculo2=new ArrayList();
ArrayList<C_Obstaculo3> obstaculo3=new ArrayList();
ArrayList<C_Obstaculo4> obstaculo4=new ArrayList();
ArrayList<C_Obstaculo5> obstaculo5=new ArrayList();
Sprite sprite_coin;
ArrayList<C_Tiro> tiros=new ArrayList(); //Declaração da classe dos tiros
ArrayList<C_Meteoro> meteoro=new ArrayList(); //Declaração da classe dos meteoros
ArrayList<C_Meteoro> chuva_meteoro=new ArrayList(); //Declaração da classe dos meteoros do efeito chuva de meteoros no menu
ArrayList<C_Dialogos> textos_tutorial=new ArrayList(); //Declaração da classe dos textos do tutorial
ArrayList<C_Dialogos> textos_pontuacao=new ArrayList(); //Declaração da classe dos textos da pontuacao
ArrayList<C_Dialogos> textos_oficina=new ArrayList(); //Declaração da classe dos textos da oficina
ArrayList<C_Textos> creditos_texto=new ArrayList(); //Declaração da classe dos textos da oficina
ArrayList<C_Textos> menu_texto=new ArrayList(); //Declaração da classe dos textos do menu
ArrayList<C_Textos> inter=new ArrayList(); //Declaração da classe dos textos do menu
ArrayList<C_Textos> morte_texto=new ArrayList(); //Declaração da classe dos textos da morte
ArrayList<C_Textos> oficina_texto=new ArrayList(); //Declaração da classe dos textos da morte
ArrayList<C_Textos> pontuacao_texto=new ArrayList(); //Declaração da classe dos textos da morte
ArrayList<c_Inimigo1> i1=new ArrayList(); //Declaração da classe do inimigos 1

//--- Variáveis dos upgrades e da loja
int upgrade_velocidade=0, upgrade_recarga=0, upgrade_aceleracao=0; //Numero atual de upgrades
int comprar_upgrade_velocidade=0, comprar_upgrade_recarga=0, comprar_upgrade_aceleracao=0; //Numero de upgrades para comprar
int n_upgrade_velocidade=10, n_upgrade_recarga=10, n_upgrade_aceleracao=10; //Numero maximo de upgrades
int preco_upgrade_velocidade=1200, preco_upgrade_recarga=1700, preco_upgrade_aceleracao=1500; //Valor de cada upgrade
int custo=0, gold_a; //Dinheiro

//--- Váriavies de pontuação
boolean pontuacao=false;
int total_score;
int score;

//--- Outras variáveis
int n_tiros=10, a_tiros=10; //Variaveis de numero máximo de tiros e numero atual de tiros
int m, m_inc=2500; //variaveis utilizadas para recarregar cada tiro de 2.5 em 2.5 segundos
boolean reloading=false; //Boolean utilizado para começar o recarregamento
int opcao=0, nivel=0; //Opção no jogo e nível
int controlo=0; //Variavel de controlo da posição atual nos niveis
int opacidade=0; //Variavel usada para opacidade de objetos
int fase=0;
int gold=0; //Dinheiro do jogo
int auxauxaux; //variavel auxiliar para colisoes, fases de jogo, etc
float timer, timer_pausa=0; //Tempo em cada nível
boolean jogar=false; //Variavel para saber se estamos a jogar ou nao
boolean disparar=true; //Variavel para saber se a nave pode disparar ou nao
boolean morto=false; //Variavel para saber se o jogador morreu ou nao
boolean pausa=false; //Variavel para saber se o jogador está em pausa ou nao
boolean desenha_nave=true; //Variavel para desenhar a nave
boolean nivel_spawn=false; //Variavel para o spawn de inimigos/obstáculos num nivel
PFont zerovelo, zorque, helvetica, atarian, pdark, game_played; //Fontes
PImage menu_fundo, spaceship_fundo, bala; //Imagens
float border=width/100;

//--- Bibliotecas de som
import ddf.minim.*;
Minim minim;
AudioPlayer theme_s_m, ambient_s_m, effect1, effect2, effect3, effect4, effect5, effect6, effect7, effect8, effect9, effect10, effect11, effect12; //Variaveis que irão guardar os sons

//--- Textos
boolean dialogos_ativos=false; //Boolean que diz se estamos a num fala ou a jogar
int pos_dialogo=0; //Qual o dialogo ativo

void load() {
  //--- Load de música e efeitos sonoros
  minim = new Minim(this);
  theme_s_m = minim.loadFile("music/Super Metroid - Title Screen Theme.wav");
  ambient_s_m = minim.loadFile("music/Super Metroid Soundtrack - Ambient Silence.wav");
  effect1 = minim.loadFile("sound/sfx_menu_select4.wav");
  effect2 = minim.loadFile("sound/sfx_weapon_singleshot13.wav");
  effect3 = minim.loadFile("sound/sfx_wpn_noammo1.wav");
  effect4 = minim.loadFile("sound/sfx_exp_long3.wav");
  effect5 = minim.loadFile("sound/sfx_menu_select1.wav");
  effect6 = minim.loadFile("sound/sfx_movement_portal1.wav");
  effect7 = minim.loadFile("sound/sfx_movement_portal2.wav");
  effect8 = minim.loadFile("sound/sfx_exp_cluster8.wav");
  effect9 = minim.loadFile("sound/sfx_coin_double1.wav");
  effect10 = minim.loadFile("sound/sfx_coin_single6.wav");
  effect11 = minim.loadFile("sound/sfx_sounds_error3.wav");
  effect12 = minim.loadFile("sound/sfx_sounds_button6.wav");
  theme_s_m.loop();

  //--- Load de fontes
  zerovelo=createFont("font/zerovelo.ttf", conv_height(40)); //Titulo
  zorque=createFont("font/zorque.ttf", conv_height(40)); //Botoes
  helvetica=createFont("font/helvetica.ttf", conv_height(40)); //Texto
  atarian=createFont("font/atarian.ttf", conv_height(40));
  pdark=createFont("font/pdark.ttf", conv_height(40));
  game_played=createFont("font/game_played.ttf", conv_height(40));

  //--- Load de Imagens
  menu_fundo=loadImage("image/space.jpg");
  menu_fundo.resize(width, menu_fundo.height*width/menu_fundo.width);
  spaceship_fundo=loadImage("image/spaceshipfull.png");
  spaceship_fundo.resize(width, height);
  bala=loadImage("image/bala.png");

  //--- Criação dos objetos
  ping1=new C_Ping(conv_width(960), conv_height(360), 0, 100, color(0, 0, 255)); //Criação do ping
  ping_morte=new C_Ping(0, 0, 0, 100, color(255, 115, 115)); //Criação da explosão na morte da nave
  nave=new C_Nave(); //Criação da nave
  portal=new C_Portal("image/portal.png", width/2, height/2); //Criação do portalr
  //--- Criação do sprite da moeda
  sprite_coin=new Sprite(0, 0, int(conv_height(30)), int(conv_height(30)), 5);
  for (int i=0; i<6; i++)
    sprite_coin.imagem("image/coin_"+i+".png");
  gera_chuva(); //Criação da animação dos meteoros do menu
  for (int i=0; i<n_tiros; i++) {
    tiros.add(new C_Tiro()); //Criação dos tiros
  }

  //--- Criação dos textos
  //Texto dos fps
  fps_texto=new C_Textos("FPS: 9999", zorque, 255, true, bala.height*2+conv_height(10), conv_height(10), width);
  //Texto do timer
  timer_texto=new C_Textos("Timer: 0", zorque, 255, false, bala.height*2+conv_height(10), conv_height(10), conv_width(10));
  //Textos do menu
  menu_texto.add(new C_Textos("Star Way", zerovelo, 255, conv_width(640), conv_height(200), conv_height(60), true));
  menu_texto.add(new C_Textos("Novo Jogo", zorque, 255, conv_width(640), conv_height(320), conv_height(35), true));
  menu_texto.add(new C_Textos("Continuar", zorque, 69, conv_width(640), conv_height(400), conv_height(35), true));
  menu_texto.add(new C_Textos("Oficina", zorque, 69, conv_width(640), conv_height(480), conv_height(35), true));
  menu_texto.add(new C_Textos("Sair", zorque, 255, conv_width(640), conv_height(560), conv_height(35), true));
  //Textos da morte
  morte_texto.add(new C_Textos("Perdeste!", zorque, 255, conv_width(640), conv_height(200), conv_height(60), true));
  morte_texto.add(new C_Textos("Recomeçar", zorque, 255, conv_width(640), conv_height(400), conv_height(35), true));
  morte_texto.add(new C_Textos("Desistir", zorque, 255, conv_width(640), conv_height(480), conv_height(35), true));
  //Textos da oficina
  oficina_texto.add(new C_Textos("Oficina", zorque, 255, conv_width(640), conv_height(100), conv_height(60), true));
  oficina_texto.add(new C_Textos("Velocidade: ", game_played, 255, false, conv_height(200), conv_height(25), conv_width(320)));
  oficina_texto.add(new C_Textos("Recarga: ", game_played, 255, false, conv_height(300), conv_height(25), conv_width(320)));
  oficina_texto.add(new C_Textos("Aceleração: ", game_played, 255, false, conv_height(400), conv_height(25), conv_width(320)));
  oficina_texto.add(new C_Textos("- ", zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), conv_width(320)));
  oficina_texto.add(new C_Textos("- ", zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), conv_width(320)));
  oficina_texto.add(new C_Textos("- ", zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), conv_width(320)));
  oficina_texto.add(new C_Textos("+ "+preco_upgrade_velocidade*(1+upgrade_velocidade+comprar_upgrade_velocidade), zorque, 255, false, conv_height(220)+conv_height(20), conv_height(30), oficina_texto.get(4).getEnd()+conv_width(50*n_upgrade_velocidade)));
  oficina_texto.add(new C_Textos("+ "+preco_upgrade_recarga*(1+upgrade_recarga+comprar_upgrade_recarga), zorque, 255, false, conv_height(320)+conv_height(20), conv_height(30), oficina_texto.get(5).getEnd()+conv_width(50*n_upgrade_recarga)));
  oficina_texto.add(new C_Textos("+ "+preco_upgrade_aceleracao*(1+upgrade_aceleracao+comprar_upgrade_aceleracao), zorque, 255, false, conv_height(420)+conv_height(20), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao)));
  oficina_texto.add(new C_Textos("Total: ", game_played, 255, true, conv_height(500), conv_height(25), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao)));
  oficina_texto.add(new C_Textos("0", zorque, 255, false, conv_height(500), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao)));
  oficina_texto.add(new C_Textos("Comprar", zorque, 255, false, conv_height(650), conv_height(30), oficina_texto.get(6).getEnd()+conv_width(50*n_upgrade_aceleracao)));
  oficina_texto.add(new C_Textos("Menu", zorque, 255, false, conv_height(650), conv_height(30), conv_width(320)));
  //Textos da interface
  inter.add(new C_Textos("Pausa", pdark, 255, width/2, height/2-conv_height(45), conv_height(45), true));
  inter.add(new C_Textos(""+gold, zorque, 255, conv_height(35), conv_height(25), conv_height(20), false));
  inter.add(new C_Textos("'Esc' para continuar...", helvetica, 255, width/2, height/2, conv_height(15), true));
  inter.add(new C_Textos("Sair", zorque, 255, true, height-conv_height(35), conv_height(25), width-conv_height(35)));
 //Dialogos do tutorial
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Bem vindo soldado, foi selecionado para o exército intergalático!€Eu sou o Coronel Gouveia e vou-o ensinar a pilotar a nave.€Vamos começar!", "character/fabio1.png"));
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Antes de mais devo informá-lo que as naves do exército intergalático são bastante poderosas, mas ao mesmo tempo muito sensíveis.€Um pequeno embate em qualquer obstáculo pode causar a sua destruição, por isso, nunca, mas mesmo nunca, bata com a nave por mínima que seja a velocidade.", "character/fabio1.png"));
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Para a nave se mover deve pressionar um ponto no ecrã.€Leva a nave até ao ponto azul.", "character/fabio1.png"));
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Excelente trabalho!€Agora que sabes controlar a tua nave vou-te ensinar a disparar.€No canto superior consegues ver o número de balas disponíveis.€Ao clicares na barra de espaço as balas são disparadas, e demoram um pouco a serem recarregadas. Experimenta disparar alguns tiros.", "character/fabio1.png"));
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Muito bem, agora que já sabes usar as funcionalidades básicas da nave. Vamos praticar com alvos reais.€Aqui estão alguns alogramas dos nossos inimigos, tenta-os destruir!", "character/fabio1.png"));
  textos_tutorial.add(new C_Dialogos("Coronel Gouveia", "Ok, estás pronto para explorar o universo. Ao longo da tua aventura irás encontrar vários portais que te levarão para outras dimensões.€Vou abrir um agora e enviar-te para outra galáxia, força soldado!", "character/fabio1.png"));
  //Dialogos da pontuacao
  textos_pontuacao.add(new C_Dialogos("Mecânico Snow", "Olá, eu sou o Mecânico Snow e cuido das necessidades das naves do exército intergalático.€Dei conta que recebeste algumas moedas por completares esta zona. Se quisseres dar uma melhoria na tua nave dá um pulo na minha oficina, tenho exatamente o que precisas pelo preço certo hehehehehe.", "character/joao1.png"));
  //Dialogos da oficina
  textos_oficina.add(new C_Dialogos("Mecânico Snow", "Parece que não tens dinheiro para estas melhorias. Que pena...", "character/joao3.png"));
  textos_oficina.add(new C_Dialogos("Mecânico Snow", "Que ótima escolha! Não te vais arrepender.", "character/joao2.png"));
  //Textos da pontuacao
  pontuacao_texto.add(new C_Textos("Nível X Completo!", pdark, 255, conv_width(640), conv_height(200), conv_height(60), true));
  pontuacao_texto.add(new C_Textos("Pontuação: ", game_played, 255, false, conv_height(300), conv_height(25), conv_width(480)));
  pontuacao_texto.add(new C_Textos("1000", game_played, 255, true, conv_height(300), conv_height(25), conv_width(800))); //Pontuação-Gold - Posição 2
  pontuacao_texto.add(new C_Textos("Tempo: ", game_played, 255, false, conv_height(360), conv_height(25), conv_width(480)));
  pontuacao_texto.add(new C_Textos("10:20", game_played, 255, true, conv_height(360), conv_height(25), conv_width(800)));
  pontuacao_texto.add(new C_Textos("Continuar", zorque, 255, conv_width(640), conv_height(500), conv_height(35), true));
  pontuacao_texto.add(new C_Textos("Menu", zorque, 255, conv_width(640), conv_height(580), conv_height(35), true));
  //Textos dos Créditos
  creditos_texto.add(new C_Textos("Obrigado por jogares!", pdark, 255, conv_width(640), conv_height(200), conv_height(60), true));
  creditos_texto.add(new C_Textos("Créditos:", game_played, 255, conv_width(640), conv_height(300), conv_height(50), true));
  creditos_texto.add(new C_Textos("Fábio Gouveia Silva", game_played, 255, conv_width(640), conv_height(350), conv_height(20), true));
  creditos_texto.add(new C_Textos("Marcelo Fernandes Coelho", game_played, 255, conv_width(640), conv_height(400), conv_height(20), true));
  creditos_texto.add(new C_Textos("Podes apoiar este projeto no link:", game_played, 255, conv_width(640), conv_height(500), conv_height(30), true));
  creditos_texto.add(new C_Textos("https://paypal.me/RealStarWay", game_played, color(100, 140, 200), conv_width(640), conv_height(550), conv_height(20), true));
  creditos_texto.add(new C_Textos("Menu", zorque, 255, true, height-conv_height(35), conv_height(25), width-conv_height(35)));
}

float conv_width(float n) { //Conversor de mediadas em x para todos os monitores
  return width*n/1280;
}

float conv_height(float n) { //Conversor de mediadas em y para todos os monitores
  return height*n/720;
}
