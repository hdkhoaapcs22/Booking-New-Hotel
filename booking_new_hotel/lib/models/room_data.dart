class RoomData {
  int numberOfBed;
  int numberOfPeople;
  final int numberOfAttributes = 2;
  RoomData({required this.numberOfBed, required this.numberOfPeople});
}

class DateText {
  late DateTime startDate;
  late DateTime endDate;

  DateText({required this.startDate, required this.endDate});
}

class PeopleSleeps {
  int peopleNumber;
  PeopleSleeps(this.peopleNumber);
}

class AdultAndChild {
  int adult;
  int child;
  AdultAndChild(this.adult, this.child);
}

class Amenity {
  bool isPool, isPetFriendly, isFreeBreakfast, isFreeWifi, isFreeParking;
  final int numberOfAmenities = 5;
  Amenity({
    this.isPool = false,
    this.isPetFriendly = false,
    this.isFreeBreakfast = false,
    this.isFreeWifi = false,
    this.isFreeParking = false,
  });
}
