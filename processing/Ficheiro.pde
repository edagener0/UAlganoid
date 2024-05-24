class Ficheiro
{
  String caminho_ficheiro;
  
  Ficheiro(String caminho_ficheiro)
  {
    this.caminho_ficheiro = caminho_ficheiro;
  }
  
  String[][] parse_file(String delimitador)
  {
    String[][] tipos_blocos = new String[ROWS][COLS];
    String[]linhas = loadStrings(this.caminho_ficheiro);
    for (int i = 0; i < linhas.length; i++)
    {
      tipos_blocos[i] = splitTokens(linhas[i], delimitador);
    }
    return tipos_blocos; 
    
  }
}
