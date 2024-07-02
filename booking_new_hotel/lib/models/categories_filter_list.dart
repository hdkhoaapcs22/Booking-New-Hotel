class CategoriesFilterList {
  String titleTxt;
  String destination;
  bool isSelected;
  CategoriesFilterList({
    this.titleTxt = '',
    this.isSelected = false,
    this.destination =''
  });

  static List<CategoriesFilterList> amenityCategories = [
    CategoriesFilterList(
      titleTxt: 'free_breakfast',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'free_parking',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'swimming_pool',
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

  static List<CategoriesFilterList> destinationDistrict = [
    CategoriesFilterList(
      titleTxt: 'all_text',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_1',
      destination: 'Dist 1',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_2',
      destination: 'Dist 2',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_3',
      destination: 'Dist 3',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_4',
      destination: 'Dist 4',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_5',
      destination: 'Dist 5',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_6',
      destination: 'Dist 6',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_7',
      destination: 'Dist 7',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_8',
      destination: 'Dist 8',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_9',
      destination: 'Dist 9',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_10',
      destination: 'Dist 10',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_11',
      destination: 'Dist 11',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'district_12',
      destination: 'Dist 12',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'binh_tan',
      destination: 'Binh Tan Dist',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'binh_thanh',
      destination: 'Binh Thanh Dist',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'go_vap',
      destination: 'Go Vap Dist',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'phu_nhuan',
      destination: 'Phu Nhuan Dist',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'tan_binh',
      destination: 'Tan Binh Dist',
      isSelected: false,
    ),
    CategoriesFilterList(
      titleTxt: 'tan_phu',
      destination: 'Tan Phu Dist',
      isSelected: false,
    ),
  ];
}
