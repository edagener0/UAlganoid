class PowerUp
{
  PVector posicao;
  PVector velocidade;
  
  int tipo;
  char letra;
  color cor_letra;
  color cor_container;
  
  float largura;
  float metade_largura;
  float min_x;
  float max_x;
  float max_y;
  float min_y;
  
  boolean visivel;
  
  PImage imagem;
  
  PowerUp(float x, float y, int tipo)
  {
    this.posicao = new PVector(x, y);
    
    this.visivel = true;
    this.tipo = tipo;
    
    this.largura = ALTURA_BLOCO * 0.8;
    
    this.velocidade = new PVector(0, 1);
    this.velocidade.setMag(POWERUP_MODULO_VEL);
    
    this.metade_largura = this.largura / 2;
    
    this.min_x = this.posicao.x - metade_largura;
    this.max_x = this.posicao.x + metade_largura;
    this.max_y = this.posicao.y + metade_largura;
    this.min_y = this.posicao.y - metade_largura;
    
    switch(this.tipo)
    {
      case 0:
        this.letra = 'm';
        this.cor_letra = RED;
        this.cor_container = BLUE;
        this.imagem = bola_multiplier_imagem;
        break;
      case 1:
        this.letra = 'f';
        this.cor_letra = BLUE;
        this.cor_container = RED;
        this.imagem = fireball_imagem;
        break;
      case 2:
        this.letra = 'l';
        this.cor_letra = RED;
        this.cor_container = PURPLE;
        this.imagem = coracao;
        //println("OLHA ISTO TA TUOD FOIDO CARALHO");
        break;
      case 3:
        this.letra = 's';
        this.cor_letra = BLUE;
        this.cor_container = WHITE;
        this.imagem = multiplier_image[0];
        break;
    }
  }
  
  boolean colisao_pad()
  {
    if (this.min_x >= pad.min_x && this.max_x <= pad.max_x && this.max_y >= pad.min_y && this.min_y <= pad.max_y)
    {
      this.visivel = false;
      this.posicao.y = 0;
      this.max_y = this.posicao.y + this.metade_largura;
      return true;
    }
    return false;
  }
  
  void update()
  {
    this.posicao.add(this.velocidade);
    this.max_y = this.posicao.y + this.metade_largura;
  }
  
  void draw()
  {
    if (this.posicao.y > ALTURA_JANELA || !this.visivel)
    {
      
      this.visivel = false;
      this.posicao.y = 0;
      return;
    }
    update();
    /*
    rectMode(CENTER);
    fill(this.cor_container);
    rect(this.posicao.x, this.posicao.y, this.largura, this.largura);
    
    fill(this.cor_letra);
    textAlign(CENTER, CENTER);
    textSize(this.largura);
    text(this.letra, this.posicao.x, this.posicao.y);
    */
    image(this.imagem, this.posicao.x - this.largura, this.posicao.y - this.largura, this.largura, this.largura);
    
  }
}
