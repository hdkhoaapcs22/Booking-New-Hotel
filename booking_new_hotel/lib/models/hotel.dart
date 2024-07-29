import '../service/location/location.dart';
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
  Location? position;

  Hotel({
    this.imageHotel = '',
    this.name = '',
    this.locationOfHotel = "",
    this.dateTxt = "",
    this.dist = 0.0,
    this.reviews = 80,
    this.rating = 4.5,
    this.averagePrice = 180,
    this.isBestDeal = false,
    this.discountRate = 0,
    this.date,
    this.amenity,
    this.listOfRooms,
    this.position,
  });

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
      name: 'LA VELA',
    ),
    Hotel(
      imageHotel: Localfiles.popular_4,
      name: 'FUSION SUITE',
    ),
    Hotel(
      imageHotel: Localfiles.popular_5,
      name: 'NIKKO',
    ),
    Hotel(
      imageHotel: Localfiles.popular_6,
      name: 'VINPEARLY LANDMARK 81',
    ),
  ];

  static List<Hotel> reviewsList = [
    Hotel(
      imageHotel: Localfiles.avatar1,
      name: 'Alexia Jane',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 8.0,
      dateTxt: '12 May, 2024',
    ),
    Hotel(
      imageHotel: Localfiles.avatar3,
      name: 'Jacky Depp',
      locationOfHotel:
          'Good staff, very comfortable bed, very quiet location, place could do with an update',
      rating: 8.0,
      dateTxt: '8 May, 2024',
    ),
    Hotel(
      imageHotel: Localfiles.avatar5,
      name: 'Alex Carl',
      locationOfHotel:
          'This is located in a great spot close to shops and bars, very quiet location',
      rating: 6.0,
      dateTxt: '1 May, 2024',
    ),
    Hotel(
      imageHotel: Localfiles.avatar2,
      name: 'May June',
      locationOfHotel:
          'Good staff, very comfortable bed, very quiet location, place could do with an update',
      rating: 9.0,
      dateTxt: '29 April, 2024',
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

  // static List<Hotel> romeList = [
  //   Hotel(
  //     imageHotel:
  //         'assets/images/room_1.jpg assets/images/room_2.jpg assets/images/room_3.jpg',
  //     name: 'Deluxe Room',
  //     averagePrice: 180,
  //     dateTxt: 'Sleeps 2 people',
  //     // roomData: RoomData(numberOfBed: 2, numberOfPeople: 2),
  //   ),
  //   Hotel(
  //     imageHotel:
  //         'assets/images/room_4.jpg assets/images/room_5.jpg assets/images/room_6.jpg',
  //     name: 'Premium Room',
  //     averagePrice: 200,
  //     dateTxt: 'Sleeps 3 people + 2 children',
  //     // roomData: RoomData(numberOfBed: 3, numberOfPeople: 2),
  //   ),
  //   Hotel(
  //     imageHotel:
  //         'assets/images/room_7.jpg assets/images/room_8.jpg assets/images/room_9.jpg',
  //     name: 'Queen Room',
  //     averagePrice: 240,
  //     dateTxt: 'Sleeps 4 people + 4 children',
  //     // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
  //   ),
  //   Hotel(
  //     imageHotel:
  //         'assets/images/room_10.jpg assets/images/room_11.jpg assets/images/room_12.jpg',
  //     name: 'King Room',
  //     averagePrice: 240,
  //     dateTxt: 'Sleeps 4 people + 4 children',
  //     // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
  //   ),
  //   Hotel(
  //     imageHotel:
  //         'assets/images/room_11.jpg assets/images/room_1.jpg assets/images/room_2.jpg',
  //     name: 'Hollywood Room',
  //     averagePrice: 260,
  //     dateTxt: 'Sleeps 4 people + 4 children',
  //     // roomData: RoomData(numberOfBed: 4, numberOfPeople: 4),
  //   ),
  // ];

  // static List<Hotel> lastsSearchesList = [
  //   Hotel(
  //     imageHotel: Localfiles.popular_4,
  //     name: 'London',
  //     // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '12 - 22 Dec',
  //   ),
  //   Hotel(
  //     imageHotel: Localfiles.popular_1,
  //     name: 'Paris',
  //     // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '12 - 24 Sep',
  //   ),
  //   Hotel(
  //     imageHotel: Localfiles.city_3,
  //     name: 'New York',
  //     // roomData: RoomData(numberOfBed: 1, numberOfPeople: 3),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '20 - 22 Sep',
  //   ),
  //   Hotel(
  //     imageHotel: Localfiles.city_4,
  //     name: 'Tokyo',
  //     // roomData: RoomData(numberOfBed: 12, numberOfPeople: 22),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '12 - 22 Nov',
  //   ),
  //   Hotel(
  //     imageHotel: Localfiles.city_5,
  //     name: 'Shanghai',
  //     // roomData: RoomData(numberOfBed: 10, numberOfPeople: 15),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '10 - 15 Dec',
  //   ),
  //   Hotel(
  //     imageHotel: Localfiles.city_6,
  //     name: 'Moscow',
  //     // roomData: RoomData(numberOfBed: 12, numberOfPeople: 14),
  //     date: DateText(
  //         startDate: DateTime.now(),
  //         endDate: DateTime.now().add(const Duration(days: 2))),
  //     dateTxt: '12 - 14 Dec',
  //   ),
  // ];
}
