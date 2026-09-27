import '../../../../core/usecase/usecase.dart';

abstract interface class AccountRepository {
  /// True when the account signs in with a password (asked for before
  /// deleting); false for Google, which re-prompts the Google sheet.
  bool get usesPassword;

  /// Permanently erases the signed-in account and the data it owns.
  ResultFuture<void> deleteAccount({String? password});
}
