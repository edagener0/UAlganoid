class Ball
{
  private final float RANGE_ANGULO = 15;
  float diametro;
  float raio;
  color cor;
  
  PVector posicao;
  PVector velocidade;
  
  boolean on_fire;
  
  
  
  Ball (float x, float y, float vel_x, float vel_y, float diametro, color cor, boolean on_fire)
  {
    this.posicao = new PVector(x, y);
    this.velocidade = new PVector(vel_x, vel_y);
    this.diametro = diametro;
    this.raio = diametro / 2;
    this.cor = cor;
    
    this.on_fire = on_fire;
  }
  
  Ball deep_copy()
  {
    return new Ball(this.posicao.x, this.posicao.y, this.velocidade.x, this.velocidade.y, this.diametro, this.cor, this.on_fire);
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
  /*
  void remove_balls()
  {
    for (int i = 0; i < bolas.size(); i++)
    {
      if (this.posicao.y > MAX_BORDER_Y)
      {
        bolas.remove(i);
      }
    }
  }*/
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
      if(bolas.size() == 1)
      {
        header.lives--;
        reset(pad);
      }
    }
  }
  void inverter(float angulo, boolean inverter_x, boolean inverter_y)
  {
    if (inverter_x) this.velocidade.x *= -1;
    if (inverter_y) this.velocidade.y *= -1;
    
    PVector temp = new PVector();
    temp.setMag(BOLA_MODULO_VEL);
    
    PVector.fromAngle(angulo - PI, temp);
    
    bola.posicao.add(temp);
  }
  /*
  void inverter_y(float angulo)
  {
    this.velocidade.y *= -1;
    
    PVector temp = new PVector();
    temp.setMag(BOLA_MODULO_VEL);
    
    PVector.fromAngle(angulo - PI, temp);
    
    bola.posicao.add(temp);
  }*/
  
  void colisao_bloco(float angulo, float angulo_vetor)
  {
    if (angulo <= 315 - RANGE_ANGULO && angulo >= 225 + RANGE_ANGULO) //bateu em baixo
    {
      inverter(angulo_vetor, false, true);
    }
    else if (angulo <= 225 - RANGE_ANGULO && angulo >= 135 + RANGE_ANGULO) //bateu em esquerda
    {
      inverter(angulo_vetor, true, false);
    }
    else if (angulo <= 135 - RANGE_ANGULO && angulo >= 45 + RANGE_ANGULO) //bateu em cima
    {
      inverter(angulo_vetor, false, true);
    }
    else if (angulo <= 45 - RANGE_ANGULO && angulo >= 315 + RANGE_ANGULO) //bateu à direita
    {
      inverter(angulo_vetor, true, false);
    }
    else inverter(angulo_vetor, true, true);
  }
  
  void colisao_blocos(Block[][] blocos)
  {
    
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        //println(i,j, ROWS, COLS);
        Block bloco = blocos[i][j];
        //println(bloco.exposto);
        
        if (!bloco.exposto) continue;
        
        float x_mais_proximo = constrain(this.posicao.x, bloco.min_x, bloco.max_x);
        float y_mais_proximo = constrain(this.posicao.y, bloco.min_y, bloco.max_y);
        //println(x_mais_proximo,y_mais_proximo);
        
        //calculo da equação do circulo para ver se o ponto pertence ou não à circunferencia
        float distancia_x = this.posicao.x - x_mais_proximo;
        float distancia_y = this.posicao.y - y_mais_proximo;
        float distancia = distancia_x * distancia_x + distancia_y * distancia_y;
        
        PVector vetor_colisao = new PVector(x_mais_proximo, y_mais_proximo);
        
        vetor_colisao.sub(this.posicao);
        vetor_colisao.normalize();
          
        float angulo = 360 - degrees(vetor_colisao.heading() + PI);
        float angulo_vetor = vetor_colisao.heading();
        
        if (distancia <= this.raio * this.raio && bloco.vida != 0) // colisao
        {
          
          println("bloco.tipo:",bloco.tipo);
          
          if (!bolas.get(0).on_fire)
          {
            colisao_bloco(angulo, angulo_vetor);
            bloco.vida--;
            if (bloco.vida == 0)
            {
              bloco.destruir(header);
            }
            return;
          }
          
          if (bolas.get(0).on_fire && bloco.tipo == 9)
          {
            colisao_bloco(angulo, angulo_vetor);
            if (bloco.vida_on_fire > 0)
            {
              block_hit.play();
              //verificar se alguma bola esta com fo
              bloco.vida_on_fire--;
              if (bloco.vida_on_fire == 0)
              {
                bloco.destruir(header);
              }
              return;
            }
          }
          
          if (bolas.get(0).on_fire)
          {
            //colisao_bloco(angulo, angulo_vetor);
            if (bloco.vida_on_fire > 0)
            {
              block_hit.play();
              //verificar se alguma bola esta com fo
              bloco.vida_on_fire--;
              if (bloco.vida_on_fire == 0)
              {
                bloco.destruir(header);
              }
              return;
            }
          }
        }
      }        
    }
  }
  
  /*
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
  }*/
  
  void detetar_colisoes(Pad pad, Block[][] blocos, Header header)
  {
    colisao_pad(pad);
    colisao_parede(pad, header);
    colisao_blocos(blocos);
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
    bolas.get(0).velocidade.y = 0;
    bolas.get(0).velocidade.x = 0;
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
