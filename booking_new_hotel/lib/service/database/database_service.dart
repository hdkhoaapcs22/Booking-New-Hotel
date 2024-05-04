import 'favorite_hotels_database.dart';
import 'upcoming_hotels.database.dart';
import 'user_info_database.dart';

class DatabaseService {
  late String uid;
  late FavoriteHotelsDatabase favoriteHotelsDatabase;
  late UserInfoDatabase userInfoDatabase;
  late UpcomingHotelsDatabase upcomingHotelsDatabase;

  // singleton object
  static final DatabaseService _singleton = DatabaseService._internal();
  factory DatabaseService({required String uid}) {
    _singleton.uid = uid;
    _singleton.favoriteHotelsDatabase = FavoriteHotelsDatabase(uid: uid);
    _singleton.userInfoDatabase = UserInfoDatabase(uid: uid);
    _singleton.upcomingHotelsDatabase = UpcomingHotelsDatabase(uid: uid);
    return _singleton;
  }
  DatabaseService._internal();

}
