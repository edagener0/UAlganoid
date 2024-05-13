class Ball
{
  float diametro;
  float raio;
  color cor;
  
  PVector posicao;
  PVector velocidade;
  
  Ball (float x, float y, float diametro, color cor)
  {
    this.posicao = new PVector(x, y);
    this.velocidade = new PVector(0, 0);
    this.diametro = diametro;
    this.raio = diametro / 2;
    this.cor = cor;
  }
  
  void colisao_pad(Pad pad)
  {
    float distancia = this.posicao.x - pad.posicao.x;
    
    float teta = radians(1.285714286 * distancia);
    
    float ponto_contacto = 0;
    
    if (this.posicao.x >= pad.min_x && this.posicao.x <= pad.max_x)
    {
      ponto_contacto = this.posicao.x;
    } else if (this.posicao.x <= pad.min_x)
    {
      ponto_contacto = pad.min_x;
    } else if (this.posicao.x >= pad.max_x)
    {
      ponto_contacto = pad.max_x;
    }
    
    //println("pad:", pad.posicao.x, pad.posicao.y, pad.min_x, pad.max_x, "ponto de contacto:", ponto_contacto);
    
    //this.posicao.y > pad.min_y && pad.min_x - this.posicao.x <= 0 && pad.max_x - this.posicao.x >= 0
    println(teta, degrees(teta));
    if (((ponto_contacto - this.posicao.x)*(ponto_contacto - this.posicao.x)) + ((pad.min_y-this.posicao.y)*(pad.min_y-this.posicao.y)) <= this.raio*this.raio)
    {
      this.velocidade.y *= -1;
      this.velocidade.x = BOLA_MODULO_VEL * sin(teta);
      this.posicao.y = pad.min_y - this.raio;
    }
  }
  
  void colisao_parede(Border parede)
  {
    if (((ALTURA_BLOCO-this.posicao.y)*(ALTURA_BLOCO-this.posicao.y)) <= this.raio*this.raio)
    {
      this.velocidade.y *= -1;
      this.posicao.y = ALTURA_BLOCO + this.raio;
    } else if (((MIN_BORDER_X - this.posicao.x)*(MIN_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      this.velocidade.x *= -1;
      this.posicao.x = MIN_BORDER_X + this.raio;
    } else if (((MAX_BORDER_X - this.posicao.x)*(MAX_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      this.velocidade.x *= -1;
      this.posicao.x = MAX_BORDER_X - this.raio;
    }
  }
  
  void colisao_blocos(Block[][] blocos)
  {
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        Block bloco = blocos[i][j];
        
        if (!bloco.exposto) continue;
        
        float ponto_contacto_x = 0;
        float ponto_contacto_y = 0;
        
        boolean tocou_x = false;
        boolean tocou_y = false;
        
        if (this.posicao.x >= bloco.min_x && this.posicao.x <= bloco.max_x)
        {
          ponto_contacto_x = this.posicao.x;
          tocou_x = true;
        } 
        else if (this.posicao.x <= bloco.min_x)
        {
          ponto_contacto_x = bloco.min_x;
        } 
        else if (this.posicao.x >= bloco.max_x)
        {
          ponto_contacto_x = bloco.max_x;
        }
        
        if (this.posicao.y >= bloco.min_y && this.posicao.y <= bloco.max_y)
        {
          ponto_contacto_y = this.posicao.y;
          tocou_y = true;
        } 
        else if (this.posicao.y <= bloco.min_y)
        {
          ponto_contacto_y = bloco.min_y;
        } 
        else if (this.posicao.y >= bloco.max_y)
        {
          ponto_contacto_y = bloco.max_y;
        }
        
        
        if (bloco.vida != 0 && ((ponto_contacto_x - this.posicao.x)*(ponto_contacto_x - this.posicao.x)) + ((ponto_contacto_y-this.posicao.y)*(ponto_contacto_y-this.posicao.y)) <= this.raio*this.raio)
        {
          if ((ponto_contacto_x == bloco.min_x || ponto_contacto_x == bloco.max_x) && (ponto_contacto_y == bloco.min_y || ponto_contacto_y == bloco.max_y))
          {
            this.velocidade.x *= -1;
            this.velocidade.y *= -1;
          }
          if (this.posicao.x == ponto_contacto_x)
          {
            this.velocidade.y *= -1;
            if (ponto_contacto_y > bloco.y)
            {
              this.posicao.y = ponto_contacto_y + this.raio;
            }
            else if (ponto_contacto_y < bloco.y)
            {
              this.posicao.y = ponto_contacto_y - this.raio;
            }
          } 
          else if (this.posicao.y == ponto_contacto_y)
          {
            this.velocidade.x *= -1;
            if (ponto_contacto_x > bloco.x)
            {
              this.posicao.x = ponto_contacto_x + this.raio;
            }
            else if (ponto_contacto_x < bloco.x)
            {
              this.posicao.x = ponto_contacto_x - this.raio;
            }
          }
          
          bloco.vida = 0;
          return;
        }
        
        
      }
    }
  }
  
  void detetar_colisoes(Border border, Pad pad, Block[][] blocos)
  {
    colisao_pad(pad);
    colisao_parede(border);
    colisao_blocos(blocos);
  }
  
  void update() {
    this.posicao.add(velocidade);
  }
 
  void draw()
  {
    update();
    fill(this.cor);
    circle(this.posicao.x, this.posicao.y, this.diametro);
  }
}
