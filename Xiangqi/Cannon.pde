public class Cannon extends Piece {

  public Cannon(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(1);
  }
  
}
