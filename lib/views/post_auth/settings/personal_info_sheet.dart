import 'dart:convert';

import 'package:bearlysocial/base_designs/sheets/bottom_sheet.dart'
    as app_bottom_sheet;
import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/components/form_elements/dropdown.dart';
import 'package:bearlysocial/components/pictures/profile_pic.dart';
import 'package:bearlysocial/components/form_elements/social_media_links.dart';
import 'package:bearlysocial/components/form_elements/underlined_txt_field.dart';
import 'package:bearlysocial/constants/db_key.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:bearlysocial/constants/native_lang_name.dart';
import 'package:bearlysocial/constants/social_media_consts.dart';
import 'package:bearlysocial/constants/translation_key.dart';
import 'package:bearlysocial/providers/auth_state.dart';
import 'package:bearlysocial/utilities/db_operation.dart';
import 'package:bearlysocial/utilities/dropdown_operation.dart';
import 'package:bearlysocial/utilities/user_permission.dart';
import 'package:bearlysocial/views/post_auth/settings/selfie_screen.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img_lib;

class PersonalInformation extends ConsumerStatefulWidget {
  const PersonalInformation({super.key});

  @override
  ConsumerState<PersonalInformation> createState() =>
      _PersonalInformationState();
}

class _PersonalInformationState extends ConsumerState<PersonalInformation> {
  final GlobalKey<ScaffoldState> _sheetKey = GlobalKey<ScaffoldState>();

  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordConfirmationFocusNode = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _instagramLinkController =
      TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedInLinkController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();

  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _langController = TextEditingController();

  List<String> _interestCollection = [];
  List<String> _langCollection = [];

  img_lib.Image? _profilePic;

  void _setProfilePic({required img_lib.Image? profilePic}) {
    setState(() {
      _profilePic = profilePic;
    });
  }

  void _addInterest() {
    setState(() {
      _interestCollection = DropdownOperation.addLabel(
        menu: DropdownOperation.allInterests,
        labelToAdd: _interestController.text,
        labelCollection: _interestCollection,
      );
    });
  }

  void _addLanguage() {
    setState(() {
      _langCollection = DropdownOperation.addLabel(
        menu: NativeLanguageName.map,
        labelToAdd: _langController.text,
        labelCollection: _langCollection,
      );
    });
  }

  void _removeInterest({required String labelToRemove}) {
    setState(() {
      _interestCollection = DropdownOperation.removeLabel(
        labelToRemove: labelToRemove,
        labelCollection: _interestCollection,
      );
    });
  }

  void _removeLang({required String labelToRemove}) {
    setState(() {
      _langCollection = DropdownOperation.removeLabel(
        labelToRemove: labelToRemove,
        labelCollection: _langCollection,
      );
    });
  }

  void _captureSelfie() {
    UserPermission.cameraPermission.then((cameraPermission) async {
      if (!cameraPermission) return;

      final frontCamera = (await availableCameras()).firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      final BuildContext? ctx = _sheetKey.currentContext;

      if (ctx != null && ctx.mounted) {
        Navigator.of(ctx).push(
          PageRouteBuilder(
            pageBuilder: (ctx, p, q) => SelfieScreen(
              frontCamera: frontCamera,
              onPictureSuccess: _setProfilePic,
            ),
            transitionDuration: const Duration(
              seconds: AnimationDuration.instant,
            ),
          ),
        );
      }
    });
  }

  String _savedFirstName = '';
  String _savedLastName = '';

  List<String> _savedInterestCollection = [];
  List<String> _savedLangCollection = [];

  String _savedInstagramUsername = '';
  String _savedFacebookUsername = '';
  String _savedLinkedInUsername = '';

  String _savedEmail = '';

  void _reset() async {
    _savedFirstName = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.firstName.name,
    );
    _firstNameController.text = _savedFirstName;

    _savedLastName = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.lastName.name,
    );
    _lastNameController.text = _savedLastName;

    _savedInstagramUsername = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.instagramUsername.name,
    );
    _instagramLinkController.text = _savedInstagramUsername;

    _savedFacebookUsername = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.facebookUsername.name,
    );
    _facebookLinkController.text = _savedFacebookUsername;

    _savedLinkedInUsername = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.linkedInUsername.name,
    );
    _linkedInLinkController.text = _savedLinkedInUsername;

    final savedInterestCollection = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.interests.name,
    );
    _savedInterestCollection = savedInterestCollection.isEmpty
        ? []
        : List<String>.from(
            json.decode(
              savedInterestCollection,
            ),
          );

    final savedLangCollection = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.languages.name,
    );
    _savedLangCollection = savedLangCollection.isEmpty
        ? []
        : List<String>.from(
            json.decode(
              savedLangCollection,
            ),
          );

    _emailController.text = await DatabaseOperation.retrieveTransaction(
      key: DatabaseKey.email.name,
    );

    _newPasswordController.text = '';
    _newPasswordConfirmationController.text = '';
  }

  void _apply() {}

  void _validateInput() {
    // _blockInput = true;

    // setState(() {
    //   _usernameErrorText = _usernameController.text.isEmpty
    //       ? TranslationKey.invalidUsername.name.tr()
    //       : null;
    //   _passwordErrorText = _passwordController.text.isEmpty
    //       ? TranslationKey.invalidPassword.name.tr()
    //       : null;
    // });
  }

  @override
  void initState() {
    super.initState();

    _reset();

    _firstNameFocusNode.addListener(() {
      setState(() {});
    });
    _lastNameFocusNode.addListener(() {
      setState(() {});
    });
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _newPasswordFocusNode.addListener(() {
      setState(() {});
    });
    _newPasswordConfirmationFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();

    _emailFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _newPasswordConfirmationFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return app_bottom_sheet.BottomSheet(
      key: _sheetKey,
      title: TranslationKey.personalInformationTitle.name.tr(),
      content: Column(
        children: [
          ProfilePicture(
            imageSource: _profilePic,
          ),
          const SizedBox(
            height: WhiteSpaceSize.small,
          ),
          UnconstrainedBox(
            child: SplashButton(
              horizontalPadding: PaddingSize.small,
              verticalPadding: PaddingSize.verySmall,
              callbackFunction: _captureSelfie,
              buttonColor: Theme.of(context).scaffoldBackgroundColor,
              borderColor: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(
                CurvatureSize.infinity,
              ),
              child: Text(
                'Update Profile Picture',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          UnderlinedTextField(
            label: 'First Name',
            controller: _firstNameController,
            focusNode: _firstNameFocusNode,
            errorText: null,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          UnderlinedTextField(
            label: 'Last Name',
            controller: _lastNameController,
            focusNode: _lastNameFocusNode,
            errorText: null,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          Dropdown(
            hint: 'Interest(s)',
            controller: _interestController,
            menu: DropdownOperation.buildMenu(
              entries: DropdownOperation.allInterests,
            ),
            collection: _interestCollection,
            addLabel: _addInterest,
            removeLabel: _removeInterest,
          ),
          const SizedBox(
            height: WhiteSpaceSize.large,
          ),
          Dropdown(
            hint: 'language(s)',
            controller: _langController,
            menu: DropdownOperation.buildMenu(
              entries: NativeLanguageName.map,
            ),
            collection: _langCollection,
            addLabel: _addLanguage,
            removeLabel: _removeLang,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          SocialMediaLink(
            platform: SocialMedia.instagram,
            controller: _instagramLinkController,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          SocialMediaLink(
            platform: SocialMedia.facebook,
            controller: _facebookLinkController,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          SocialMediaLink(
            platform: SocialMedia.linkedIn,
            controller: _linkedInLinkController,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          UnderlinedTextField(
            label: 'Email',
            controller: _emailController,
            focusNode: _emailFocusNode,
            errorText: null,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          UnderlinedTextField(
            label: 'New Password',
            obscureText: true,
            controller: _newPasswordController,
            focusNode: _newPasswordFocusNode,
            errorText: null,
          ),
          const SizedBox(
            height: WhiteSpaceSize.medium,
          ),
          UnderlinedTextField(
            label: 'New Password Confirmation',
            obscureText: true,
            controller: _newPasswordConfirmationController,
            focusNode: _newPasswordConfirmationFocusNode,
            errorText: null,
          ),
        ],
      ),
      closure: [
        SplashButton(
          horizontalPadding: PaddingSize.veryLarge,
          verticalPadding: PaddingSize.small,
          callbackFunction: _reset,
          buttonColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(
            CurvatureSize.large,
          ),
          child: Text(
            TranslationKey.resetButton.name.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).focusColor,
                ),
          ),
        ),
        SplashButton(
          horizontalPadding: PaddingSize.veryLarge,
          verticalPadding: PaddingSize.small,
          callbackFunction: () {},
          borderRadius: BorderRadius.circular(
            CurvatureSize.large,
          ),
          shadow: Shadow.medium,
          child: Text(
            TranslationKey.applyButton.name.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
