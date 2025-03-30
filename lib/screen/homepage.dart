import 'package:cryptoapp/Component/item.dart';
import 'package:cryptoapp/Component/item2.dart';
import 'package:cryptoapp/cModels/coinmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isFresh = true; // Trạng thái tải dữ liệu
  List<CoinMarket> coinMarket = []; // Danh sách chứa dữ liệu

  @override
  void initState() {
    super.initState();
    getCoinMarket(); // Lấy dữ liệu khi màn hình được khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 55, 181, 181),
              const Color.fromARGB(255, 14, 112, 139),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: myHeight * 0.03),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.02,
                      vertical: myHeight * 0.005,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: Text('My Account', style: TextStyle(fontSize: 16)),
                  ),
                ),
                Text('Top 10 Coins'),
                Text('Experimental'),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 100.0',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.show_chart, size: 30),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
              child: Row(
                children: [
                  Text('+ 100% all time', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Container(
              width: myWidth,
              height: myHeight * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: myHeight * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Assets'), Icon(Icons.add)],
                    ),
                  ),
                  //     SizedBox(height: myHeight * 0.01),
                  Expanded(
                    child:
                        isFresh == true
                            ? Center(
                              child: CircularProgressIndicator(),
                            ) // Khi đang tải dữ liệu
                            : ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Item(item: coinMarket[index]);
                              },
                            ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.08,
                      vertical: myHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Recommend to Buy',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: myWidth * 0.03),
                      child:
                          isFresh == true
                              ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                              : coinMarket.length == 0
                              ? Padding(
                                padding: EdgeInsets.all(myHeight * 0.05),
                                child: Center(
                                  child: Text(
                                    'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                              : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coinMarket.length,
                                itemBuilder: (context, index) {
                                  return Item2(item: coinMarket[index]);
                                },
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm lấy dữ liệu từ API
  Future<void> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
    setState(() {
      isFresh = true; // Bắt đầu tải dữ liệu
    });
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    setState(() {
      isFresh = false; // Xong tải dữ liệu
    });
    if (response.statusCode == 200) {
      var x = response.body;
      List<CoinMarket> coinMarketList = coinMarketFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
