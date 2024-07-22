class ConvertMoney {
  static int convertMoney(String money) {
    money = money.replaceAll('.', '');
    String shortenedMoney = money.substring(0, money.length - 3);
    return int.parse(shortenedMoney);
  }

  static String formatMoney(String money, String sale) {
    double saleMoney = 1 - int.parse(sale) / 100;
    double moneyDouble = convertMoney(money) * saleMoney;
    String moneyStr = '${moneyDouble.round()}000';
    String reversedMoney = moneyStr.split('').reversed.join();
    String formattedMoney = '';
    for(int i = 0; i < reversedMoney.length; i++) {
      if(i % 3 == 0 && i != 0) {
        formattedMoney += '.';
      }
      formattedMoney += reversedMoney[i];
    }
    return formattedMoney.split('').reversed.join();
  }
}