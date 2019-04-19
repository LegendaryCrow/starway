void gera_meteoros() { //Gera meteoros
  float n_meteoros=10;
  float dist=width/n_meteoros;
  float size;
  for (int i=0; i<n_meteoros; i++) {

    size=random(height/20, height/10);
    //GENERATE TOP
    meteoro.add(new C_Meteoro(width/n_meteoros*i+random(dist), random(-size*1.5, -size), size, int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));

    size=random(height/20, height/10);
    //GENERATE BOT
    meteoro.add(new C_Meteoro(width/n_meteoros*i+random(dist), random(height-size, height-size/2), size, int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));
  }
  n_meteoros=5;
  dist=width/n_meteoros;
  for (int i=0; i<n_meteoros; i++) {

    size=random(height/20, height/10);
    //GENERATE LEFT
    meteoro.add(new C_Meteoro(random(-size*1.5, -size), height/n_meteoros*i+random(dist), size, int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));

    size=random(height/20, height/10);
    //GENERATE RIGHT
    meteoro.add(new C_Meteoro(random(width-size, width-size/2), height/n_meteoros*i+random(dist), size, int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));
  }
}
void gera_chuva() { //Gera a chuva de meteoros do menu principal na primeira execuçao
  for (int i=0; i<10; i++) {
    chuva_meteoro.add(new C_Meteoro(random(-width/10, width/2), random(-height, -height/10), random(height/20, height/10), int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));
  }
}

void gera_chuva_meteoro() { //Gera um meteoros para a chuva de meteoros do menu principal
  chuva_meteoro.add(new C_Meteoro(random(-width/10, width/2), random(-height, -height/10), random(height/20, height/10), int(random(8, 25)), color(random(115, 167), random(115, 167), random(115, 167))));
}
