enum SocialMedia {
  instagram,
  facebook,
  linkedIn,
}

extension Getter on SocialMedia {
  String get domain {
    switch (this) {
      case SocialMedia.instagram:
        return 'https:/www.instagram.com';
      case SocialMedia.facebook:
        return 'https:/www.facebook.com';
      case SocialMedia.linkedIn:
        return 'https:/www.linkedin.com';
      default:
        return '';
    }
  }

  String get icon {
    switch (this) {
      case SocialMedia.instagram:
        return 'instagram_icon.svg';
      case SocialMedia.facebook:
        return 'facebook_icon.svg';
      case SocialMedia.linkedIn:
        return 'linkedin_icon.svg';
      default:
        return '';
    }
  }
}
