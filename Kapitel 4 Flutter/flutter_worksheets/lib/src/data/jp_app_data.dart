List<Food> foods = [
  Food(
    name: "Angi's Yummy Burger", 
    type: "Vegan cheese burger",
    description: "Delish vegan burger that tastes like heaven", 
    ingredients: Ingredients(noGluten: false, noSugar: true, lowFat: true), 
    imageUrl: "assets/jp_app/grafiken/burger.png", 
    reviewCount: 321, 
    reviewAVG: 4.8, 
    sizes: [FoodSizes.Large], 
    prices: [13.99]),
  Food(
    name: "Mogli's Cup", 
    type: "Strawberry ice cream",
    description: "Heavenly delicious soft ice cream with fresh strawberries and a sweet topping of whipped cream and one cherry", 
    ingredients: Ingredients(noGluten: true, noSugar: true, lowFat: true), 
    imageUrl: "assets/jp_app/grafiken/cupkake_cat.png", 
    reviewCount: 200, 
    reviewAVG: 4.0, 
    sizes: [FoodSizes.Small, FoodSizes.Medium, FoodSizes.Large],
    prices: [4.99, 6.99, 8.99]),
  Food(
    name: "Balu's Cup", 
    type: "Pistachio ice cream",
    description: "Bearish great ice cream with the glory pistachio taste and choccy hair in a cup", 
    ingredients: Ingredients(noGluten: true, noSugar: true, lowFat: true), 
    imageUrl: "assets/jp_app/grafiken/icecream.png", 
    reviewCount: 165, 
    reviewAVG: 3.8, 
    sizes: [FoodSizes.Small, FoodSizes.Medium, FoodSizes.Large],
    prices: [4.99, 6.99, 8.99]),
  Food(
    name: "Smiling David", 
    type: "Coffee ice cream",
    description: "Lorem ipsum dolor sit amet consectetur. Non feugiat imperdiet a vel sit at amet. Mi accumsan feugiat magna aliquam feugiat ac et. Pulvinar hendrerit id arcu at sed etiam semper mi hendrerit. Id aliquet quis quam.", 
    ingredients: Ingredients(noGluten: true, lowFat: true), 
    imageUrl: "assets/jp_app/grafiken/icecream_stick.png", 
    reviewCount: 310, 
    reviewAVG: 4.3, 
    sizes: [FoodSizes.Medium, FoodSizes.Large],
    prices: [2.99, 3.99]),
  Food(
    name: "Kai in a Cone", 
    type: "Vanilla ice cream",
    description: "The cony iceland 😋 - filled with tasty vanilla ice and chocolate sauce on top", 
    ingredients: Ingredients(noGluten: true, lowFat: true), 
    imageUrl: "assets/jp_app/grafiken/icecream_cone.png", 
    reviewCount: 290, 
    reviewAVG: 4.1, 
    sizes: [FoodSizes.Small, FoodSizes.Large],
    prices: [1.99, 3.99]),
];

enum FoodSizes { Small, Medium, Large }
class Food {
  final String name;
  final String type;
  final String description;
  final Ingredients ingredients;
  final String imageUrl;
  final int reviewCount;
  final double reviewAVG;
  final List<FoodSizes> sizes;
  final List<double> prices;

  Food({required this.name, required this.type, required this.description, required this.ingredients, required this.imageUrl, required this.reviewCount, required this.reviewAVG, required this.sizes, required this.prices});
}

class Ingredients {
  final bool noGluten;
  final bool noSugar;
  final bool lowFat;
  final bool lowKcal;

  Ingredients({this.noGluten = false, this.noSugar = false, this.lowFat = false, this.lowKcal = false});
}


