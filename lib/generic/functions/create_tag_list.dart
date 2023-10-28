import 'package:bearlysocial/generic/widgets/form_elements/tag.dart';

List<Tag> createTagList({required List<String> labels, dynamic type}) {
  List<Tag> tags = [];

  for (String label in labels) {
    tags.add(Tag(
      label: label,
      type: type,
    ));
  }

  return tags;
}
