import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
//TODO 6: Update the default currency to AUD, the first item in the currencyList.
  String selectedCurrency = "USD";
  int ?rate;

  DropdownButton<String> andriodDropdown(){
    List <DropdownMenuItem<String>> dropdownitems = [];
    for (String currency in currenciesList){
      var newItems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownitems.add(newItems);

    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownitems,
        onChanged: (value){
          setState(() {
            //TODO 2: Call getData() when the picker/dropdown changes.

            selectedCurrency = value!;
            getData();
          },
          );
          },
    );
  }

  CupertinoPicker iOSPicker(){
    List <Text> pickerItems = [];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
    }

    int indexOfUSD = currenciesList.indexOf('USD');

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(
        initialItem: indexOfUSD,
      ),
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        //print(currenciesList[selectedIndex]);

        setState(() {
          //TODO 1: Save the selected currency to the property selectedCurrency
          selectedCurrency = currenciesList[selectedIndex];
          //TODO 2: Call getData() when the picker/dropdown changes.
          getData();
        });
      },
      children: pickerItems,
    );
  }
//TODO: Create a method here called getData() to get the coin data from coin_data.dart

  void getData() async {
    CoinData coinData = CoinData();

    double data = await coinData.getCoinData(selectedCurrency);
    setState(() {
      rate = data.toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedCurrency = 'AUD';
    //TODO: Call getData() when the screen loads up.
    getData();
  }

  // Widget ?getPicker(){
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   }
  //   else if (Platform.isAndroid){
  //     return andriodDropdown();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //TODO 5: Update the currency name depending on the selectedCurrency.
                  //TODO: Update the Text Widget with the live bitcoin data here.
                    '1 BTC = ${rate.toString()} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: andriodDropdown()//Platform.isIOS ? iOSPicker() : andriodDropdown(),
          ),
        ],
      ),
    );
  }
}



