public class Advisor extends Piece {

  public Advisor(int file, int rank, boolean isRed) {
    super(file, rank, isRed);
  }
  
  @Override
  public PImage getIcon() {
    return createIcon(0);
  }
  
}
