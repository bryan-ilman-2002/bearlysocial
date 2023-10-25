enum SocialMedia {
  instagram,
  facebook,
  linkedin,
  x,
  snapchat,
}

extension Getter on SocialMedia {
  String get domain {
    switch (this) {
      case SocialMedia.instagram:
        return 'www.instagram.com';
      case SocialMedia.facebook:
        return 'www.facebook.com';
      case SocialMedia.linkedin:
        return 'www.linkedin.com';
      case SocialMedia.x:
        return 'www.x.com';
      case SocialMedia.snapchat:
        return 'www.snapchat.com';
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
      case SocialMedia.linkedin:
        return 'linkedin_icon.svg';
      case SocialMedia.x:
        return 'x_icon.svg';
      case SocialMedia.snapchat:
        return 'snapchat_icon.svg';
      default:
        return '';
    }
  }
}
