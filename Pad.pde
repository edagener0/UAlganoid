class Pad
{
  PVector posicao;
  PVector velocidade;
  
  float x;
  float y;
  
  float min_y;
  float max_y;
  
  float min_x;
  float max_x;
  
  float largura;
  float altura;
  
  float centro;
  
  float vel_x;
  
  color cor;
  
  PImage imagem;
  
  Pad (float x, float y, float largura, float altura, color cor)
  {
    this.posicao = new PVector(x, y);
    this.velocidade = new PVector(0, 0);
    
    this.largura = largura;
    this.centro = largura / 2;
    this.altura = altura;
    
    this.cor = cor;
    
    this.min_y = this.posicao.y - this.altura / 2;
    this.max_y = this.posicao.y + this.altura / 2;
    this.min_x = this.posicao.x - this.largura / 2;
    this.max_x = this.posicao.x + this.largura / 2;
    
    this.imagem = imagem_pad;
  }

 void mover_direita()
 {
   this.velocidade.x = 1;
   this.velocidade.setMag(PAD_MODULO_VEL);
 }
 
 void mover_esquerda()
 {
   this.velocidade.x = -1;
   this.velocidade.setMag(PAD_MODULO_VEL);
 }
 
 void update()
 {
   if (!keyPressed) this.velocidade.x = 0;
   
   PVector nova_posicao = this.posicao.copy();
   float min_x_temp, max_x_temp;
   
   nova_posicao = nova_posicao.add(velocidade);
   
   min_x_temp = nova_posicao.x - this.centro;
   max_x_temp = nova_posicao.x + this.centro;
   
   if (min_x_temp < MIN_BORDER_X)
   {
     this.posicao.x = MIN_BORDER_X + this.largura / 2;
     this.min_x = MIN_BORDER_X;
     this.max_x = this.posicao.x + this.largura / 2;
     return;
   }
  
   else if (max_x_temp > MAX_BORDER_X)
   {
     this.posicao.x = MAX_BORDER_X - this.largura / 2;
     this.min_x = this.posicao.x - this.largura / 2;
     this.max_x = MAX_BORDER_X;
     return;
   }
   
   this.min_x = min_x_temp;
   this.max_x = max_x_temp;
   this.posicao.add(velocidade);
}
 
 void reset()
 {
   this.posicao.x = POSICAO_X_PAD;
 }
  
void draw()
{
    update();
    if (!texturas_ligadas)
    {
      fill(this.cor);
      rectMode(CENTER);
      rect(this.posicao.x, this.posicao.y, this.largura, this.altura);
    }
    else image(this.imagem, this.posicao.x - this.largura / 2, this.posicao.y - this.altura / 2, this.largura, this.altura);
  }
  
}
