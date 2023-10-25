import 'package:bearlysocial/generic/enums/social_media.dart';
import 'package:bearlysocial/generic/functions/getters/app_colors.dart';
import 'package:bearlysocial/generic/functions/getters/lang_names_in_native_format.dart';
import 'package:bearlysocial/generic/functions/nav_to_some_page.dart';
import 'package:bearlysocial/generic/widgets/buttons/colored_btn.dart';
import 'package:bearlysocial/generic/widgets/form_elements/selector.dart';
import 'package:bearlysocial/generic/widgets/form_elements/social_media_links.dart';
import 'package:bearlysocial/generic/widgets/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/specific/pages/selfie_capture_page.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

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
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: moderateGray,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.no_photography,
            ),
          ),
        ),
        UnconstrainedBox(
          child: ColoredButton(
            horizontalPadding: 8,
            verticalPadding: 8,
            callbackFunction: () => navigateToSomePage(
              context: context,
              somePage: const SelfieCapturePage(),
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
        Selector(
          userInputController: TextEditingController(),
          hint: 'Select languages.',
          map: languageNamesInNativeFormat,
          trailingIcon: Icons.keyboard_arrow_down,
          callbackFunction: () {},
        ),
        Selector(
          userInputController: TextEditingController(),
          hint: 'Select interests.',
          map: languageNamesInNativeFormat,
          trailingIcon: Icons.keyboard_arrow_down,
          callbackFunction: () {},
        ),
        const SocialMediaLink(
          platform: SocialMedia.instagram,
        ),
        const SocialMediaLink(
          platform: SocialMedia.facebook,
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
      ],
    );
  }
}
