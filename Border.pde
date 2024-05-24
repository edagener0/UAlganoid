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
    if (!texturas_ligadas)
    {
      rect(this.largura * 7, this.largura * 0.25 + ALTURA_HEADER, this.largura * 14, this.largura * 0.5);
      rect(this.largura * 0.25, this.largura * 7 + ALTURA_HEADER, this.largura * 0.5, this.largura * 14);
      rect(this.largura * 14 - this.largura * 0.25, this.largura * 7 + ALTURA_HEADER, this.largura * 0.5, this.largura * 14);
    }
    else image(borda, 0, ALTURA_HEADER - LARGURA_BLOCO * 0.07);
  }
}
