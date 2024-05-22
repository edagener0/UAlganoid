import processing.sound.*;

SoundFile VICTORY;
SoundFile DEFEAT;
SoundFile block_hit;
SoundFile pad_bounce;

SoundFile music;

//declarar imagens dos blocos para cada tipo
//PImage type_0_block;
PImage type_1_block;
PImage type_2_block;
PImage type_3_block;
PImage type_4_block;
PImage type_5_block;
PImage type_6_block;
PImage type_7_block;

PImage[] type_8_block = new PImage[12];
PImage[] type_9_block = new PImage[12];

PImage imagem_bola;

PImage imagem_background;

PImage imagem_header;

PImage teste;

PFont fonte;


//im sad : ( 
final color INVISIBLE = color(0, 0, 0, 0);
final color GRAY = color(150, 150, 150); //O processing ja tem uma variavel predefinida gray mas como é preta preferimos substituir por uma cor mais acinzentada
final color YELLOW = color(250, 250, 0);
final color GREEN = color(100, 240, 100);
final color RED = color(240, 50, 50);
final color BLACK = color(0, 0, 0);
final color WHITE = color(255, 255, 255);
final color ORANGE = color(240, 140, 0);
final color CYAN = color(0, 225, 230);
final color BLUE = color(40, 60, 240);
final color PURPLE = color(200, 40, 250);
final color SILVER = color(180, 180, 180);
final color GOLD = color(250, 195, 50);

final color BACKGROUND_COLOR = BLACK;
final color BIGMESSAGE_COLOR = color(50, 150, 255);

final int LARGURA_BLOCO = 54;
final int ALTURA_BLOCO = LARGURA_BLOCO / 2;

final int ALTURA_HEADER = 3 * ALTURA_BLOCO;

final int LARGURA_JANELA = 14*LARGURA_BLOCO;
final int ALTURA_JANELA = LARGURA_JANELA  + ALTURA_HEADER;

final int FRAME_RATE = 60;

final float MIN_BORDER_X = LARGURA_BLOCO * 0.5;
final float MAX_BORDER_X = LARGURA_JANELA - MIN_BORDER_X;

final float MIN_BORDER_Y = ALTURA_BLOCO + ALTURA_HEADER; //rever
final float MAX_BORDER_Y = ALTURA_JANELA + ALTURA_HEADER;

final int LARGURA_PAD = 4 * LARGURA_BLOCO;
final float ALTURA_PAD = LARGURA_BLOCO * 0.5;
final float POSICAO_X_PAD = LARGURA_JANELA / 2;
final float POSICAO_Y_PAD = ALTURA_JANELA - ALTURA_BLOCO * 1.5;

final float DIAMETRO_BOLA = LARGURA_BLOCO * 0.5;
final float POSICAO_Y_BOLA = POSICAO_Y_PAD - ALTURA_PAD / 2 - DIAMETRO_BOLA / 2 - LARGURA_BLOCO * 0.01;

final float BOLA_VEL_X = 5;
final float BOLA_VEL_Y = 5;

//final float BOLA_MODULO_VEL = sqrt(BOLA_VEL_X * BOLA_VEL_X + BOLA_VEL_Y * BOLA_VEL_Y);
final float BOLA_MODULO_VEL = LARGURA_BLOCO * 0.15;
final float POWERUP_MODULO_VEL = LARGURA_BLOCO * 0.025;
final float PAD_MODULO_VEL = LARGURA_BLOCO * 0.2;

final int VIDAS = 3;

final int ROWS = 15;
final int COLS = 13;
final float CHANCE_DROP_POWERUPS = 0.05; //0.05 
final float MAX_RANDOM_CHANCE = 1 / CHANCE_DROP_POWERUPS;

int MAX_NUMERO_NIVEIS = 5;

int max_score;
int score_atual;

int nivel_atual = 1;

boolean game_on = false;
boolean lost = false;

boolean won_level = false;
boolean won_game = false;

boolean[] passed_levels = new boolean[MAX_NUMERO_NIVEIS];

float on_fire_start_time;

ArrayList <Ball> bolas;

Pad pad;
Border border;
Ball bola;
BigMessage message;
Header header;

ArrayList <Fireball> fireballs;
ArrayList <BallTriplicator> triplicators;
Blocks blocos = new Blocks();


void remove_fireballs()
{
  fireballs.clear();
}

void remove_triplicators()
{
  triplicators.clear();
}

void remove_balls()
{
  bolas.clear();
}

void settings()
{
  size(LARGURA_JANELA, ALTURA_JANELA);
}


void setup()
{
  
  fonte = loadFont("title.vlw");
  type_1_block = loadImage("type_1_block.png");
  type_2_block = loadImage("type_2_block.png");
  type_3_block = loadImage("type_3_block.png");
  type_4_block = loadImage("type_4_block.png");
  type_5_block = loadImage("type_5_block.png");
  type_6_block = loadImage("type_6_block.png");
  type_7_block = loadImage("type_7_block.png");
  
  for (int i = 0; i < type_8_block.length; i++)
  {
    type_8_block[i] = loadImage(String.format("blocos_prateados/bloco%d.png", i));
  }
  
  for (int i = 0; i < type_9_block.length; i++)
  {
    type_9_block[i] = loadImage(String.format("blocos_dourados/bloco%d.png", i));
  }
  
  imagem_bola = loadImage("bola.png");
  imagem_background = loadImage("main_background.png");
  imagem_background.resize(LARGURA_JANELA, ALTURA_JANELA);
  
  imagem_header = loadImage("header.png");
  imagem_header.resize(LARGURA_JANELA, ALTURA_HEADER);
  
  teste = loadImage("border.png");
  teste.resize(LARGURA_JANELA, ALTURA_JANELA);
  
  music = new SoundFile(this, "one_more_day.ogg");
  VICTORY = new SoundFile(this, "victory.wav");
  DEFEAT = new SoundFile(this, "defeat.wav");
  block_hit = new SoundFile(this, "hit.wav");
  pad_bounce = new SoundFile(this, "pad.wav");
  
  frameRate(FRAME_RATE);
  noStroke();
  pad = new Pad(POSICAO_X_PAD, POSICAO_Y_PAD, LARGURA_PAD, ALTURA_PAD, RED);
  border = new Border(LARGURA_BLOCO, YELLOW);
  bola = new Ball(LARGURA_JANELA/2, POSICAO_Y_BOLA, 0, 0, DIAMETRO_BOLA, GRAY, false);
  header = new Header(LARGURA_JANELA/2, ALTURA_BLOCO);
  message = new BigMessage();
  bolas = new ArrayList <Ball>();
  bolas.add(bola);
  
  fireballs = new ArrayList <Fireball>();
  triplicators = new ArrayList <BallTriplicator>();
  
  //fireball = new Fireball(pad.posicao.x, ALTURA_JANELA / 2, 0);
  //println("min: ", MIN_BORDER_X, "max: ", MAX_BORDER_X);
  
  blocos.carregar_nivel(nivel_atual, message);
  
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    passed_levels[i] = false;
  }
  
  
  
  //load images
  music.play();
}

void keyPressed()
{  
  if (keyCode == RIGHT) pad.mover_direita();
  else if (keyCode == LEFT) pad.mover_esquerda();
  else if (keyCode == 32 && !game_on) 
  {
    bolas.get(0).lancar_bola(pad);
    game_on = true;
  }
  else if (key == 'r')
  {
    bolas.get(0).reset(pad);
  }
  else if (key == 'i')
  {
    bolas.get(0).velocidade.rotate(PI);
  }
  else if (key == '1')
  {
    nivel_atual = 1;
    blocos.carregar_nivel(1, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '2')
  {
    nivel_atual = 2;
    blocos.carregar_nivel(2, message);
    bolas.get(0).reset(pad);
    pad.reset();
    
  }
  else if (key == '3')
  {
    nivel_atual = 3;
    blocos.carregar_nivel(3, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '4')
  {
    nivel_atual = 4;
    blocos.carregar_nivel(4, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '5')
  {
    nivel_atual = 5;
    blocos.carregar_nivel(5, message);
    bolas.get(0).reset(pad);
    pad.reset();
    
  }
  else if (key == '6')
  {
    //println(millis());
    message.display("ganda papada", YELLOW, 2000);
  }
  else if (key == 'w')
  {
    score_atual = max_score;
  }
}

boolean have_lives()
{
  if (!header.have_lives())
  {
    if (!lost)
    {
      message.display("Game Over!", RED, 4500);
      DEFEAT.play();
    }
    lost = true;
    return false;
  }
  return true;
}

boolean ganhou_jogo()
{
  //println(passed_levels);
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    if (!passed_levels[i]) return false;
  }
  
  if (!won_game) 
  {
    message.display("Victory!!", CYAN, 4500);
    VICTORY.play();
  }
  
  won_game = true;
  
  return true;
}

boolean ganhou()
{
  if (won_level && nivel_atual <= MAX_NUMERO_NIVEIS)
  {
    passed_levels[nivel_atual - 1] = true;
    nivel_atual++;
    blocos.carregar_nivel(nivel_atual, message);
    won_level = false;
    bolas.get(0).reset(pad);
    return true;
  }
  return false;
}

void draw()
{
  //println(bola.velocidade);
  background(imagem_background);
  if (!music.isPlaying() && music.position() >= music.duration())
  {
    music.play();
  }
  border.draw();
  pad.draw();
  for (int i = 0; i < bolas.size(); i++)
  {
    Ball temp_bola = bolas.get(i);
    temp_bola.before_game(pad, game_on, lost);
    temp_bola.detetar_colisoes(pad, blocos.blocos, header); 
  }
  blocos.verificar_blocos();
  blocos.desenhar_blocos();
  header.draw();
  message.draw();
  header.ganhou_nivel();
  
  if (!have_lives()) return;
  if (ganhou()) return;
  if (ganhou_jogo()) return;
  
  //println("BOLAS SIZE" , bolas.size());
  for (int i = 0; i < bolas.size(); i++)
  {
    if (bolas.get(i).posicao.y > MAX_BORDER_Y)
    {
      bolas.remove(i);
      continue;
    }
    //bolas.get(i).posicao.x = mouseX;
    //bolas.get(i).posicao.y = mouseY;
    bolas.get(i).draw();
  }

  for(int i = 0; i < fireballs.size(); i++)
  {
    fireballs.get(i).draw();
  }
  
  for (int i = 0; i < triplicators.size(); i++)
  {
    triplicators.get(i).draw();
  }
  image(teste, 0, ALTURA_HEADER);
}