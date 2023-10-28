import 'package:bearlysocial/generic/enums/language.dart';
import 'package:bearlysocial/generic/functions/getters/design_tokens.dart';
import 'package:bearlysocial/generic/enums/social_media.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/lang_names_in_native_format.dart';
import 'package:bearlysocial/generic/functions/nav_to_some_page.dart';
import 'package:bearlysocial/generic/functions/providers/language.dart';
import 'package:bearlysocial/generic/functions/providers/language_tags.dart';
import 'package:bearlysocial/specific/functions/providers/profile_pic.dart';
import 'package:bearlysocial/generic/pages/front_cam_page.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/generic/widgets/form_elements/selector.dart';
import 'package:bearlysocial/generic/widgets/form_elements/social_media_links.dart';
import 'package:bearlysocial/generic/widgets/form_elements/underlined_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInformation extends ConsumerStatefulWidget {
  const PersonalInformation({super.key});

  @override
  ConsumerState<PersonalInformation> createState() =>
      _PersonalInformationState();
}

class _PersonalInformationState extends ConsumerState<PersonalInformation> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String matchingKey = '';

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.addListener(() {
      setState(() {});
    });
    _lastNameFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom / 1.5,
      ),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: ref.watch(profilePicture) == null
                  ? Border.all(
                      color: moderateGray,
                    )
                  : null,
            ),
            child: Center(
              child: ref.read(displayProfilePicture)(),
            ),
          ),
          const SizedBox(
            height: AppSpacing.small,
          ),
          UnconstrainedBox(
            child: ColoredButton(
              horizontalPadding: 8,
              verticalPadding: 8,
              callbackFunction: () => navigateToSomePage(
                context: context,
                somePage: const FrontCameraPage(),
              ),
              uniformBorderRadius: 128,
              borderColor: moderateGray,
              child: Text(
                'Update Profile Picture',
                style: TextStyle(
                  color: heavyGray,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSpacing.medium,
          ),
          UnderlinedTextField(
            label: 'First Name',
            obscureText: false,
            userInputController: _firstNameController,
            node: _firstNameFocusNode,
            textIsvalid: true,
            textIsError: false,
            invalidText: '',
            errorText: '',
          ),
          const SizedBox(
            height: AppSpacing.large,
          ),
          UnderlinedTextField(
            label: 'Last Name',
            obscureText: false,
            userInputController: _lastNameController,
            node: _lastNameFocusNode,
            textIsvalid: true,
            textIsError: false,
            invalidText: '',
            errorText: '',
          ),
          const SizedBox(
            height: AppSpacing.veryLarge,
          ),
          Selector(
            userInputController: TextEditingController(),
            hint: 'Select interests.',
            map: languageNamesInNativeFormat,
            trailingIcon: Icons.keyboard_arrow_down,
            callbackFunction: () {},
            labels: [],
          ),
          const SizedBox(
            height: AppSpacing.medium,
          ),
          Selector(
            userInputController: ref.watch(selectedLang),
            hint: 'Select languages.',
            map: languageNamesInNativeFormat,
            trailingIcon: Icons.keyboard_arrow_down,
            callbackFunction: () =>
                ref.read(addLangLabel)(ref.watch(validateLangSelection)()),
            labels: ref.watch(langLabels),
            type: Language,
          ),
          const SizedBox(
            height: AppSpacing.medium,
          ),
          const SocialMediaLink(
            platform: SocialMedia.instagram,
          ),
          const SizedBox(
            height: AppSpacing.medium,
          ),
          const SocialMediaLink(
            platform: SocialMedia.facebook,
          ),
          const SizedBox(
            height: AppSpacing.large,
          ),
          UnderlinedTextField(
            label: 'Email',
            obscureText: false,
            userInputController: TextEditingController(),
            node: FocusNode(),
            textIsvalid: true,
            textIsError: false,
            invalidText: '',
            errorText: '',
          ),
          const SizedBox(
            height: AppSpacing.large,
          ),
          UnderlinedTextField(
            label: 'New Password',
            obscureText: true,
            userInputController: TextEditingController(),
            node: FocusNode(),
            textIsvalid: true,
            textIsError: false,
            invalidText: '',
            errorText: '',
          ),
          const SizedBox(
            height: AppSpacing.large,
          ),
          UnderlinedTextField(
            label: 'New Password Reaffirmation',
            obscureText: true,
            userInputController: TextEditingController(),
            node: FocusNode(),
            textIsvalid: true,
            textIsError: false,
            invalidText: '',
            errorText: '',
          ),
          const SizedBox(
            height: AppSpacing.large,
          ),
        ],
      ),
    );
  }
}
