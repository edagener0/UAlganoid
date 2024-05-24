class Header
{
  float x_title;
  float y_title;

  int score;
  int lives;

  float altura_texto_lateral;
  int last_score;
  
  float display_time;
  float start_time;
  PVector posicao;

  float opacidade_last_score;
  PImage imagem;
  boolean showing_score;
  
  int frame = 0;
  int intervalo_frame_atual = 0;
  int intervalo_frame = 3;
  
  PImage imagem_x5;
  
  Header (float x_title, float y_title)
  {
    this.posicao = new PVector(LARGURA_JANELA / 2, ALTURA_HEADER / 2);
    this.x_title = x_title;
    this.y_title = y_title;
    this.altura_texto_lateral = ALTURA_HEADER - ALTURA_BLOCO * 0.7;
    
    this.score = 0;
    this.last_score = 0;
    
    this.lives = VIDAS;
    
    this.imagem = imagem_header;
    
    this.display_time = 5000;
    this.start_time = 0;
    
    this.showing_score = false;
    this.opacidade_last_score = 0;
    
    this.imagem_x5 = multiplier_image[frame];
  }

  boolean have_lives()
  {
    if (this.lives <= 0) return false;
    else return true;
  }

  void ganhou_nivel()
  {
    if (score_atual == max_score)
    {
      won_level = true;
    }
  }

  void display_background()
  {
    if (!texturas_ligadas)
    {
      fill(BLACK);
      rectMode(CENTER);
      rect(this.posicao.x, this.posicao.y, LARGURA_JANELA, ALTURA_HEADER);
    }
    else image(this.imagem, 0, 0, LARGURA_JANELA, ALTURA_HEADER);
  }

  void mostrar_score_ganho(int score_ganho)
  {
    this.last_score = score_ganho;
    this.opacidade_last_score = 255;
  }

  void has_passed()
  {
    if (millis() - this.start_time >= this.display_time)
    {
      this.start_time = 0;
      this.showing_score = false;
    }
  }


  void draw()
  {
    display_background();
    fill(WHITE);
    textSize(LARGURA_BLOCO);
    textAlign(CENTER, CENTER);
    text("UALGANOID", this.x_title, this.y_title);

    //texto lateral
    fill(WHITE);
    textSize(0.5 * LARGURA_BLOCO);
    textAlign(LEFT, CENTER);
    text("Score: " + this.score, MIN_BORDER_X, this.altura_texto_lateral);

    fill(WHITE);
    textSize(0.5 * LARGURA_BLOCO);
    textAlign(RIGHT, CENTER);
    text("Lives: " + this.lives, MAX_BORDER_X, this.altura_texto_lateral);
    
    if (this.last_score != 0)
    {
      fill(WHITE, this.opacidade_last_score);
      textSize(LARGURA_BLOCO / 3);
      textAlign(CENTER, CENTER);
      text("+" + this.last_score, LARGURA_JANELA / 2, this.altura_texto_lateral + ALTURA_BLOCO / 5);
    }
    this.opacidade_last_score -= 5;
    if (this.opacidade_last_score < 0) this.opacidade_last_score = 0;
    
    if (multiplier == 5 && score_multipliers.size() != 0)
    {
      intervalo_frame_atual++;
      if(intervalo_frame_atual > intervalo_frame)
      {
        intervalo_frame_atual = 0;
        frame++;
      }
      if (frame > 3) frame = 0;
      image(multiplier_image[frame], MIN_BORDER_X, this.altura_texto_lateral - ALTURA_BLOCO * 1.5, LARGURA_BLOCO / 2, LARGURA_BLOCO / 2);
    }
  }
}
