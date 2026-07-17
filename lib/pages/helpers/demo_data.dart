class FormKeys {
  static String instructions = "instrucciones";
  static String firstName = "nombre";
  static String lastName = "apellido";
  static String country = "pais";
  static String address = "direccion";
  static String apt = "apt";
  static String city = "ciudad";
  static String postal = "postal";
  static String company = "compania";
  static String email = "email";
  static String phone = "celular";
  static String ccNumber = "ccNumero";
  static String ccName = "ccNombre";
  static String ccCode = "ccCodigo";
  static String ccExpDate = "ccExpFecha";
  static String coupon = "cupon";
}

enum InputType { text, email, number, telephone }

enum CreditCardInputType { number, expirationDate, securityCode }

enum CreditCardNetwork { visa, mastercard, amex }
