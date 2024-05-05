class CategoriesFilterList {
  String titleTxt;
  bool isSelected;
  CategoriesFilterList({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<CategoriesFilterList> amenityCategories = [
    CategoriesFilterList(
      titleTxt: 'free_breakfast',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'free_Parking',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'pool_text',
      isSelected: true,
    ),
    CategoriesFilterList(
      titleTxt: 'pet_friendly',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'free_wifi',
      isSelected: false,
    ),
  ];

  static List<CategoriesFilterList> accomodationCategories = [
    CategoriesFilterList(
      titleTxt: 'all_text',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'villa_data',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'hotel_data',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'resort_data',
      isSelected: false,
    ),
  ];
}
