void main() {
  bonusAufg1();
  bonusAufg2();
}

void bonusAufg1() {
  double orderValue;
  double distance;
  bool rushHour;
  bool isRaining;
  int orderSize;

  double delivery;

  // Test 1:
  orderValue = 18.5;
  distance = 4.2;
  rushHour = false;
  isRaining = false;
  orderSize = 2;

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
  print("(${delivery > 10 ? "Premium-Lieferung" : delivery > 5 ? "Standardlieferung" : "Günstige Lieferung"})");
  return;
}

void printBill(double orderValue, double delivery) {
  double total = orderValue + delivery;
  print("Bill:\nOrderValue: ${orderValue.toStringAsFixed(2)} €\n+ Delivery: ${delivery.toStringAsFixed(2)} €\nTotal:      ${total.toStringAsFixed(2)} €");
  whichCategory(delivery);
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

}

void printDiscount(double totalAmount, bool isStudent, bool hasVoucher, bool isLoyalCustomer) {
  int discount = (hasVoucher ? 15 : isLoyalCustomer ? 10 : isStudent ? 5 : 0) + (totalAmount > 200.0 ? 5 : 0);
  print("\n${discount > 15 ? "Super Spar-Deal!" : discount > 0 ? "Normaler Rabatt" : "Standardpreis"}");  
}