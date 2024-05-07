import 'room.dart';
import 'room_data.dart';
import '../utils/localfiles.dart';

class Hotel {
  String imageHotel;
  String name;
  String locationOfHotel;
  DateText? date;
  String dateTxt;
  double dist;
  double rating;
  int reviews;
  int averagePrice;
  bool isBestDeal;
  Amenity? amenity;
  int discountRate;
  Future<List<Room>>? listOfRooms;

  Hotel({
    this.imageHotel = '',
    this.name = '',
    this.locationOfHotel = "",
    this.dateTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.averagePrice = 180,
    this.isBestDeal = false,
    this.discountRate = 0,
    this.date,
    this.amenity,
    this.listOfRooms,
  });

  // we need location in this hotelList bcz we using that in map
  static List<Hotel> hotelList = [
    Hotel(
      imageHotel: Localfiles.hotel_1,
      name: 'Grand Royal Hotel',
      locationOfHotel: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      averagePrice: 180,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day, DateTime.now().day + 6),
    ),
    Hotel(
      imageHotel: Localfiles.hotel_2,
      name: 'Queen Hotel',
      locationOfHotel: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      averagePrice: 200,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day + 2, DateTime.now().day + 6),
    ),
    Hotel(
      imageHotel: Localfiles.hotel_3,
      name: 'Grand Royal Hotel',
      locationOfHotel: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      averagePrice: 60,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day + 5, DateTime.now().day + 9),
    ),
    Hotel(
      imageHotel: Localfiles.hotel_4,
      name: 'Queen Hotel',
      locationOfHotel: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      averagePrice: 170,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day, DateTime.now().day + 5),
    ),
    Hotel(
      imageHotel: Localfiles.hotel_5,
      name: 'Grand Royal Hotel',
      locationOfHotel: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      averagePrice: 200,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day, DateTime.now().day + 4),
    ),
    Hotel(
      imageHotel: Localfiles.hotel_5,
      name: 'Grand Royal Hotel',
      locationOfHotel: 'Wembley, Ho',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      averagePrice: 200,
      amenity: Amenity(
          isPool: false,
          isPetFriendly: true,
          isFreeBreakfast: false,
          isFreeWifi: true,
          isFreeParking: true),
      date: DateText(DateTime.now().day, DateTime.now().day + 4),
    ),
  ];

  static List<Hotel> popularList = [
    Hotel(
      imageHotel: Localfiles.popular_1,
      name: 'LOTTE',
    ),
    Hotel(
      imageHotel: Localfiles.popular_2,
      name: 'NEW WORLD',
    ),
    Hotel(
      imageHotel: Localfiles.popular_3,
      name: 'Vernazza',
    ),
    Hotel(
      imageHotel: Localfiles.popular_4,
      name: 'London',
    ),
    Hotel(
      imageHotel: Localfiles.popular_5,
      name: 'Venice',
    ),
    Hotel(
      imageHotel: Localfiles.popular_6,
      name: 'Diamond Head',
    ),
  ];

  static List<Hotel> reviewsList = [
    Hotel(
      imageHotel: Localfiles.avatar1,
      name: 'Alexia Jane',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar3,
      name: 'Jacky Depp',
      locationOfHotel:
          'Good staff, very comfortable bed, very quiet location, place could do with an update',
      rating: 8.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar5,
      name: 'Alex Carl',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 6.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar2,
      name: 'May June',
      locationOfHotel:
          'Good staff, very comfortable bed, very quiet location, place could do with an update',
      rating: 9.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar4,
      name: 'Lesley Rivas',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar6,
      name: 'Carlos Lasmar',
      locationOfHotel:
          'Good staff, very comfortable bed, very quiet location, place could do with an update',
      rating: 7.0,
      dateTxt: '21 May, 2019',
    ),
    Hotel(
      imageHotel: Localfiles.avatar7,
      name: 'Oliver Smith',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 9.0,
      dateTxt: '21 May, 2019',
    ),
  ];

  static List<Hotel> romeList = [
    Hotel(
      imageHotel:
          'assets/images/room_1.jpg assets/images/room_2.jpg assets/images/room_3.jpg',
      name: 'Deluxe Room',
      averagePrice: 180,
      dateTxt: 'Sleeps 2 people',
      // roomData: RoomData(numberOfBed: 2, numberOfPeople: 2),
    ),
    Hotel(
      imageHotel:
          'assets/images/room_4.jpg assets/images/room_5.jpg assets/images/room_6.jpg',
      name: 'Premium Room',
      averagePrice: 200,
      dateTxt: 'Sleeps 3 people + 2 children',
      // roomData: RoomData(numberOfBed: 3, numberOfPeople: 2),
    ),
    Hotel(
      imageHotel:
          'assets/images/room_7.jpg assets/images/room_8.jpg assets/images/room_9.jpg',
      name: 'Queen Room',
      averagePrice: 240,
      dateTxt: 'Sleeps 4 people + 4 children',
      // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
    ),
    Hotel(
      imageHotel:
          'assets/images/room_10.jpg assets/images/room_11.jpg assets/images/room_12.jpg',
      name: 'King Room',
      averagePrice: 240,
      dateTxt: 'Sleeps 4 people + 4 children',
      // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
    ),
    Hotel(
      imageHotel:
          'assets/images/room_11.jpg assets/images/room_1.jpg assets/images/room_2.jpg',
      name: 'Hollywood Room',
      averagePrice: 260,
      dateTxt: 'Sleeps 4 people + 4 children',
      // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
    ),
  ];

  static List<Hotel> hotelTypeList = [
    Hotel(
      imageHotel: Localfiles.hotel_Type_1,
      name: 'hotel_data',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_2,
      name: 'Backpacker_data',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_3,
      name: 'Resort_data',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_4,
      name: 'villa_data',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_5,
      name: 'apartment',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_6,
      name: 'guest_house',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_7,
      name: 'motel',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_8,
      name: 'accommodation',
    ),
    Hotel(
      imageHotel: Localfiles.hotel_Type_9,
      name: 'Bed_breakfast',
    ),
  ];
  static List<Hotel> lastsSearchesList = [
    Hotel(
      imageHotel: Localfiles.popular_4,
      name: 'London',
      // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
      date: DateText(12, 22),
      dateTxt: '12 - 22 Dec',
    ),
    Hotel(
      imageHotel: Localfiles.popular_1,
      name: 'Paris',
      // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
      date: DateText(12, 24),
      dateTxt: '12 - 24 Sep',
    ),
    Hotel(
      imageHotel: Localfiles.city_3,
      name: 'New York',
      // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
      date: DateText(20, 22),
      dateTxt: '20 - 22 Sep',
    ),
    Hotel(
      imageHotel: Localfiles.city_4,
      name: 'Tokyo',
      // roomData: RoomData(numberOfBed: 12, numberOfPeople: 22),
      date: DateText(12, 22),
      dateTxt: '12 - 22 Nov',
    ),
    Hotel(
      imageHotel: Localfiles.city_5,
      name: 'Shanghai',
      // roomData: RoomData(numberOfBed: 10, numberOfPeople: 15),
      date: DateText(10, 15),
      dateTxt: '10 - 15 Dec',
    ),
    Hotel(
      imageHotel: Localfiles.city_6,
      name: 'Moscow',
      // roomData: RoomData(numberOfBed: 12, numberOfPeople: 14),
      date: DateText(12, 14),
      dateTxt: '12 - 14 Dec',
    ),
  ];
}
