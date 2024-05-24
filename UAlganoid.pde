import processing.sound.*;

// cores utilizadas ao longo do programa
final color INVISIBLE = color(0, 0, 0, 0);
final color GRAY = color(150, 150, 150);
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


final int LARGURA_BLOCO = 54; // Tamanho horizontal do bloco. Controla o tamanho de todos os elementos do jogo


final color BACKGROUND_COLOR = BLACK; // Cor do background do jogo
final color BIGMESSAGE_COLOR = color(50, 150, 255); // Cor da mensagem que aparece no meio da tela

final int ALTURA_BLOCO = LARGURA_BLOCO / 2;

final int ALTURA_HEADER = 3 * ALTURA_BLOCO; // Tamanho vertical do header do jogo

final int LARGURA_JANELA = 14*LARGURA_BLOCO; // Largura da janela, calculada dinamicamente através da largura do bloco
final int ALTURA_JANELA = LARGURA_JANELA  + ALTURA_HEADER; // Altura da janela, calculada dinamicamente através da largura do bloco

final float FRAME_RATE = 60; // Framerate do jogo
final float ESCALA_VELOCIDADE = 60 / FRAME_RATE;

final float MIN_BORDER_X = LARGURA_BLOCO * 0.5;
final float MAX_BORDER_X = LARGURA_JANELA - MIN_BORDER_X;

final float MIN_BORDER_Y = ALTURA_BLOCO + ALTURA_HEADER;
final float MAX_BORDER_Y = ALTURA_JANELA + ALTURA_HEADER;

final int LARGURA_PAD = 2 * LARGURA_BLOCO;
final float ALTURA_PAD = LARGURA_BLOCO * 0.5;
final float POSICAO_X_PAD = LARGURA_JANELA / 2;
final float POSICAO_Y_PAD = ALTURA_JANELA - ALTURA_BLOCO * 1.5;

final float DIAMETRO_BOLA = LARGURA_BLOCO * 0.5;
final float POSICAO_Y_BOLA = POSICAO_Y_PAD - ALTURA_PAD / 2 - DIAMETRO_BOLA / 2 - LARGURA_BLOCO * 0.01;

final float BOLA_VEL_X = 5;
final float BOLA_VEL_Y = 5;

final float BOLA_MODULO_VEL = LARGURA_BLOCO * 0.15 * ESCALA_VELOCIDADE;
final float POWERUP_MODULO_VEL = LARGURA_BLOCO * 0.025 * ESCALA_VELOCIDADE;
final float PAD_MODULO_VEL = LARGURA_BLOCO * 0.2 * ESCALA_VELOCIDADE;

final int VIDAS = 3;

final int ROWS = 15;
final int COLS = 13;

final float CHANCE_DROP_POWERUPS = 0.05; // default: 0.05 
final float MAX_RANDOM_CHANCE = 1 / CHANCE_DROP_POWERUPS;

final float efeitos = 0.6;
final float music_amp = 0.15;


SoundFile VICTORY;
SoundFile DEFEAT;
SoundFile pad_bounce;
SoundFile block_hit;
SoundFile border_hit;
SoundFile passed_level;

SoundFile music;

SoundFile picked_up_fireball;
SoundFile picked_up_plus2balls;
SoundFile picked_up_coracao;
SoundFile picked_up_x5;



PImage type_1_block;
PImage type_2_block;
PImage type_3_block;
PImage type_4_block;
PImage type_5_block;
PImage type_6_block;
PImage type_7_block;

PImage[] type_8_block = new PImage[20];
PImage[] type_9_block = new PImage[20];
PImage[] bola_on_fire = new PImage[10];
PImage[] multiplier_image = new PImage[4];

PImage imagem_bola;

PImage imagem_background;

PImage imagem_background_on_fire;

PImage imagem_header;

PImage borda;

PImage imagem_pad;

PImage damaged_block;

PImage coracao;
PImage bola_multiplier_imagem;
PImage fireball_imagem;

PFont fonte;

boolean game_ended = false;

int multiplier = 1;

int MAX_NUMERO_NIVEIS = 25;

int max_score;
int score_atual;

int nivel_atual = 1;

boolean texturas_ligadas = true;

boolean game_on = false;
boolean lost = false;

boolean won_level = false;
boolean won_game = false;

boolean[] passed_levels = new boolean[MAX_NUMERO_NIVEIS];


ArrayList <Ball> bolas;

Pad pad;
Border border;
Ball bola;
BigMessage message;
Header header;

ArrayList <Fireball> fireballs;
ArrayList <BallTriplicator> triplicators;
ArrayList <AddLife> life_adders;
ArrayList <ScoreMultiplier> score_multipliers;

Blocks blocos = new Blocks();

void cheat_code(int level_number)
{
  for (int i = 0; i < passed_levels.length; i++)
  {
    if (i + 1 < level_number) passed_levels[i] = true;
    else if (i + 1 > level_number) passed_levels[i] = false;
  }
}
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

void remove_life_adders()
{
  life_adders.clear();
}

void remove_score_multipliers()
{
  score_multipliers.clear();
}


// -----------------------------------------------------------------------------------------
// Função responsável por desenhar "LOADING" no setup do projeto antes dos assets carregarem
// -----------------------------------------------------------------------------------------
void loading_screen()
{
  final float largura_letra = LARGURA_BLOCO;
  final float altura_letra = largura_letra * 2;

  final float x_letra = LARGURA_BLOCO * 1.5;
  final float y_letra = ALTURA_JANELA / 2 - altura_letra / 4;


  fill(BLACK);
  strokeWeight(LARGURA_BLOCO / 2.7);
  strokeCap(ROUND);

  noFill();
  strokeJoin(ROUND);
  
  // letra L
  beginShape();
  vertex(x_letra, y_letra);
  vertex(x_letra, y_letra + altura_letra);
  vertex(x_letra + largura_letra, y_letra + altura_letra);
  endShape();
  
  // letra O
  ellipse(x_letra + largura_letra * 2, y_letra + altura_letra / 2, largura_letra * 1.5, altura_letra);
  
  // letra A
  beginShape();
  vertex(x_letra + largura_letra * 3.4, y_letra + altura_letra);
  vertex(x_letra + largura_letra * 3.4 + largura_letra / 2, y_letra);
  vertex(x_letra + largura_letra * 3.4 + largura_letra, y_letra + altura_letra);
  endShape();
  line(x_letra + largura_letra * 3.4 + largura_letra / 4, y_letra + largura_letra * 1.5, x_letra + largura_letra * 3.8 + largura_letra * 0.4, y_letra + largura_letra * 1.5);
  
  // letra D
  arc(x_letra + largura_letra * 5.2, y_letra + largura_letra, largura_letra * 2, largura_letra * 2, HALF_PI + PI, TWO_PI + HALF_PI);
  line(x_letra + largura_letra * 5.2, y_letra, x_letra + largura_letra * 5.2, y_letra + largura_letra* 2);
  
  // letra I
  line(x_letra + largura_letra * 7.1, y_letra, x_letra + largura_letra * 7.1, y_letra + largura_letra * 2);
  
  // letra N
  line(x_letra + largura_letra * 8, y_letra, x_letra + largura_letra * 8, y_letra + largura_letra * 2);
  line(x_letra + largura_letra * 8, y_letra, x_letra + largura_letra * 9, y_letra + largura_letra * 2);
  line(x_letra + largura_letra * 9, y_letra, x_letra + largura_letra * 9, y_letra + largura_letra * 2);
  
  // letra G
  arc(x_letra + largura_letra * 11, y_letra + largura_letra, largura_letra * 2, largura_letra * 2, PI - HALF_PI, PI + HALF_PI);
  line(x_letra + largura_letra * 11, y_letra + largura_letra * 2, x_letra + largura_letra * 11, y_letra + largura_letra * 1.4);
  line(x_letra + largura_letra * 11 - largura_letra / 4, y_letra + largura_letra * 1.2, x_letra + largura_letra * 11 + largura_letra / 4, y_letra + largura_letra * 1.2);
}


// -------------------------
// Definir tamanho da janela
// -------------------------
void settings()
{
  size(LARGURA_JANELA, ALTURA_JANELA);
}


// -----------------------------------------------------------------------------------------------------------
// Função onde são carregados os niveis e os assets do jogo, e onde as maioria das variáveis são inicializadas
// -----------------------------------------------------------------------------------------------------------
void setup()
{
  loading_screen();
  
  
  frameRate(FRAME_RATE);
  noStroke();
  
  fonte = loadFont("Fontes_Texto/title.vlw");
  
  type_1_block = loadImage("blocos/blocos_normais/type_1_block.png");
  type_2_block = loadImage("blocos/blocos_normais/type_2_block.png");
  type_3_block = loadImage("blocos/blocos_normais/type_3_block.png");
  type_4_block = loadImage("blocos/blocos_normais/type_4_block.png");
  type_5_block = loadImage("blocos/blocos_normais/type_5_block.png");
  type_6_block = loadImage("blocos/blocos_normais/type_6_block.png");
  type_7_block = loadImage("blocos/blocos_normais/type_7_block.png");
  
  for (int i = 0; i < 12; i++)
  {
    type_8_block[i] = loadImage("blocos/blocos_prateados/bloco" + i + ".png");
  }
  
  for (int i = 12; i < 20; i++)
  {
    type_8_block[i] = loadImage("blocos/blocos_prateados/bloco0.png");
  }
  
  for (int i = 0; i < 12; i++)
  {
    type_9_block[i] = loadImage("blocos/blocos_dourados/bloco" + i + ".png");
  }
  
  damaged_block = loadImage("blocos/block_damaged.png");
  
  for (int i = 12; i < 20; i++)
  {
    type_9_block[i] = loadImage("blocos/blocos_dourados/bloco0.png");
  }
  
  for (int i = 0; i < bola_on_fire.length; i++)
  {
    bola_on_fire[i] = loadImage("bola/bola_on_fire/" + i + ".png");
  }
  
  for (int i = 0; i < multiplier_image.length; i++)
  {
    multiplier_image[i] = loadImage("powerups/x5/" + i + ".png");
  }
  
  coracao = loadImage("powerups/Life_Gainer/coracao_powerup.png");
  imagem_bola = loadImage("bola/bola.png");

  imagem_background = loadImage("backgrounds/main_background.png");
  imagem_background.resize(LARGURA_JANELA, ALTURA_JANELA);

  imagem_background_on_fire = loadImage("backgrounds/background_on_fire.png");
  imagem_background_on_fire.resize(LARGURA_JANELA, ALTURA_JANELA);

  imagem_header = loadImage("backgrounds/header.png");
  imagem_header.resize(LARGURA_JANELA, ALTURA_HEADER);
  fireball_imagem = loadImage("powerups/Fireball/fireball.png");

  borda = loadImage("border/border.png");
  borda.resize(LARGURA_JANELA, ALTURA_JANELA);

  bola_multiplier_imagem = loadImage("powerups/Bola_Multiplier/bola_multiplier.png");

  imagem_pad = loadImage("pad/pad.png");


  music = new SoundFile(this, "/game_sounds/music.mp3");
  VICTORY = new SoundFile(this, "/game_sounds/victory.wav");
  DEFEAT = new SoundFile(this, "/game_sounds/defeat.wav");
  pad_bounce = new SoundFile(this, "/pad/efeitos_sonoros/pad.wav");
  passed_level = new SoundFile(this, "/game_sounds/passed_level.wav");
  picked_up_fireball = new SoundFile(this, "/powerups/Fireball/efeitos_sonoros/powerup_fire.wav");
  picked_up_plus2balls = new SoundFile(this, "/powerups/Bola_Multiplier/efeitos_sonoros/powerup_plus2balls.wav");
  picked_up_coracao = new SoundFile(this, "/powerups/Life_Gainer/efeitos_sonoros/coracao_sound.wav");
  picked_up_x5 = new SoundFile(this, "/powerups/x5/efeitos_sonoros/x5.wav");

  block_hit = new SoundFile(this, "blocos/block_hit.wav");
  border_hit = new SoundFile(this, "border/hit.wav");


  pad = new Pad(POSICAO_X_PAD, POSICAO_Y_PAD, LARGURA_PAD, ALTURA_PAD, RED);
  border = new Border(LARGURA_BLOCO, YELLOW);
  bola = new Ball(LARGURA_JANELA/2, POSICAO_Y_BOLA, 0, 0, DIAMETRO_BOLA, GRAY, false);
  header = new Header(LARGURA_JANELA/2, ALTURA_BLOCO);
  message = new BigMessage();

  bolas = new ArrayList <Ball>();
  bolas.add(bola);
  
  fireballs = new ArrayList <Fireball>();
  triplicators = new ArrayList <BallTriplicator>();
  life_adders = new ArrayList <AddLife>();
  score_multipliers = new ArrayList <ScoreMultiplier>();
  
  blocos.carregar_nivel(nivel_atual, message);
  
  // define todos os elementos do array com os niveis concluidos para false
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    passed_levels[i] = false;
  }

  textFont(fonte);

  music.cue(50);
  music.play();
  music.amp(music_amp);
  
  blocos.verificar_blocos();
}


// ------------------------------------------------------------------------------------------
// Função responsável por verificar se uma tecla foi premida, e realizar a sua respetiva ação
// ------------------------------------------------------------------------------------------
void keyPressed()
{  
  if (keyCode == RIGHT) pad.mover_direita();
  else if (keyCode == LEFT) pad.mover_esquerda();
  else if (keyCode == 32 && !game_on) 
  {
    bolas.get(0).lancar_bola(pad);
    game_on = true;
  }
  else if (key == '1')
  {
    nivel_atual = 1;
    cheat_code(nivel_atual);
    blocos.carregar_nivel(1, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '2')
  {
    nivel_atual = 2;
    cheat_code(nivel_atual);
    blocos.carregar_nivel(2, message);
    bolas.get(0).reset(pad);
    pad.reset();
    
  }
  else if (key == '3')
  {
    nivel_atual = 3;
    cheat_code(nivel_atual);
    blocos.carregar_nivel(3, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '4')
  {
    nivel_atual = 4;
    cheat_code(nivel_atual);
    blocos.carregar_nivel(4, message);
    bolas.get(0).reset(pad);
    pad.reset();
  }
  else if (key == '5')
  {
    nivel_atual = 5;
    cheat_code(nivel_atual);
    blocos.carregar_nivel(5, message);
    bolas.get(0).reset(pad);
    pad.reset();
    
  }
  else if (key == 'w')
  {
    score_atual = max_score;
  }
  else if (key == 'i')
  {
    texturas_ligadas = !texturas_ligadas;
  }
  else if (key == 'm')
  {
    triplicators.add(new BallTriplicator(pad.posicao.x, ALTURA_JANELA / 2, 0));
  }
  else if (key == 'f')
  {
    fireballs.add(new Fireball(pad.posicao.x, ALTURA_JANELA / 2, 1));
  }
  else if (key == 'l')
  {
    life_adders.add(new AddLife(pad.posicao.x, ALTURA_JANELA / 2, 2));
  }
  else if (key == 's')
  {
    score_multipliers.add(new ScoreMultiplier(pad.posicao.x, ALTURA_JANELA / 2, 3));
  }
}


// -----------------------------------------------------------------------------
// Função que verifica se o jogador ainda tem vidas restantes e se perdeu o jogo
// -----------------------------------------------------------------------------
boolean have_lives()
{
  if (!header.have_lives())
  {
    if (!lost)
    {
      remove_fireballs();
      remove_triplicators();
      remove_life_adders();
      remove_score_multipliers();
      
      message.display("Game Over!", RED, 4500);
      DEFEAT.play();
      DEFEAT.amp(efeitos);
      game_ended = true;
    }
    lost = true;
    return false;
  }
  return true;
}


// ----------------------------------------------
// Função que verifica se o jogador ganhou o jogo
// ----------------------------------------------
boolean ganhou_jogo()
{
  for (int i = 0; i < MAX_NUMERO_NIVEIS; i++)
  {
    if (!passed_levels[i]) return false;
  }
  
  if (!won_game) 
  {
    remove_fireballs();
    remove_triplicators();
    remove_life_adders();
    remove_score_multipliers();
    
    message.display("Victory!!", CYAN, 4500);
    VICTORY.play();
    VICTORY.amp(efeitos);
    game_ended = true;
  }
  won_game = true;
  
  return true;
}


// ------------------------------------
// Função que carrega e avança de nível
// ------------------------------------
boolean ganhou()
{
  if (won_level && nivel_atual <= MAX_NUMERO_NIVEIS)
  {
    passed_levels[nivel_atual - 1] = true;
    nivel_atual++;
    blocos.carregar_nivel(nivel_atual, message);
    won_level = false;
    bolas.get(0).reset(pad);
    passed_level.play();
    passed_level.amp(efeitos);
    return true;
  }
  return false;
}


void update()
{
  if (!music.isPlaying())
  {
    music.play();
    music.amp(music_amp);
  }

  if (texturas_ligadas)
  {
    if (!bolas.get(0).on_fire) background(imagem_background);
    else background(imagem_background_on_fire);
  }
  else background(BLACK);

  for (int i = 0; i < bolas.size(); i++)
  {
    Ball temp_bola = bolas.get(i);
    temp_bola.before_game();
    temp_bola.detetar_colisoes(); 
  }

  blocos.desenhar_blocos();
  header.ganhou_nivel();
}


// ----------------------------
// Função principal do programa
// ----------------------------
void draw()
{
  update();

  header.draw();
  message.draw();
  border.draw();
  pad.draw();

  if (!have_lives())  return;
  if (ganhou())       return;
  if (ganhou_jogo())  return;
  
  for (int i = 0; i < bolas.size(); i++)
  {
    if (bolas.get(i).posicao.y > MAX_BORDER_Y)
    {
      bolas.remove(i);
      continue;
    }
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
  
  for (int i = 0; i < life_adders.size(); i++)
  {
    life_adders.get(i).draw();
  }
  
  for (int i = 0; i < score_multipliers.size(); i++) 
  {
    score_multipliers.get(i).draw();
  }
}
