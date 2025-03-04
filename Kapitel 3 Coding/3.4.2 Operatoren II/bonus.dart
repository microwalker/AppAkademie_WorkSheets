void main() {
  bonusAufg1();
  bonusAufg2();
}

void bonusAufg1() {
  List<Map<String, dynamic>> orders = [
    {"orderName":"Test 1", "orderValue": 18.5, "distance": 4.2, "rushHour": false, "isRaining": false, "orderSize": 2},
    {"orderName":"Test 2", "orderValue": 55.9, "distance": 8.8, "rushHour": true, "isRaining": true, "orderSize": 6},
    {"orderName":"Test 3", "orderValue": 12.4, "distance": 11.2, "rushHour": true, "isRaining": false, "orderSize": 1},
    {"orderName":"Test 4", "orderValue": 81.65, "distance": 15.7, "rushHour": false, "isRaining": true, "orderSize": 9}
  ];

  orders.forEach((element) {
    double delivery = calcDelivery(element["orderValue"], element["distance"], element["isRaining"], element["rushHour"], element["orderSize"]);
    print("\n ==> ${element["orderName"]} <== ");
    printBill(element["orderValue"], delivery);
  });

  /* Old "Spaghetti-Code" :-)
  // Test 1:
  double orderValue = 18.5;
  double distance = 4.2;
  bool rushHour = false;
  bool isRaining = false;
  int orderSize = 2;

  delivery = calcDelivery(orderValue, distance, isRaining, rushHour, orderSize);
  printBill(orderValue, delivery);

  // Test 2:
  orderValue = 55.9;
  distance = 8.8;
  rushHour = true;
  isRaining = true;
  orderSize = 6;

  delivery = calcDelivery(orderValue, distance, isRaining, rushHour, orderSize);
  printBill(orderValue, delivery);

  // Test 3:
  orderValue = 12.4;
  distance = 11.2;
  rushHour = true;
  isRaining = false;
  orderSize = 1;

  delivery = calcDelivery(orderValue, distance, isRaining, rushHour, orderSize);
  printBill(orderValue, delivery);
  */
  // return; /* an ending "return" seems to be not necessary at DART for void-Functions !?!? */
}

double calcDelivery(double orderValue, double distance, bool isRaining, bool rushHour, int orderSize) {
  double traffic = 0.0;
  double rebates = 0.0;
  double delivery = 0.0;
  
  traffic = (distance > 10 ? 5.0 : distance > 5 ? 3.5 : 2.5) + (distance - 5) * .3 + (isRaining ? 1.5 : 0) + (rushHour ? 2.0 : 0);
  rebates = orderSize > 8 ? 2.0 : orderSize > 5 ? 1.0 : orderSize > 3 ? .5 : 0;
  delivery = ((((orderValue < 15.0 ? 5.0 : 0) + traffic - rebates) * 10).roundToDouble()/10);

  return delivery > (orderValue * .4) ? (orderValue * .4) : delivery;
}

void whichCategory(double delivery) {
  return print("(${delivery > 10 ? "Premium-Lieferung" : delivery > 5 ? "Standardlieferung" : "Günstige Lieferung"})");
  // return; /* it seems to be possible to return a function at "return" for void-functions in DART */
}

void printBill(double orderValue, double delivery) {
  double total = orderValue + delivery;
  print("\nBill:"+
        "\nOrderValue: ${orderValue.toStringAsFixed(2)} €"+
        "\n+ Delivery:  ${delivery.toStringAsFixed(2)} €"+
        "\nTotal:      ${total.toStringAsFixed(2)} €");
  return whichCategory(delivery);
  // return;
}

void bonusAufg2() {
  double totalAmount;
  bool isStudent;
  bool hasVoucher;
  bool isLoyalCustomer;

  // Test 1
  totalAmount = 150;
  isStudent = true;
  hasVoucher = false;
  isLoyalCustomer = false;
  printDiscount(totalAmount, isStudent, hasVoucher, isLoyalCustomer);

  // Test 2
  totalAmount = 250;
  isStudent = false;
  hasVoucher = true;
  isLoyalCustomer = true;
  printDiscount(totalAmount, isStudent, hasVoucher, isLoyalCustomer);
  // return;
}

void printDiscount(double totalAmount, bool isStudent, bool hasVoucher, bool isLoyalCustomer) {
  int discount = (hasVoucher ? 15 : isLoyalCustomer ? 10 : isStudent ? 5 : 0) + (totalAmount > 200.0 ? 5 : 0);
  print("\n${discount > 15 ? "Super Spar-Deal!" : discount > 0 ? "Normaler Rabatt" : "Standardpreis"}");  
  // return;
}