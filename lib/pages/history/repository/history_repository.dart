import 'package:hdi_test/models/transaction_model.dart';
import 'package:hdi_test/utils/mock_data/mock_data.dart';
import 'package:result_dart/result_dart.dart';

class HistoryRepository {
  AsyncResult<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(MockData.transactions);
  }
}
