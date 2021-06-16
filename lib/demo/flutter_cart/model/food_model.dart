class Food {
  String name;
  double price;
  double rate;
  int rateCount;
  String image;
  String foodType;

  Food(
      {this.name,
      this.price,
      this.rate,
      this.rateCount,
      this.image,
      this.foodType});
}

List<String> foodTypes = ['All', 'Salad', 'Pizza', 'Burger'];

List<Food> foods = [
  Food(
    name: '辣椒炒鸡蛋',
    price: 10,
    rate: 3.0,
    rateCount: 16,
    image:
        'https://keyassets-p2.timeincuk.net/wp/prod/wp-content/uploads/sites/53/2014/05/Poached-egg-and-bacon-salad-recipe-920x605.jpg',
    foodType: foodTypes[1],
  ),
  Food(
    name: '水果沙拉',
    price: 20,
    rate: 2,
    rateCount: 25,
    image:
        'https://ifoodreal.com/wp-content/uploads/2018/04/FG-avocado-salad.jpg',
    foodType: foodTypes[1],
  ),
  Food(
    name: '榴莲披萨',
    price: 30,
    rate: 3,
    rateCount: 67,
    image:
        'https://iowagirleats.com/wp-content/uploads/2013/01/OrangePancakes_02_mini.jpg',
    foodType: foodTypes[2],
  ),
  Food(
    name: 'Vegetables Salad1',
    price: 40,
    rate: 4,
    rateCount: 29,
    image:
        'https://iowagirleats.com/wp-content/uploads/2016/06/Marinated-Vegetable-Salad-iowagirleats-03.jpg',
    foodType: foodTypes[3],
  ),
  Food(
    name: 'Pancake With Orange Sauce',
    price: 25,
    rate: 3,
    rateCount: 60,
    image:
        'https://iowagirleats.com/wp-content/uploads/2013/01/OrangePancakes_02_mini.jpg',
    foodType: foodTypes[2],
  ),
  Food(
    name: 'Vegetables Salad2',
    price: 48,
    rate: 5,
    rateCount: 26,
    image:
        'https://iowagirleats.com/wp-content/uploads/2016/06/Marinated-Vegetable-Salad-iowagirleats-03.jpg',
    foodType: foodTypes[3],
  ),
];
