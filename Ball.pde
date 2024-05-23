class Ball
{
  private int intervalo_frame = 5;
  private int intervalo_frame_atual = 0;

  float diametro;
  float raio;
  color cor;

  PVector posicao;
  PVector velocidade;

  boolean on_fire;

  PImage imagem;

  int frame;

  Ball (float x, float y, float vel_x, float vel_y, float diametro, color cor, boolean on_fire)
  {
    this.posicao = new PVector(x, y);
    this.velocidade = new PVector(vel_x, vel_y);
    this.diametro = diametro;
    this.raio = diametro / 2;
    this.cor = cor;
    
    this.on_fire = on_fire;
    
    this.imagem = imagem_bola;
  }


  // ---------------------------------------------------------------
  // Função responsável por inverter o sentido da velocidade da bola
  // ---------------------------------------------------------------
  void inverter_mov(boolean x, boolean y)
  {
    if (x) this.velocidade.x *= -1;
    if (y) this.velocidade.y *= -1;
  }


  // ------------------------------------------
  // Função responsável por criar uma deep copy
  // ------------------------------------------
  Ball deep_copy()
  {
    return new Ball(this.posicao.x, this.posicao.y, this.velocidade.x, this.velocidade.y, this.diametro, this.cor, this.on_fire);
  }


  // --------------------------------------------------------------------------------------------------
  // Função responsável por detetar colisões com o pad e inverter o movimento da bola no angulo correto
  // --------------------------------------------------------------------------------------------------
  void colisao_pad(Pad pad)
  {
    // return caso o jogo ainda não tenha começado, evitando calculos desnecessários
    if (!game_on) return;
    
    // criação de um vetor temporário que está um frame à frente
    PVector nova_posicao = this.posicao.copy();
    
    nova_posicao.add(velocidade);
    
    // calculo da distancia entre a bola e o centro do pad
    float distancia = this.posicao.x - pad.posicao.x;
    
    // angulo utilizado para alterar o angulo do movimento da bola quando bate com o pad
    float teta = (90 / (pad.max_x - pad.min_x)) * distancia;
    
    // variavel que guarda o ponto de contacto entre a bola e o pad
    float ponto_contacto = 0;

    // calculo do ponto de contacto
    if (nova_posicao.x >= pad.min_x && nova_posicao.x <= pad.max_x) ponto_contacto = nova_posicao.x;
    else if (nova_posicao.x <= pad.min_x)                           ponto_contacto = pad.min_x;
    else if (nova_posicao.x >= pad.max_x)                           ponto_contacto = pad.max_x;

    // valor maximo e minimo do teta
    if (teta > 45)       teta = 45;
    else if (teta < -45) teta = -45;

    teta = radians(teta);

    // detetar colisão
    if (((ponto_contacto - this.posicao.x)*(ponto_contacto - this.posicao.x)) + ((pad.min_y-this.posicao.y)*(pad.min_y-this.posicao.y)) <= this.raio*this.raio)
    {
      inverter_mov(false, true);
      pad_bounce.play();
      
      // vetor velocidade recebe um novo angulo, baseado no teta calculado anteriormente
      PVector.fromAngle(teta - HALF_PI, this.velocidade);
      this.velocidade.setMag(BOLA_MODULO_VEL);
      
      // offset para evitar que a bola entre no pad
      this.posicao.y = pad.min_y - this.raio;
    }
  }


  // -----------------------------------------------------------------------------------
  // Função responsável por detetar colisões com a parede e inverter o movimento da bola
  // -----------------------------------------------------------------------------------
  void colisao_parede(Pad pad, Header header)
  {
    if (((MIN_BORDER_Y-this.posicao.y)*(MIN_BORDER_Y-this.posicao.y)) <= this.raio*this.raio)
    {
      // colisao no topo
      inverter_mov(false, true);
      this.posicao.y = MIN_BORDER_Y + this.raio;
    }
    else if (((MIN_BORDER_X - this.posicao.x)*(MIN_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      // colisao do lado esquerdo
      inverter_mov(true, false);
      this.posicao.x = MIN_BORDER_X + this.raio;
    }
    else if (((MAX_BORDER_X - this.posicao.x)*(MAX_BORDER_X - this.posicao.x)) <= this.raio*this.raio)
    {
      // colisao do lado direito
      inverter_mov(true, false);
      this.posicao.x = MAX_BORDER_X - this.raio;
    }
    else if (this.posicao.y > MAX_BORDER_Y)
    {
      // verifica se a bola "caiu"
      if(bolas.size() == 1)
      {
        // caso só exista uma bola no array de bolas, é retirada uma vida
        header.lives--;
        reset(pad);
      }
    }
  }


  // -------------------------------------------------------------------------------------------
  // Função que após detetada uma colisão verifica em que lado foi e inverte o movimento da bola
  // -------------------------------------------------------------------------------------------
  void colisao_bloco(Block bloco, float x_prox, float y_prox)
  {
    // colisão horizontal
    if (x_prox == bloco.min_x && this.velocidade.x > 0) // colisao esquerda
    {
      inverter_mov(true, false);
    }
    else if (x_prox == bloco.max_x && this.velocidade.x < 0) // colisao direita
    {
      inverter_mov(true, false);
    }
    
    // colisão vertical
    if (y_prox == bloco.min_y && this.velocidade.y > 0) // colisao cima
    {
      inverter_mov(false, true);
    }
    else if (y_prox == bloco.max_y && this.velocidade.y < 0) // colisao baixo
    {
      inverter_mov(false, true);
    }
  }


  // -------------------------------------------------------
  // Função que percorre o array de blocos e deteta colisões
  // -------------------------------------------------------
  void colisao_blocos(Block[][] blocos)
  {
    for (int i = 0; i < ROWS; i++)
    {
      for (int j = 0; j < COLS; j++)
      {
        Block bloco = blocos[i][j];

        // caso o bloco não esteja exposto, evitamos iterações e calculos desnecessários
        if (!bloco.exposto) continue;

        // calculo dos pontos de contacto mais próximos para a localização atual da bola
        float x_prox = constrain(this.posicao.x, bloco.min_x, bloco.max_x);
        float y_prox = constrain(this.posicao.y, bloco.min_y, bloco.max_y);

        // distância entre o centro da bola e o ponto de contacto mais próximo
        float dist = dist(this.posicao.x, this.posicao.y, x_prox, y_prox);

        // caso a distância entre o centro da bola e o ponto de contacto seja inferior ou igual ao raio da bola, há colisão
        if (dist <= this.raio && bloco.vida != 0)
        {
          block_hit.play();
          block_hit.amp(efeitos);
          if (bolas.get(0).on_fire && bloco.tipo == 9) 
          {
            colisao_bloco(bloco, x_prox, y_prox);
            bloco.vida_on_fire--;
          }
          else if (bolas.get(0).on_fire)
          {
            bloco.vida = 0;
          }
          else
          {
            colisao_bloco(bloco, x_prox, y_prox);
            bloco.vida--;
          }
          
          // caso o bloco tenha 0 de vida, é "destruido"
          if (bloco.vida == 0 || bloco.vida_on_fire == 0)
          {
            bloco.destruir(header);
          }
          
          // return evita que blocos que estejam proximos sejam tambem destruidos
          return;
        }
      }
    }
  }


  // -------------------------------------------------------------------------------------------------------------------
  // Função que trata de chamar todas as outras funções de verificar colisões, passando os objetos necessarios a cada uma
  // -------------------------------------------------------------------------------------------------------------------
  void detetar_colisoes(Pad pad, Block[][] blocos, Header header)
  {
    colisao_pad(pad);
    colisao_parede(pad, header);
    colisao_blocos(blocos);
  }


  // ---------------------------------------------------------------
  // Função que coloca a bola em cima do pad antes que o jogo comece
  // ---------------------------------------------------------------
  void before_game(Pad pad, boolean game_on)
  {
    // return caso a bola já esteja em movimento, ou seja, o jogo já começou
    if (game_on) return;
    // centra a bola 
    this.posicao.x = pad.posicao.x;
  }


  // --------------------------------------------------------------
  // Função que lança a bola quando a tecla de Espaço é pressionada
  // --------------------------------------------------------------
  void lancar_bola(Pad pad)
  {
    // return caso a bola já esteja em movimento, ou seja, o jogo já começou
    if (game_on) return;
    
    // vetor aponta para cima, com a magnitude especificada através da variavel global
    this.velocidade.y = -1;
    this.velocidade.setMag(BOLA_MODULO_VEL);
    
    // a direção da bola é alterada caso o pad tenha movimentação lateral quando é lançada
    if      (pad.velocidade.x > 0)  this.velocidade.rotate(radians(45));
    else if (pad.velocidade.x < 0)  this.velocidade.rotate(radians(-45));
    else                            this.velocidade.rotate(0);
  }


  // --------------------------------------------------------------------
  // Função que reseta a bola e coloca-a por cima do ponto central do pad
  // --------------------------------------------------------------------
  void reset(Pad pad)
  {
    this.posicao.x = pad.posicao.x;
    this.posicao.y = POSICAO_Y_BOLA;
    bolas.get(0).velocidade.y = 0;
    bolas.get(0).velocidade.x = 0;
    game_on = false;
  }


  // -----------------------------------------------------------------------------------
  // Função que trata de alguns elementos que necessitam de ser atualizados a cada frame
  // -----------------------------------------------------------------------------------
  void update() 
  {
    // adição do vetor velocidade à posição da bola
    this.posicao.add(velocidade);
  }


  // ------------------------------------------------------------------------------
  // Função responsável por desenhar a bola e outros elementos relacionados no ecrã
  // ------------------------------------------------------------------------------
  void draw()
  {
    if (game_ended) return;
    update();
    
    // if responsavel por desenhar a bola com cores ou com textura, dependendo se as texturas estão ligadas ou não
    if (!texturas_ligadas)
    {
      if (this.on_fire)  this.cor = RED;
      else               this.cor = GRAY;

      fill(this.cor);
      circle(this.posicao.x, this.posicao.y, this.diametro);
    }
    else
    {
      // caso on_fire é desenhada a animação, caso contrario é apenas desenhada a bola padrão
      if (this.on_fire)
      {
        intervalo_frame_atual++;
        if (intervalo_frame_atual >= intervalo_frame)
        {
          intervalo_frame_atual = 0;
          frame++;
        }
        if (frame > 9) frame = 0;
        this.imagem = bola_on_fire[frame];
      }
      else this.imagem = imagem_bola;

      image(this.imagem, this.posicao.x - this.raio, this.posicao.y - this.raio, this.diametro, this.diametro);
    }
  }
}
