import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

import '../../data/models/author_model.dart';

class LDummyAuthors {
  static final List<AuthorModel> authors = [
    AuthorModel(
      id: '1',
      name: 'J.K. Rowling',
      bio: 'Best known for the Harry Potter fantasy series.',
      photoUrl: LImages.user, // ✅ Use a unique image
      createdAt: DateTime.now(), // ✅ Record creation timestamp
    ),
    AuthorModel(
      id: '2',
      name: 'Stephen King',
      bio: 'Master of horror fiction',
      photoUrl: LImages.user,
      createdAt: DateTime.now(),
    ),
    AuthorModel(
      id: '3',
      name: 'George Orwell',
      bio: 'English novelist and essayist known for dystopian themes',
      photoUrl: LImages.user,
      createdAt: DateTime.now(),
    ),
    AuthorModel(
      id: '4',
      name: 'Agatha Christie',
      bio: 'Renowned mystery novelist',
      photoUrl: LImages.user,
      createdAt: DateTime.now(),
    ),
    AuthorModel(
      id: '5',
      name: 'J.R.R. Tolkien',
      bio: 'Author of high fantasy works like The Lord of the Rings',
      photoUrl: LImages.user,
      createdAt: DateTime.now(),
    ),
    AuthorModel(
      id: '6',
      name: 'Harper Lee',
      bio: 'Author of To Kill a Mockingbird',
      photoUrl: LImages.user,
      createdAt: DateTime.now(),
    ),
  ];
}
