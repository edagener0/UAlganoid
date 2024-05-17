class Block
{
  float x;
  float y;
  
  float min_x;
  float max_x;
  
  float min_y;
  float max_y;
  
  float largura;
  float altura;
  
  color cor;
  
  int vida;
  int vida_on_fire;
  
  int score;
  
  
  int tipo;
  
  boolean exposto;
  
  Block(float x, float y, float largura, int tipo, boolean exposto)
  {
    this.x = x;
    this.y = y;
    
    this.largura = largura;
    this.altura = this.largura / 2;
    
    this.min_x = this.x - this.largura / 2;
    this.max_x = this.x + this.largura / 2;
    
    this.min_y = this.y - this.altura / 2 + ALTURA_HEADER;
    this.max_y = this.y + this.altura / 2 + ALTURA_HEADER;
    
    //this.cor = cor;
    //this.vida = vida;
    this.tipo = tipo;
    
    this.exposto = exposto;
    this.vida_on_fire = 1;
    
    switch (this.tipo)
    {
      case 0:
        this.vida = 0;
        this.cor = INVISIBLE;
        this.exposto = false;
        break;
      case 1:
        this.vida = 1;
        this.cor = WHITE;
        this.score = 50;
        break;
      case 2:
        this.vida = 1;
        this.cor = ORANGE;
        this.score = 60;
        break;
      case 3:
        this.vida = 1;
        this.cor = CYAN;
        this.score = 70;
        break;
      case 4:
        this.vida = 1;
        this.cor = GREEN;
        this.score = 80;
        break;
      case 5:
        this.vida = 1;
        this.cor = RED;
        this.score = 90;
        break;
      case 6:
        this.vida = 1;
        this.cor = BLUE;
        this.score = 100;
        break;
      case 7:
        this.vida = 1;
        this.cor = PURPLE;
        this.score = 110;
        break;
      case 8:
        this.vida = 2;
        this.cor = SILVER;
        this.score = 200;
        break;
      case 9:
        this.vida = -1;
        this.cor = GOLD;
        this.vida_on_fire = 2;
        this.score = 1000;
        break;
      default:
        //exit
        this.vida = 0;
        this.cor = INVISIBLE;
        this.exposto = false;
        break;
    }
  }
  
  void destruir(Header header)
  {
    this.vida = 0;
    this.cor = INVISIBLE;
    this.exposto = false;
    header.score += this.score;
    
    //RANDOM RETORNA FLOAT OH NAO BOOM BOOM BOOM
    if (1 == int(random(1, MAX_RANDOM_CHANCE + 1)))
    {
      //METE FLOAT AQUI PARA COMPROVAR
      int tipo_powerup = int(random(0, 2));
      //println("tipo", tipo_powerup);
      switch (tipo_powerup)
      {
        case 0:
          BallTriplicator triplicador = new BallTriplicator(this.x, this.y, tipo_powerup, true);
          triplicators.add(triplicador);
          break;
          
        case 1:
          Fireball fireball = new Fireball(this.x, this.y, tipo_powerup);
          fireballs.add(fireball);
          break;
        //FALTA FAZER O CASE 1
      }
    }
    if (this.tipo != 9) score_atual += this.score;
  }
  
  void draw()
  {
    if (this.vida == 0) return;
    //if (this.exposto) fill(RED);
    //else fill(this.cor);
    fill(this.cor);
    stroke(0);
    strokeWeight(LARGURA_BLOCO * 0.01);
    rectMode(CENTER);
    rect(this.x, this.y + ALTURA_HEADER, this.largura, this.altura);
    noStroke();
  }
  
}
