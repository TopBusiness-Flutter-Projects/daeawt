import '../../../core/utils/assets_manager.dart';

class HomeListItemModel{
  String? image ;
  String? date ;
  String? occasionTitle;
  String? address;
  String? status;

  HomeListItemModel(
      {this.image, this.date, this.occasionTitle, this.address, this.status});
}

List <HomeListItemModel> homeItems = [
  HomeListItemModel(image: AssetsManager.homeItem,address: "شبين الكوم , المنوفية",date: "sat, 01 jun 2023",
      occasionTitle: "عيد ميلاد",status: "مؤكد"),
  HomeListItemModel(image: AssetsManager.homeItem,address: "شبين الكوم , المنوفية",date: "sat, 01 jun 2023",
      occasionTitle: "عيد ميلاد",status: "مؤكد"),
  HomeListItemModel(image: AssetsManager.homeItem,address: "شبين الكوم , المنوفية",date: "sat, 01 jun 2023",
      occasionTitle: "عيد ميلاد",status: "مؤكد"),
  HomeListItemModel(image: AssetsManager.homeItem,address: "شبين الكوم , المنوفية",date: "sat, 01 jun 2023",
      occasionTitle: "عيد ميلاد",status: "مؤكد"),
  HomeListItemModel(image: AssetsManager.homeItem,address: "شبين الكوم , المنوفية",date: "sat, 01 jun 2023",
      occasionTitle: "عيد ميلاد",status: "مؤكد"),
];