import 'package:bearlysocial/base_designs/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/components/form_elements/social_media_links.dart';
import 'package:bearlysocial/components/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/utilities/nav_to_some_page.dart';
import 'package:bearlysocial/providers/profile_pic_state.dart';
import 'package:bearlysocial/views/post_auth/settings/front_cam_page.dart';
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
    return app_bottom_sheet.BottomSheet(
      title: 'Personal Information',
      content: Column(
        children: [
          ref.read(displayProfilePic)(
            context: context,
            enlarged: true,
          ),
          const SizedBox(
            height: WhiteSpaceSize.small,
          ),
          UnconstrainedBox(
            child: SplashButton(
              horizontalPadding: PaddingSize.verySmall,
              verticalPadding: PaddingSize.verySmall,
              // callbackFunction: () => navigateToSomePage(
              //   context: context,
              //   somePage: const FrontCameraPage(),
              // ),
              borderRadius: BorderRadius.circular(
                CurvatureSize.infinity,
              ),
              // borderColor: moderateGray,
              child: Text(
                'Update Profile Picture',
                // style: TextStyle(
                //   color: heavyGray,
                // ),
              ),
            ),
          ),
          // const SizedBox(height: AppSpacing.medium),
          // UnderlinedTextField(
          //   label: 'First Name',
          //   obscureText: false,
          //   userInputController: _firstNameController,
          //   node: _firstNameFocusNode,
          //   textIsvalid: true,
          //   textIsError: false,
          //   invalidText: '',
          //   errorText: '',
          // ),
          // const SizedBox(height: AppSpacing.large),
          // UnderlinedTextField(
          //   label: 'Last Name',
          //   obscureText: false,
          //   userInputController: _lastNameController,
          //   node: _lastNameFocusNode,
          //   textIsvalid: true,
          //   textIsError: false,
          //   invalidText: '',
          //   errorText: '',
          // ),
          // const SizedBox(height: AppSpacing.extraLarge),
          // Selector(
          //   userInputController: ref.watch(selectedInterest),
          //   hint: 'Select interests.',
          //   map: interests,
          //   trailingIcon: Icons.keyboard_arrow_down,
          //   callbackFunction: () => ref
          //       .read(addInterestLabel)(ref.watch(validateSelectedInterest)()),
          //   labels: ref.watch(interestLabels),
          //   type: Interest,
          // ),
          // const SizedBox(height: AppSpacing.medium),
          // Selector(
          //   userInputController: ref.watch(selectedLang),
          //   hint: 'Select languages.',
          //   map: nativeLanguageNames,
          //   trailingIcon: Icons.keyboard_arrow_down,
          //   callbackFunction: () =>
          //       ref.read(addLangLabel)(ref.watch(validateSelectedLang)()),
          //   labels: ref.watch(langLabels),
          //   type: Language,
          // ),
          // SizedBox(
          //   height:
          //       ref.watch(langLabels).isNotEmpty ? AppSpacing.veryLarge : 64,
          // ),
          // const SocialMediaLink(platform: SocialMedia.instagram),
          // const SizedBox(height: AppSpacing.medium),
          // const SocialMediaLink(platform: SocialMedia.facebook),
          // const SizedBox(height: AppSpacing.medium),
          // const SocialMediaLink(platform: SocialMedia.linkedin),
          // const SizedBox(height: AppSpacing.extraLarge),
          // UnderlinedTextField(
          //   label: 'Email',
          //   obscureText: false,
          //   userInputController: TextEditingController(),
          //   node: FocusNode(),
          //   textIsvalid: true,
          //   textIsError: false,
          //   invalidText: '',
          //   errorText: '',
          // ),
          // const SizedBox(height: AppSpacing.large),
          // UnderlinedTextField(
          //   label: 'New Password',
          //   obscureText: true,
          //   userInputController: TextEditingController(),
          //   node: FocusNode(),
          //   textIsvalid: true,
          //   textIsError: false,
          //   invalidText: '',
          //   errorText: '',
          // ),
          // const SizedBox(height: AppSpacing.large),
          // UnderlinedTextField(
          //   label: 'New Password Reaffirmation',
          //   obscureText: true,
          //   userInputController: TextEditingController(),
          //   node: FocusNode(),
          //   textIsvalid: true,
          //   textIsError: false,
          //   invalidText: '',
          //   errorText: '',
          // ),
          // const SizedBox(height: AppSpacing.medium),
        ],
      ),
      closure: [
        // SplashButton(
        //   horizontalPadding: 48,
        //   verticalPadding: 16,
        //   buttonColor: Colors.white,
        //   // uniformBorderRadius: 16,
        //   borderColor: Colors.transparent,
        //   child: Text(
        //     'Reset',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       color: heavyGray,
        //     ),
        //   ),
        // ),
        // SplashButton(
        //   horizontalPadding: 48,
        //   verticalPadding: 16,
        //   buttonColor: heavyGray,
        //   // uniformBorderRadius: 16,
        //   borderColor: Colors.transparent,
        //   // buttonShadow: moderateShadow,
        //   child: const Text(
        //     'Apply',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
