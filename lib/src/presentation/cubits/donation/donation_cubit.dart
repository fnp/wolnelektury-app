import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolnelektury/src/data/donation_repository.dart';
import 'package:wolnelektury/src/utils/cubit/safe_cubit.dart';
import 'package:wolnelektury/src/utils/data_state/data_state.dart';

part 'donation_cubit.freezed.dart';
part 'donation_state.dart';

class DonationCubit extends SafeCubit<DonationState> {
  final DonationRepository _donationRepository;

  DonationCubit(this._donationRepository) : super(const DonationState());

  Future<void> makeDonation() async {
    emit(state.copyWith(isLoading: true, isSuccess: false));

    final response = await _donationRepository.getDonationToken();

    response.handle(
      success: (data, pagination) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        _launchDonationLinkWithToken(data);
      },
      failure: (error) {
        _launchDonationLinkWithoutToken();
        emit(state.copyWith(isLoading: false, isSuccess: false));
      },
    );
  }

  Future<void> _launchDonationLinkWithoutToken() async {
    final baseUrl = dotenv.env['shareBaseUrl'] ?? '';
    final url = Uri.parse('$baseUrl/pomagam/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      return;
    }
  }

  Future<void> _launchDonationLinkWithToken(String token) async {
    final baseUrl = dotenv.env['apiUrl'] ?? '';
    final url = Uri.parse(
      '$baseUrl/session-transfer/continue/?token=$token&next=/pomagam/',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      return;
    }
  }
}
