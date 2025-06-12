int maxDepth = 4;

float evalPos(Piece[] pos) {
  return evalTeam(pos, RED) - evalTeam(pos, BLACK);
}

float evalTeam(Piece[] pos, boolean isRed) {
  
  if (checkmate(isRed)) return Float.POSITIVE_INFINITY;
  
  float material = 0;
  
  for (Piece p: pos) {
    if (p != null && p.isRed() == isRed) {
      material += p.getMaterial();
    }
  }
  
  if (check(isRed)) return material + 0.5;
  return material;
  
}

float minimax(Piece[] pos, int depth, boolean isMax, float alpha, float beta) {
  
  if (depth == 0 || checkmate(RED) || checkmate(BLACK)) {
    return evalPos(pos);
  }
  
  if (isMax) {
    
    float maxEval = Float.NEGATIVE_INFINITY;
    
    for (Piece[] child: checkChildren(pos, true)) {
      
      float eval = minimax(child, depth - 1, false, alpha, beta);
      maxEval = max(maxEval, eval);
      alpha = max(alpha, eval);
      if (beta <= alpha) break;
      
    }
    
    return maxEval;
  
  }
  
  else {
    
    float minEval = Float.POSITIVE_INFINITY;
    
    for (Piece[] child: checkChildren(pos, false)) {
      
      float eval = minimax(child, depth - 1, true, alpha, beta);
      minEval = min(minEval, eval);
      beta = min(beta, eval);
      if (beta <= alpha) break;
    
    }
    
    return minEval;
  
  }

}

ArrayList<Piece[]> checkChildren(Piece[] pos, boolean isRed) {
  
  ArrayList<Piece[]> children = new ArrayList<Piece[]>();

  for (Piece p: pos.clone()) {
    if (p != null && p.isRed() == isRed) {
      piece = p;
      for (PVector move: piece.checkLegal()) {
        children.add(createChild(pos, piece, int(move.x), int(move.y)));
      }
    }
  }
  
  return children;
  
}

Piece[] createChild(Piece[] pos, Piece p, int f, int r) {
  
  Piece temp = p.copy();
  Piece[] child = pos.clone();
  child[int(piece.getPos().y) * (ranks - 1) + int(piece.getPos().x)] = null;
  temp.setPos(f, r);
  child[r * (ranks - 1) + f] = temp;
  return child;

}

PVector findMove() {

  float minEval = Float.POSITIVE_INFINITY;
  PVector bestMove = new PVector();
  Piece bestPiece = new Piece();
    
  for (Piece p: board) {
    if (p != null && !p.isRed()) {
      piece = p;
      ArrayList<PVector> legal = piece.checkLegal();
      
      for (int i = 0; i < legal.size(); i++) {
        
        int f = int(legal.get(i).x);
        int r = int(legal.get(i).y);
        
        Piece temp = piece.copy();
        Piece[] child = createChild(board.clone(), piece, f, r);
        float eval = minimax(child, maxDepth - 1, true, Float.NEGATIVE_INFINITY, Float.POSITIVE_INFINITY);
        piece = temp;
        
        if (eval < minEval || eval <= minEval && random(2) > 1) {
          minEval = eval;
          bestMove = legal.get(i);
          bestPiece = piece.copy();
          
        }
        
      }
    }
  }
  
  piece = bestPiece;
  return bestMove;
  
}

PVector randomMove() {
  
  int i = int(random(0, board.length));
  while (board[i] == null || (board[i].isRed())) i = int(random(0, board.length));
  
  piece = board[i];
  
  ArrayList<PVector> legal = piece.checkLegal();
  if (legal.size() == 0) return randomMove();
  return legal.get(int(random(0, legal.size())));

}
