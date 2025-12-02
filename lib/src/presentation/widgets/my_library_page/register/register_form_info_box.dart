import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/images.dart';

class MyLibraryRegisterFormInfoBox extends StatelessWidget {
  const MyLibraryRegisterFormInfoBox({super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.veryLargePadding,
        right: Dimensions.veryLargePadding,
        bottom: Dimensions.veryLargePadding,
      ),
      child: Column(
        spacing: Dimensions.veryLargePadding,
        children: [
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (p, c) => p.agreements != c.agreements,
            builder: (context, state) {
              return Html(
                data: state.agreements?.info.firstOrNull ?? '',
                onLinkTap: (url, attributes, element) {
                  if (url == null) return;
                  _launchInBrowser(Uri.parse(url));
                },
                style: {
                  'body': Style(
                    fontSize: FontSize(10),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                },
              );
            },
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.mediumPadding),
              child: SizedBox(
                height: 40,
                child: Row(
                  spacing: Dimensions.veryLargePadding,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        Images.mkidn,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset(
                        Images.pfron,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            spacing: Dimensions.veryLargePadding,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.login_info_mkidn.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  LocaleKeys.login_info_pfron.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
