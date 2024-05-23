class Border
{
  int largura;
  color cor;
  
  
  Border(int largura, color cor)
  {
    this.largura = largura;
    this.cor = cor;
  }
  
  void draw()
  {
    fill(this.cor);
    rectMode(CENTER);
    // *7 porque é metade de 14 blocos e *0.2 porque é a metade da altura de cada bloco
    //abc
    
    //rect(this.largura * 7, this.largura * 0.25 + ALTURA_HEADER, this.largura * 14, this.largura * 0.5);
    //rect(this.largura * 0.25, this.largura * 7 + ALTURA_HEADER, this.largura * 0.5, this.largura * 14);
    //rect(this.largura * 14 - this.largura * 0.25, this.largura * 7 + ALTURA_HEADER, this.largura * 0.5, this.largura * 14);
    image(borda, 0, ALTURA_HEADER);
  }
}
