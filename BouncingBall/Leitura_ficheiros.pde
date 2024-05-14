class Ficheiro
{
  String caminho_ficheiro;
  String[][] tipos_blocos;
  Ficheiro(String caminho_ficheiro)
  {
    this.caminho_ficheiro = caminho_ficheiro;
    //substituir por ROWS E COLS 15 e 13 respetivamente
    this.tipos_blocos = new String[15][13];
  }
  
  void parse_file(String delimitador)
  {
    String[]linhas = loadStrings(this.caminho_ficheiro);
    for (int i = 0; i < linhas.length; i++)
    {
        this.tipos_blocos[i] = splitTokens(linhas[i], delimitador);
        println(this.tipos_blocos[i]);
    }
    
  }
}

Ficheiro ficheiro = new Ficheiro("read.txt");
ficheiro.parse_file(",");
