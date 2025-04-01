import 'package:libercopia_bookstore_app/data/models/category_model.dart';
import 'package:libercopia_bookstore_app/utils/constants/image_strings.dart';

class LDummyCategories {
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Novel',
      image: LImages.discountImg,
      isFeatured: true,
      parentId: "",
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      id: '2',
      name: 'Crime',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
    CategoryModel(
      id: '3',
      name: 'Thriller',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
    CategoryModel(
      id: '4',
      name: 'Romance',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
    CategoryModel(
      id: '5',
      name: 'Action',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
    CategoryModel(
      id: '6',
      name: 'Mystery',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
    CategoryModel(
      id: '7',
      name: 'Science',
      image: LImages.discountImg,
      isFeatured: true,
      parentId: "",
      createdAt: DateTime.now(),
    ),
    CategoryModel(
      id: '8',
      name: 'Fiction',
      image: LImages.discountImg,
      isFeatured: true,
      createdAt: DateTime.now(),
      parentId: "",
    ),
  ];
}
