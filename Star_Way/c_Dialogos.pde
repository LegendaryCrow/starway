class C_Dialogos {
  //Caixa de texto
  float x_rect=conv_width(640), y_rect=conv_height(630), lar_rect=width-border, alt_rect=conv_height(180)-border;
  //Variavéis de texto
  float tam_letra=conv_height(20), alt_nome=conv_height(30);
  float x=width/80, y=height-conv_height(180)+width/80+tam_letra, temp_x, temp_y; //Posição dos textos
  //Texto
  String texto, nome;
  //Imagem do personagem
  PImage personagem;
  int pos=0, tam_text, tam_nome;

  C_Dialogos(String _nome, String _texto, String _img) {
    texto=_texto;
    nome=_nome;
    personagem=loadImage(_img);
    personagem.resize(width/4, personagem.height*width/4/personagem.width);
    tam_text=texto.length();
    tam_nome=nome.length();
  }

  void desenha() {
    //Imagens de personagem
    image(personagem, 0, conv_height(360));

    //Caixa de texto
    stroke(255, 200);
    fill(0, 200);
    rectMode(CENTER);
    rect(x_rect, y_rect, lar_rect, alt_rect, 20);

    fill(255);

    //Nome
    textFont(zorque, alt_nome);
    temp_x=x;
    for (int i=0; i<tam_nome; i++) {
      text(nome.charAt(i), temp_x, y);
      temp_x+=textWidth(nome.charAt(i));
    }

    //Textos
    temp_x=x;
    temp_y=y+alt_nome+tam_letra/2;
    textFont(helvetica, tam_letra);

    for (int i=0; i<pos; i++) { //Desenha todo o texto
      if (texto.charAt(i)!='€') { //Caso encontre um € muda de linha
        text(texto.charAt(i), temp_x, temp_y);
      }
      temp_x+=textWidth(texto.charAt(i));
      if (temp_x>width-width/80 || (temp_x>width-width/10 && texto.charAt(i)==' ') || texto.charAt(i)=='€') { // Se encontrar um espaço perto do final, um €, ou estiver no limite da janela muda de linha
        temp_x=width/80;
        temp_y+=tam_letra;
      }
    }
    if (texto.length()>pos) { //Animaçao do texto
      pos++;
    }
  }

  boolean verifica_end() {
    //Da return true se o texto tiver a ser todo desenhado
    if (tam_text==pos) return true;
    else return false;
  }

  void set_pos(int _pos) {
    //Altera o texto que é mostrado
    pos=_pos;
  }

  int get_tam() {
    //Dá return do numero de letras
    return tam_text;
  }
}
