import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:pay/pay.dart';
 
class CustomGooglePay extends StatefulWidget {
  final total;

  CustomGooglePay({this.total});

  @override
  State<CustomGooglePay> createState() => _CustomGooglePayState();
}

class _CustomGooglePayState extends State<CustomGooglePay> {


  // ignore: prefer_final_fields
//   var _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '${widget.total}',
//     status: PaymentItemStatus.final_price,
//   )
// ];
 

 
 
// In your Stateless Widget class or State
void onGooglePayResult(paymentResult) {
  // Send the resulting Google Pay token to your server or PSP
}


  @override
  Widget build(BuildContext context) {
    return // In your Widget build() method
GooglePayButton(
  paymentConfigurationAsset: 'sample_payment_configuration.json',
  paymentItems:  [ PaymentItem(
    label: 'Total',
    amount: '${widget.total}',
    status: PaymentItemStatus.final_price,
  ),],
  style: GooglePayButtonStyle.black,
  type: GooglePayButtonType.pay,
  onPaymentResult: onGooglePayResult,
);
  }
}