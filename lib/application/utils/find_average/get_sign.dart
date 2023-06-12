int getSign({required String quiz}) {
  String sign = quiz.replaceAll(RegExp(r"\d"), "").split("")[1];
  switch (sign) {
    case "+":
      return 0;
      break;
    case "-":
      return 1;
      break;
    case "x":
      return 2;
      break;
    case "/":
      return 3;
      break;
  }
  return 0;
}
