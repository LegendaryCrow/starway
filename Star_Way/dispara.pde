int dispara(int n) { //recebe o numero atual de tiros
  if (n>0) { //se for maior que 0
    tiros.get(n-1).dispara();//o proximo tiro sai
    n--;//numero atual de tiros reduz
    sound(1);
  } else {
    sound(2);
  }
  return n; //devolve o novo numero de tiros
}

void recarrega() { //recarrega os tiros
  //recarrega os tiros que faltam
  if (a_tiros<n_tiros && !reloading ) { //se a quantidade atual de tiros for inferior ao maximo de tiros e não estiver a decorrer um recarregalento
    reloading=true; //inicia-se um recarregamento
    //vai buscar os milisegundos passados desde o inicio do programa para temporizar o reload
    m=millis();
  } //se estiver em modo de recarga, e se já tiverem passado 'm_inc' milisegundos, repõe o tiro
  if (reloading && m+m_inc<=millis() && !tiros.get(a_tiros).ativo) {  
    tiros.get(a_tiros).dist=0; //coloca o tiro dentro da nave de novo
    tiros.get(a_tiros).setsai(false); //o tiro deixa de estar saido da nave
    tiros.get(a_tiros).setativo(true); //volta a estar ativo
    reloading=false; //deixa de estar a decorrer um recarregamento
    a_tiros+=1; //o numero atual de tiros aumenta
  }
}
