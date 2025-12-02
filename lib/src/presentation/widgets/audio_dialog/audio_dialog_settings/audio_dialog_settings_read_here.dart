import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/cubits/audio/audio_cubit.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class AudioDialogSettingsReadHere extends StatelessWidget {
  const AudioDialogSettingsReadHere({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final audioCubit = BlocProvider.of<AudioCubit>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumPadding,
          ),
          child: Text(
            LocaleKeys.audio_dialog_settings_read_here_title.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: Dimensions.smallPadding),
        SizedBox(
          height: Dimensions.elementHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Dimensions.borderRadiusOfCircle,
              ),
            ),
            child: BlocBuilder<AudioCubit, AudioState>(
              buildWhen: (p, c) {
                return p.getIdForTimestamp != c.getIdForTimestamp;
              },
              builder: (context, state) {
                final id = state.getIdForTimestamp;
                final canTap = id != null && state.book != null;
                return Opacity(
                  opacity: canTap ? 1.0 : 0.5,
                  child: AbsorbPointer(
                    absorbing: !canTap,
                    child: InkWellWrapper(
                      borderRadius: BorderRadius.circular(
                        Dimensions.borderRadiusOfCircle,
                      ),
                      onTap: () {
                        audioCubit.toggleSettings(false);
                        Navigator.of(context).pop();
                        router.pushNamed(
                          readingPageConfigWithAnchor.name,
                          pathParameters: {
                            'slug': state.book!.slug,
                            'anchor': id!,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.audio_dialog_settings_read_here_button
                                  .tr(),
                              style: theme.textTheme.bodyMedium,
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
