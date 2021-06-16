import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:start_app/demo/flutter_cart/model/cart_model.dart';
import 'package:start_app/demo/flutter_cart/model/food_model.dart';
import 'package:start_app/res/my_colors.dart';
import 'package:start_app/res/my_styles.dart';

class FoodCardWidget extends StatefulWidget {
  final Food food;

  FoodCardWidget(this.food);

  @override
  _FoodCardWidgetState createState() => _FoodCardWidgetState();
}

class _FoodCardWidgetState extends State<FoodCardWidget> {
  Food get food => widget.food;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildImage(),
          buildTitle(),
          buildRating(),
          buildPriceInfo(),
        ],
      ),
    );
  }

  buildImage() {
    return Card(
      shape: roundedRectangle12,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Image.network(
          food.image,
          fit: BoxFit.fill,
          height: 100,
          loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
            if (progress == null) return child;
            return Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  buildTitle() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(top: 12.0, left: 8, right: 16),
      child: Text(
        food.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar(
              initialRating: food.rate,
              direction: Axis.horizontal,
              itemCount: 5,
              itemSize: 14,
              unratedColor: Colors.black,
              itemPadding: EdgeInsets.only(right: 4.0),
              ignoreGestures: true,
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: mainColor,
                  ),
              onRatingUpdate: (rating) {}),
          Text('(${food.rateCount})'),
        ],
      ),
    );
  }

  buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '\$ ${food.price}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Card(
            margin: EdgeInsets.only(right: 8),
            shape: roundedRectangle12,
            color: mainColor,
            child: InkWell(
              customBorder: roundedRectangle12,
              child: Icon(Icons.add),
              onTap: addItemToCard,
            ),
          )
        ],
      ),
    );
  }

  addItemToCard() {
    final snackBar = SnackBar(
      content: Text('${food.name} added to cart'),
      duration: Duration(milliseconds: 1000),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    CartModel cartModel = CartModel(food: food, quantity: 1);
    // listen 设为false，不建立依赖关系
    Provider.of<Cart>(context, listen: false).addItem(cartModel);
  }
}
