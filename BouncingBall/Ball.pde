class Ball
{
  float diametro;
  float raio;
  color cor;
  
  PVector posicao;
  PVector velocidade;
  
  boolean on_fire;
  
  
  
  Ball (float x, float y, float diametro, color cor)
  {
    this.posicao = new PVector(x, y);
    this.velocidade = new PVector(0, 0);
    this.diametro = diametro;
    this.raio = diametro / 2;
    this.cor = cor;
    
    this.on_fire = false;
  }
  
  void colisao_pad(Pad pad)
  {
    if (!game_on) return;
    
    PVector nova_posicao = this.posicao.copy();
    
    nova_posicao.add(velocidade);
    
    float distancia = this.posicao.x - pad.posicao.x;
    
    //float teta = 1.285714286 * distancia;
    //println(45 / (LARGURA_PAD));
    float teta = (90 / (pad.max_x - pad.min_x)) * distancia;
    
    float ponto_contacto = 0;
    
    if (nova_posicao.x >= pad.min_x && nova_posicao.x <= pad.max_x)
    {
      ponto_contacto = nova_posicao.x;
    } else if (nova_posicao.x <= pad.min_x)
    {
      ponto_contacto = pad.min_x;
    } else if (nova_posicao.x >= pad.max_x)
    {
      ponto_contacto = pad.max_x;
    }
    
    if (teta > 45)
    {
      teta = 45;
    }
    else if (teta < -45)
    {
      teta = -45;
    }
    
    teta = radians(teta);
    
    //println("pad:", pad.posicao.x, pad.posicao.y, pad.min_x, pad.max_x, "ponto de contacto:", ponto_contacto);
    
    //this.posicao.y > pad.min_y && pad.min_x - this.posicao.x <= 0 && pad.max_x - this.posicao.x >= 0
    //println(teta, degrees(teta));
    if (((ponto_contacto - this.posicao.x)*(ponto_contacto - this.posicao.x)) + ((pad.min_y-this.posicao.y)*(pad.min_y-this.posicao.y)) <= this.raio*this.raio)
    {
      println("1");
      this.velocidade.y *= -1;
      pad_bounce.play();
      //this.velocidade.rotate(PI);
      //this.velocidade.rotate(teta);
      PVector.fromAngle(teta - HALF_PI, this.velocidade);
      this.velocidade.setMag(BOLA_MODULO_VEL);
      this.posicao.y = pad.min_y - this.raio;
      
    }
    //println(degrees(teta), degrees(velocidade.heading()));
  }
  
  void colisao_parede(Pad pad, Header header)
  {
    if (((MIN_BORDER_Y-this.posicao.y)*(MIN_BORDER_Y-this.posicao.y)) <= this.raio*this.raio)
    {
      this.velocidade.y *= -1;
      this.posicao.y = MIN_BORDER_Y + this.raio;
    }
    else if (((MIN_BORDER_X - this.posicao.x)*(MIN_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      this.velocidade.x *= -1;
      this.posicao.x = MIN_BORDER_X + this.raio;
    }
    else if (((MAX_BORDER_X - this.posicao.x)*(MAX_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      this.velocidade.x *= -1;
      this.posicao.x = MAX_BORDER_X - this.raio;
    }
    else if (this.posicao.y > MAX_BORDER_Y)
    {
      reset(pad);
      header.lives--;
    }
  }
  
  void colisao_blocos(Block[][] blocos, Header header)
  {
    PVector nova_posicao = this.posicao.copy();
    
    nova_posicao.add(velocidade);
    
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
        
        if (nova_posicao.x >= bloco.min_x && nova_posicao.x <= bloco.max_x)
        {
          ponto_contacto_x = nova_posicao.x;
          tocou_x = true;
        } 
        else if (nova_posicao.x <= bloco.min_x)
        {
          ponto_contacto_x = bloco.min_x;
        } 
        else if (nova_posicao.x >= bloco.max_x)
        {
          ponto_contacto_x = bloco.max_x;
        }
        
        if (nova_posicao.y >= bloco.min_y && nova_posicao.y <= bloco.max_y)
        {
          ponto_contacto_y = nova_posicao.y;
          tocou_y = true;
        } 
        else if (nova_posicao.y <= bloco.min_y)
        {
          ponto_contacto_y = bloco.min_y;
        } 
        else if (nova_posicao.y >= bloco.max_y)
        {
          ponto_contacto_y = bloco.max_y;
        }
        
        
        
        if (bloco.vida != 0 && ((ponto_contacto_x - this.posicao.x)*(ponto_contacto_x - this.posicao.x)) + ((ponto_contacto_y-this.posicao.y)*(ponto_contacto_y-this.posicao.y)) <= this.raio*this.raio)
        {
          if (!bolas.get(0).on_fire) //!bolas.get(0).on_fire
          {
            println("primeiro");
            if ((ponto_contacto_x == bloco.min_x || ponto_contacto_x == bloco.max_x) && (ponto_contacto_y == bloco.min_y || ponto_contacto_y == bloco.max_y))
            {
              
              this.velocidade.x *= -1;
              this.velocidade.y *= -1;
            }
            else if (nova_posicao.x == ponto_contacto_x)
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
            else if (nova_posicao.y == ponto_contacto_y  && bloco.vida != -1)
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
          }
          else if (bolas.get(0).on_fire && bloco.vida == -1)
          {
            println("segundo");
            if ((ponto_contacto_x == bloco.min_x || ponto_contacto_x == bloco.max_x) && (ponto_contacto_y == bloco.min_y || ponto_contacto_y == bloco.max_y))
            {
              
              this.velocidade.x *= -1;
              this.velocidade.y *= -1;
            }
            else if (nova_posicao.x == ponto_contacto_x)
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
            else if (nova_posicao.y == ponto_contacto_y  && bloco.vida != -1)
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
          }
          
          
          if (bloco.vida > 0 || bloco.vida_on_fire > 0)
          {
            block_hit.play();
            //verificar se alguma bola esta com fogo
            if (bolas.get(0).on_fire)
            {
              bloco.vida_on_fire--;
            }
            else bloco.vida--;
          }
          if (bloco.vida == 0 || bloco.vida_on_fire == 0)
          {
            bloco.destruir(header);
          }
          return;
        }
        
        
      }
    }
  }
  
  void detetar_colisoes(Pad pad, Block[][] blocos, Header header)
  {
    colisao_pad(pad);
    colisao_parede(pad, header);
    colisao_blocos(blocos, header);
  }
  
  void before_game(Pad pad, boolean game_on, boolean lost)
  {
    if (game_on)
    {
      return;
    }
    
    this.posicao.x = pad.posicao.x;
  }
  
  void lancar_bola(Pad pad)
  {
    if (game_on) return;
    
    this.velocidade.y = -1;
    this.velocidade.setMag(BOLA_MODULO_VEL);
    
    if (pad.velocidade.x > 0)
    {
      this.velocidade.rotate(radians(45));
    }
    else if (pad.velocidade.x < 0)
    {
      this.velocidade.rotate(radians(-45));
    }
    else
    {
      this.velocidade.rotate(0);
    }
  }
  
  void reset(Pad pad)
  {
    this.posicao.x = pad.posicao.x;
    this.posicao.y = POSICAO_Y_BOLA;
    bola.velocidade.y = 0;
    bola.velocidade.x = 0;
    game_on = false;
  }
  
  void is_on_fire()
  {
    if (this.on_fire) 
    {
      this.cor = RED;
    }
    else
    {
      this.cor = GRAY;
    }
  }
  
  void update() 
  {
    is_on_fire();
    this.posicao.add(velocidade);
  }
 
  void draw()
  {
    update();
    fill(this.cor);
    circle(this.posicao.x, this.posicao.y, this.diametro);
  }
}
