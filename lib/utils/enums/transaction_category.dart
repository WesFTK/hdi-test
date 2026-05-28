enum TransactionCategory {
  food,
  electronics,
  clothing,
  health,
  entertainment,
  travel,
  other;

  String get label {
    switch (this) {
      case TransactionCategory.food:
        return 'Food';
      case TransactionCategory.electronics:
        return 'Electronics';
      case TransactionCategory.clothing:
        return 'Clothing';
      case TransactionCategory.health:
        return 'Health';
      case TransactionCategory.entertainment:
        return 'Entertainment';
      case TransactionCategory.travel:
        return 'Travel';
      case TransactionCategory.other:
        return 'Other';
    }
  }
}
