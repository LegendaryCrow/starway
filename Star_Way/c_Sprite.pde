class Sprite {
  //Variaveis
  float x, y;
  int c, l, i;
  int timer=0, cooldown=5; //Tempo que demora a mudar de imagem
  ArrayList <PImage> sprite = new ArrayList(); //Array com todas as imagens do sprite

  Sprite(float _x, float _y, int _c, int _l, int _cooldown) {
    x=_x;
    y=_y;
    c=_c;
    l=_l;
    cooldown=_cooldown;
  }

  void imagem(String name) { //Adiciona imagens ao sprite
    sprite.add(loadImage(name));
  }

  void desenha() { //Desenha o sprite
    image(sprite.get(i), x, y, c, l);
  }

  void desenha(float _x, float _y, int _c, int _l) { //Desenha o sprite com variaveis diferente
    image(sprite.get(i), _x, _y, _c, _l);
  }

  void sprite() { //Animaçao do sprite
    timer++;
    for (int j=0; j<sprite.size(); j++) {
      if (j*cooldown==timer) { //Muda de imagem sempre quando passa o tempo definido "cooldown" em cada imagem
        i++;
      }
    }
    if (timer==sprite.size()*cooldown) { //Reset da animaçao quando precorre todas as imagens
      i=0; 
      timer=0;
    }
  }
}
