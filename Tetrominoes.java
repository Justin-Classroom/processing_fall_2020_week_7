import java.awt.Color;

public enum Tetrominoes {
  NoShape(new int[][] { { 0,0 }, { 0,0 }, { 0,0 }, { 0,0 } }, new Color(255)),
  
  ZShape(new int[][] { { 0,1 }, { 0,0 }, { -1,0 }, { 1,1 } }, new Color(255, 0, 0)),
  
  SShape(new int[][] { { 0,1 }, { 0,0 }, { 1,0 }, { -1,1 } }, new Color(0, 125, 125)),
  
  LineShape(new int[][] { { 0,1 }, { 0,0 }, { 0,-1 }, { 0,2 } }, new Color(125, 125, 0)),
  
  TShape(new int[][] { { 0,1 }, { 0,0 }, { -1,1 }, { 1,1 } }, new Color(255, 0, 125)),
  
  SquareShape(new int[][] { { 0,0 }, { 1,0 }, { 0,-1 }, { 1,-1 } }, new Color(0, 0, 255)),
  
  LShape(new int[][] { { 0,0 }, { 0,1 }, { 1,1 }, { 0,-1 } }, new Color(0, 255, 0)),
  
  MirroredLShape(new int[][] { { 0,0 }, { 0,1 }, { -1,1 }, { 0,-1 } }, new Color(125, 0, 255));
 
  public int[][] coords;
  public Color c;
  
  //constructor
  Tetrominoes(int[][] coords, Color c) {
    this.coords = coords;
    this.c = c;
  }
};
