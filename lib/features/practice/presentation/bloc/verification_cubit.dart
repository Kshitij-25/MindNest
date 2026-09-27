import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/practice_entities.dart';
import '../../domain/usecases/practice_usecases.dart';

part 'verification_cubit.freezed.dart';

@freezed
abstract class VerificationState with _$VerificationState {
  const factory VerificationState({
    @Default(<VerificationDocument>[]) List<VerificationDocument> documents,
    DocumentKind? uploading,
    @Default(false) bool submitting,
    @Default(false) bool submitted,
    String? error,
  }) = _VerificationState;

  const VerificationState._();

  int get uploadedCount => documents.where((d) => d.uploaded).length;
  bool get complete => documents.isNotEmpty && uploadedCount == documents.length;
}

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._get, this._upload, this._remove, this._submit) : super(const VerificationState());

  final GetVerificationDocuments _get;
  final UploadDocument _upload;
  final RemoveDocument _remove;
  final SubmitVerification _submit;

  Future<void> load() async {
    final r = await _get(const NoParams());
    r.fold((f) => emit(state.copyWith(error: f.message)), (d) => emit(state.copyWith(documents: d)));
  }

  Future<void> upload(DocumentKind kind, DocumentFile file) async {
    emit(state.copyWith(uploading: kind, error: null));
    final r = await _upload(UploadDocumentParams(kind, file));
    r.fold(
      (f) => emit(state.copyWith(uploading: null, error: f.message)),
      (_) => emit(state.copyWith(
        uploading: null,
        documents: [for (final d in state.documents) d.kind == kind ? d.copyWith(uploaded: true, fileName: file.name) : d],
      )),
    );
  }

  Future<void> remove(DocumentKind kind) async {
    emit(state.copyWith(uploading: kind, error: null));
    final r = await _remove(kind);
    r.fold(
      (f) => emit(state.copyWith(uploading: null, error: f.message)),
      (_) => emit(state.copyWith(
        uploading: null,
        documents: [for (final d in state.documents) d.kind == kind ? d.copyWith(uploaded: false, fileName: null) : d],
      )),
    );
  }

  Future<void> submit() async {
    emit(state.copyWith(submitting: true, error: null));
    final r = await _submit(const NoParams());
    r.fold(
      (f) => emit(state.copyWith(submitting: false, error: f.message)),
      (_) => emit(state.copyWith(submitting: false, submitted: true)),
    );
  }
}
