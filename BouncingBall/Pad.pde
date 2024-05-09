class Pad
{
  PVector posicao;
  PVector velocidade;
  
  float x;
  float y;
  
  float min_y;
  
  float min_x;
  float max_x;
  
  float largura;
  float altura;
  
  float centro;
  
  float vel_x;
  
  color cor;
  
  
  Pad (float x, float y, float largura, float altura, color cor)
  {
    posicao = new PVector(x, y);
    velocidade = new PVector(0, 0);
    
    this.largura = largura;
    this.cor = cor;
    this.altura = altura;
    this.centro = largura / 2;
    
    this.min_y = this.posicao.y - this.altura / 2;
    this.min_x = this.posicao.x - this.largura / 2;
    this.max_x = this.posicao.x + this.largura / 2;
  }
  
  
  
 /*void move()
 {
   if(!keyPressed) this.velocidade.x = 0;
   
   float distancia_percorrida_x = this.velocidade.x / FRAME_RATE;
   
   //println("x: ", this.x, "largura esquerda: ", this.x - this.largura/2, "largura direita: ", this.x + this.largura/2, "distancia per: ", distancia_percorrida_x);
   if (distancia_percorrida_x < 0 && this.posicao.x + distancia_percorrida_x - this.centro <= MIN_BORDER_X)
   {
     this.posicao.x = MIN_BORDER_X + this.centro;
     return;
   }
   if (distancia_percorrida_x > 0 && this.posicao.x + distancia_percorrida_x + this.centro >= MAX_BORDER_X)
   {
     this.posicao.x = MAX_BORDER_X - this.centro;
     return;
   }
   this.x += distancia_percorrida_x;
   this.min_x = this.posicao.x - this.centro;
   this.max_x = this.posicao.x + this.centro;
 }*/
 
 void update()
 {
   if(!keyPressed) this.velocidade.x = 0;
   this.posicao.add(velocidade);
   this.min_x = this.posicao.x - this.centro;
   this.max_x = this.posicao.x + this.centro;
 }
  
  void draw()
  {
    update();
    noStroke();
    //stroke(5);
    //strokeWeight(5);
    fill(this.cor);
    rectMode(CENTER);
    rect(this.posicao.x, this.posicao.y, this.largura, this.altura);
    //noStroke();
  }
  
}
