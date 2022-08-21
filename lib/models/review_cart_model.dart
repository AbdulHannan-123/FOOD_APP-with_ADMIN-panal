class ReviewCartModel{
  String? cartId;
  String? cartImage;
  String? cartName;
  int? cartPrice;
  int? cartQuantity;
  var cartUnit;

  ReviewCartModel({
    this.cartImage,
    this.cartId,
    this.cartName, 
    this.cartPrice, 
    this.cartQuantity,
    this.cartUnit,
    });

}