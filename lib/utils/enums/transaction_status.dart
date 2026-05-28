enum TransactionStatus {
  paid,
  pending,
  failed,
  refunded;

  String get label {
    switch (this) {
      case TransactionStatus.paid:
        return 'Paid';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.refunded:
        return 'Refunded';
    }
  }
}
