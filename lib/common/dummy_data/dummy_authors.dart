import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../data/models/author_model.dart';

class LDummyAuthors {
  static final List<AuthorModel> authors = [
    AuthorModel(
      id: '1',
      name: 'J.K. Rowling',
      bio: 'Best known for the Harry Potter fantasy series.',
      photoUrl: LImages.user,
      createdAt: DateTime(1965, 7, 31),
    ),
    AuthorModel(
      id: '2',
      name: 'Stephen King',
      bio: 'Master of horror fiction',
      photoUrl: LImages.user,
      createdAt: DateTime(1947, 9, 21),
    ),
    // Add more authors
  ];
}
