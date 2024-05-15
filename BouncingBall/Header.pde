class Header
{
  float x_title;
  float y_title;
  
  int score;
  int lives;
  
  float altura_texto_lateral;
  
  Header (float x_title, float y_title)
  {
    this.x_title = x_title;
    this.y_title = y_title;
    this.score = 0;
    this.lives = VIDAS;
    this.altura_texto_lateral = ALTURA_HEADER - ALTURA_BLOCO;
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
  
  
  void draw()
  {
    fill(200, 0, 200);
    textSize(1 * LARGURA_BLOCO);
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
