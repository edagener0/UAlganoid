class Header
{
  float x_title;
  float y_title;
  
  int score;
  int lives;
  
  float altura_texto_lateral;
  
  PVector posicao;
  
  PImage imagem;
  Header (float x_title, float y_title)
  {
    this.posicao = new PVector(LARGURA_JANELA / 2, ALTURA_HEADER / 2);
    this.x_title = x_title;
    this.y_title = y_title;
    this.score = 0;
    this.lives = VIDAS;
    this.altura_texto_lateral = ALTURA_HEADER - ALTURA_BLOCO;
    this.imagem = imagem_header;
  }
  
  boolean have_lives()
  {
    if (lives <= 0) return false;
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
    fill(BLACK);
    //rectMode(CENTER);
    //rect(this.posicao.x, this.posicao.y, LARGURA_JANELA, ALTURA_HEADER);
    image(this.imagem, 0, 0, LARGURA_JANELA, ALTURA_HEADER);
    
  }
  
  
  void draw()
  {
    display_background();
    fill(200, 0, 200);
    textSize(1 * LARGURA_BLOCO);
    textFont(fonte);
    textAlign(CENTER, CENTER);
    text("UALGANOID", this.x_title, this.y_title);
    
    //texto lateral
    fill(WHITE);
    textSize(0.6 * LARGURA_BLOCO);
    textAlign(LEFT, CENTER);
    text("Score: " + this.score, MIN_BORDER_X, this.altura_texto_lateral);
    
    fill(WHITE);
    textSize(0.6 * LARGURA_BLOCO);
    textAlign(RIGHT, CENTER);
    text("Lives: " + this.lives, MAX_BORDER_X, this.altura_texto_lateral);
  }
}
