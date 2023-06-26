class OnBoarding {
  String title;
  String img;
  String description;
  String description1;
  String description2;
  String description3;
  String des1;
  String des22;
  String des2;
  OnBoarding(
      {required this.title, required this.img,required this.description,
        required this.description1, required this.description2,
        required this.description3, required this.des1, required this.des2, required this.des22});
}

List<OnBoarding> page1 = [
  OnBoarding(
      title: "Hey Foodie 👋 \nWelcome to HomeMady, the app \nwhere you can order:",
      img: "assets/images/onbording.png",
      des22: "assets/images/check.png",
      description: 'À la carte ',
      des1: '(individual dishes),',
      description1: 'Catering',
      des2: ' (big trays/pots of food for events)',
      description2: 'Meal Prep',
      description3: ' (large number of individual dishes)',
  ),
  OnBoarding(
      title: "Some items will be on sale for instant delivery, others may require a scheduled delivery (especially catering and meal prep), others can be collected by you. Most cooks will offer multiple delivery options 👍",
      img: "assets/images/Group 1000004213.png",
      description: '',
      des1: '',
      des22: '',
      des2: '',
      description1: '',
      description2: '',
      description3: '',
     ),
  OnBoarding(
      title: "You are ready to start your journey with HomeMady",
      img: "assets/images/Onboeading3.png",
      description: '',
      des1: '',
      des2: '',
      des22: '',
    description1: '',
      description2: '',
      description3: '',
    ),

];
