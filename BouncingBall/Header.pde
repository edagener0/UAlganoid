class Header
{
  float x_title;
  float y_title;
  
  Header (float x_title, float y_title)
  {
    this.x_title = x_title;
    this.y_title = y_title;
  }
  
  void draw()
  {
    fill(200, 0, 200);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("UAlganoid :O", this.x_title, this.y_title);
  }
}
