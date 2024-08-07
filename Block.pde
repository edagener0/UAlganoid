class Block
{
  private final int intervalo_frames = 5;
  private int intervalo_frames_atual = 0;
  
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
  PImage imagem;
  
  int frame_atual = 0;
  
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
        this.imagem = type_1_block;
        break;
      case 2:
        this.vida = 1;
        this.cor = ORANGE;
        this.score = 60;
        this.imagem = type_2_block;
        break;
      case 3:
        this.vida = 1;
        this.cor = CYAN;
        this.score = 70;
        this.imagem = type_3_block;
        break;
      case 4:
        this.vida = 1;
        this.cor = GREEN;
        this.score = 80;
        this.imagem = type_4_block;
        break;
      case 5:
        this.vida = 1;
        this.cor = RED;
        this.score = 90;
        this.imagem = type_5_block;
        break;
      case 6:
        this.vida = 1;
        this.cor = BLUE;
        this.score = 100;
        this.imagem = type_6_block;
        break;
      case 7:
        this.vida = 1;
        this.cor = PURPLE;
        this.score = 110;
        this.imagem = type_7_block;
        break;
      case 8:
        this.vida = 2;
        this.cor = SILVER;
        this.score = 200;
        this.imagem = type_8_block[frame_atual];
        break;
      case 9:
        this.vida = -1;
        this.cor = GOLD;
        this.vida_on_fire = 2;
        this.score = 1000;
        this.imagem = type_9_block[frame_atual];
        break;
      default:
        //exit
        this.vida = 0;
        this.cor = INVISIBLE;
        this.exposto = false;
        break;
    }
  }


  void destruir()
  {
    this.vida = 0;
    this.cor = INVISIBLE;
    this.exposto = false;
    
    int last_score = this.score * multiplier;
    header.score += last_score;
    
    if (1 == int(random(1, MAX_RANDOM_CHANCE + 1)))
    {
      int tipo_powerup = int(random(0, 4));
      switch (tipo_powerup)
      {
        case 0:
          BallTriplicator triplicador = new BallTriplicator(this.x, this.y, tipo_powerup);
          triplicators.add(triplicador);
          break;
          
        case 1:
          Fireball fireball = new Fireball(this.x, this.y, tipo_powerup);
          fireballs.add(fireball);
          break;
        case 2:
          AddLife life_adder = new AddLife(this.x, this.y, tipo_powerup);
          life_adders.add(life_adder);
        //FALTA FAZER O CASE 1
        case 3:
          ScoreMultiplier score_multiplier = new ScoreMultiplier(this.x, this.y, tipo_powerup);
          score_multipliers.add(score_multiplier);
      }
    }
    header.mostrar_score_ganho(last_score);
    
    if (this.tipo != 9) score_atual += this.score;
  }


  void draw()
  {
    if (this.vida == 0) return;
    intervalo_frames_atual++;
    if (this.tipo == 8) 
    {
      if (intervalo_frames_atual >= intervalo_frames) this.imagem = type_8_block[frame_atual++];
    }
    else if (this.tipo == 9) 
    {
      if (intervalo_frames_atual >= intervalo_frames) this.imagem = type_9_block[frame_atual++];
    }
    
    if (frame_atual >= 20) frame_atual = 0;
    if (intervalo_frames_atual >= intervalo_frames) intervalo_frames_atual = 0;
    if (!texturas_ligadas)
    {
      fill(this.cor);
      rectMode(CENTER);
      rect(this.x, this.y + ALTURA_HEADER, this.largura, this.altura, LARGURA_BLOCO * 0.1);
      noStroke();
    }
    else
    {
      image(this.imagem, this.x - this.largura / 2, this.y + ALTURA_HEADER - this.altura / 2, this.largura, this.altura);
      if (this.tipo == 8 && this.vida == 1)
      {
          image(damaged_block, this.x - this.largura / 2, this.y + ALTURA_HEADER - this.altura / 2, this.largura, this.altura);
      }
      if (this.tipo == 9 && this.vida_on_fire == 1)
      {
          image(damaged_block, this.x - this.largura / 2, this.y + ALTURA_HEADER - this.altura / 2, this.largura, this.altura);
      }
      
    }
  }
  
}
