import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:playkosmos_v3/models/buddies_model.dart';

part 'buddy_profile_state.dart';

class BuddyProfileCubit extends Cubit<BuddyProfileState> {
  BuddyProfileCubit()
      : super(const BuddyProfileState(
            fBuddiesModel: BuddiesModel(
          userName: 'Jordyn Vaccaro',
          interests: [
            "Art",
            "Hockey",
            "Sport",
            "Baseball",
            "Rugby",
            "Visual Arts",
            "Ice Hockey",
            "Softball",
            "Softball"
          ],
          profileImages: [
            "https://cdn.businessday.ng/2022/04/Abiru-1.png",
            "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
            "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
          ],
          bio:
              "Professional daydreamer, coffee enthusiast, and expert in pressing ‘Next Episode.’ Living life one witty remark at a time",
          followersCount: 4200,
          followingCount: 1200000,
          buddiesCount: 3200000,
          activityCreatedCount: 300,
          activityJoinedCount: 1200,
          reviewCount: 300,
          reviewStars: 4.5,
          activities: [
            "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
            "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
            "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
            "https://elections.civichive.org/wp-content/uploads/2022/12/Adenuga-Sunday-Oluwafemi-BP.jpg",
            "https://elections.civichive.org/wp-content/uploads/2022/12/Ado-Ibrahim-Abdulmalik-YPP.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/7/7c/Hamza_al-Mustapha_2023.jpg",
            "https://cdn.businessday.ng/2022/04/Abiru-1.png",
            "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
            "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
            "https://stears-elections.s3.eu-west-1.amazonaws.com/static/candidate-photos/president/APP-Charles-Nnadi.png"
          ],
          posts: [
            "https://elections.civichive.org/wp-content/uploads/2022/12/Abiola-Latifu-Kolawole-PRP.jpg",
            "https://pbs.twimg.com/profile_images/1510691230555987973/agTnpSpG_400x400.jpg",
            "https://dailytrust.com/wp-content/uploads/2022/11/Prince-Adewole-Adebayo-1.jpg",
            "https://elections.civichive.org/wp-content/uploads/2022/12/Adenuga-Sunday-Oluwafemi-BP.jpg",
            "https://elections.civichive.org/wp-content/uploads/2022/12/Ado-Ibrahim-Abdulmalik-YPP.jpg",
            "https://upload.wikimedia.org/wikipedia/commons/7/7c/Hamza_al-Mustapha_2023.jpg",
            "https://cdn.businessday.ng/2022/04/Abiru-1.png",
            "https://pbs.twimg.com/profile_images/1495721772523692034/GnC5MJjS_400x400.jpg",
            "https://pbs.twimg.com/profile_images/1530445927739162625/xtGDZZIm_400x400.jpg",
            "https://stears-elections.s3.eu-west-1.amazonaws.com/static/candidate-photos/president/APP-Charles-Nnadi.png"
          ],
        )));
}
