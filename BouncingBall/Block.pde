class Block
{
  float x;
  float y;
  
  float min_x;
  float max_x;
  
  float min_y;
  float max_y;
  
  float largura;
  float altura;
  
  color cor;
  
  int vida;
  
  boolean exposto;
  
  Block(float x, float y, float largura, color cor, int vida, boolean exposto)
  {
    this.x = x;
    this.y = y;
    
    this.largura = largura;
    this.altura = this.largura / 2;
    
    this.min_x = this.x - this.largura / 2;
    this.max_x = this.x + this.largura / 2;
    
    this.min_y = this.y - this.altura / 2;
    this.max_y = this.y + this.altura / 2;
    
    this.cor = cor;
    this.vida = vida;
    this.exposto = exposto;
  }
  
  void draw()
  {
    if (this.vida == 0) return;
    fill(this.cor);
    stroke(0);
    strokeWeight(LARGURA_BLOCO * 0.01);
    rectMode(CENTER);
    rect(this.x, this.y, this.largura, this.altura);
    noStroke();
  }
  
  
}
