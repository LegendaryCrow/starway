class C_Textos {
  //Caixa de texto
  float x_rect=conv_width(640), y_rect=conv_height(630), lar_rect=width-border, alt_rect=conv_height(180)-border;
  //Textos
  float tam_letra, tam_text;
  float x, y, temp_x; //Posição dos textos
  String texto;
  int n_letras;
  color cor;
  PFont fonte;

  C_Textos(String _texto, PFont _fonte, color _cor, float _x, float _y, float _tam_letra, boolean mode) {
    fonte=_fonte;
    tam_letra=_tam_letra;
    textFont(fonte, tam_letra);
    texto=_texto;
    tam_text=textWidth(texto);
    n_letras=texto.length();
    cor=_cor;
    if (mode)
      x=_x-tam_text/2;
    else
      x=_x;
    y=_y;
  }

  C_Textos(String _texto, PFont _fonte, color _cor, boolean alinhado, float _y, float _tam_letra, float _xA) {
    fonte=_fonte;
    tam_letra=_tam_letra;
    textFont(fonte, tam_letra);
    texto=_texto;
    tam_text=textWidth(texto);
    n_letras=texto.length();
    cor=_cor;
    if (alinhado) x=_xA-tam_text-border;
    else x=_xA+border;
    y=_y;
  }

  void desenha() {
    textFont(fonte, tam_letra);
    temp_x=x;
    for (int i=0; i<n_letras; i++) { //Desenha letra a letra o texto
      fill(cor);
      text(texto.charAt(i), temp_x, y);
      temp_x+=textWidth(texto.charAt(i));
    }
  }

  boolean mouseHover(float mx, float my) { //Dá return true caso o rato se encontra em cima do texto
    if (mx>x && mx<x+tam_text && my>y-tam_letra && my<y) return true;
    else return false;
  }

  void atualiza_Texto(String _texto) { //Reescreve o texto
    texto=_texto;
    textFont(fonte, tam_letra);
    tam_text=textWidth(texto);
    n_letras=texto.length();
  }

  void remake(String _texto, PFont _fonte, color _cor, boolean alinhado, float _y, float _tam_letra, float _xA) { //Refaz todo o texto e configuraçoes deste
    fonte=_fonte;
    tam_letra=_tam_letra;
    textFont(fonte, tam_letra);
    texto=_texto;
    tam_text=textWidth(texto);
    n_letras=texto.length();
    cor=_cor;
    if (alinhado) x=_xA-tam_text-border;
    else x=_xA+border;
    y=_y;
  }

  void remake(String _texto, PFont _fonte, color _cor, float _x, float _y, float _tam_letra, boolean mode) { //Refaz todo o texto e configuraçoes deste
    fonte=_fonte;
    tam_letra=_tam_letra;
    textFont(fonte, tam_letra);
    texto=_texto;
    tam_text=textWidth(texto);
    n_letras=texto.length();
    cor=_cor;
    if (mode)
      x=_x-tam_text/2;
    else
      x=_x;
    y=_y;
  }

  float getEnd() { //Dá return da posiçao onde se encontra o final do texto
    textFont(fonte, tam_letra);
    return x+textWidth(texto);
  }
}
