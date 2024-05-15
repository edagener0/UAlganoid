class BigMessage
{
  float x;
  float y;
  color cor;
  String texto;
  float start_time;
  float display_time;
  float opacity;
  float opacity_decreaser;  
  BigMessage ()
  {
    this.texto = "";
    this.x = LARGURA_JANELA / 2;
    this.y = ALTURA_JANELA / 2;
    this.opacity = 0;
  }

  
  //255 / display_time = TEMOS QUE SUBTRAIR A CADA SEGUNDO 
  void display(String texto, color cor, int display_time)
  {
    this.opacity = 255;
    this.start_time = millis();
    this.texto = texto;
    this.cor = cor;
    this.display_time = display_time;
    this.opacity_decreaser = 10;
  }
  
  void draw()
  {
    if (millis() - this.start_time >= this.display_time)
    {
      this.opacity -= this.opacity_decreaser;
      if (this.opacity <= 0) return;
    }
    fill(this.cor, this.opacity);
    textSize(1.75 * LARGURA_BLOCO);
    textAlign(CENTER, CENTER);
    text(this.texto, this.x, this.y);
  }
};
