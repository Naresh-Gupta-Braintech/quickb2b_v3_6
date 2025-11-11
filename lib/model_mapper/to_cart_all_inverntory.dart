import 'package:quickb2b_v3_6/model/product_item_model.dart';
import 'package:quickb2b_v3_6/model_mapper/mapper.dart';
import 'package:quickb2b_v3_6/network/data/response/product.dart';

class ToCartAllInverntory implements Mapper<ProductItemModel, Product> {
  Product call(ProductItemModel object) {
    return Product(
      itemCode: object.itemCode,
      itemName: object.itemName,
      itemPrice: object.itemPrice,
      status: object.status,
      uom: object.uom,
      measureQty: object.measureQty,
      originQty: object.originQty,
      quantity: object.quantity,
      comment: object.comment,
      orderBy: object.orderBy,
      specialItemId: object.specialItemId,
      specialTitle: object.specialTitle,
      orderByCat: object.orderByCat,
      portion: object.portion,
      imageDescription: object.imageDescription,
      image: object.image,
      thumbImage: object.thumbImage,
      categoryId: object.categoryId,
      retailCategoryId: object.retailCategoryId,
      isDelete: object.isDelete,
      isMeasBox: object.isMeasBox,
      inMyList: object.inMyList,
      id: object.id,
      priority: object.priority,
    );
  }
}
