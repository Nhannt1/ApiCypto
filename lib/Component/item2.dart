import 'package:cryptoapp/screen/selectedCoin.dart';
import 'package:flutter/material.dart';

class Item2 extends StatelessWidget {
  final dynamic item;
  Item2({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: myWidth * 0.03,
        vertical: myHeight * 0.02,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectCoin(selectItem: item),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: myWidth * 0.04,
            vertical: myHeight * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh
              Container(
                height: myHeight * 0.05,
                width: myHeight * 0.05,
                child: Image.network(
                  item?.image ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: myHeight * 0.05);
                  },
                ),
              ),
              SizedBox(height: myHeight * 0.02),

              // Tên coin
              Text(
                item?.id ?? 'Unknown',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis, // Ngăn text quá dài
              ),
              SizedBox(height: myHeight * 0.01),

              // Giá thay đổi
              Row(
                children: [
                  Text(
                    _formatPriceChange(item?.priceChange24H),
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(width: myWidth * 0.03),
                  Text(
                    _formatPercentageChange(item?.marketCapChangePercentage24H),
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          (item?.marketCapChangePercentage24H ?? 0) >= 0
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm định dạng giá thay đổi
  String _formatPriceChange(double? priceChange) {
    if (priceChange == null) return '\$0.00';
    return priceChange < 0
        ? "-\$${priceChange.abs().toStringAsFixed(2)}"
        : "\$${priceChange.toStringAsFixed(2)}";
  }

  // Hàm định dạng phần trăm thay đổi
  String _formatPercentageChange(double? percentageChange) {
    if (percentageChange == null) return '0%';
    return '${percentageChange.toStringAsFixed(2)}%';
  }
}
