/**
 * Enumeration für die Transaktionsarten
 * In der geplanten App werden (vorerst!) nur Buy, Sell und ggf. Swaps berücksichtigt!
 */
enum TransactionType { Buy, Sell, In, Out, /*Swap, Transfer, Staking,*/ Reward, Gift }

abstract class commons {
  static int polarityOfTransactionType(TransactionType type) {
    switch(type) {
      case TransactionType.Buy || TransactionType.In || TransactionType.Reward || TransactionType.Gift:
        return 1;
      case TransactionType.Sell || TransactionType.Out:
        return -1;
      default: // offen für weitere Implementierungen...
        return 0;
    }
  } 
}