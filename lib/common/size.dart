import 'package:flutter_screenutil/flutter_screenutil.dart';

String googleApiKey = 'AIzaSyCmPEJz8RGp0qdZnnV0A0Owq9NKh0hBFOo';

double height = 1640.h;
double width = 720.w;

// const String appBaseUrl = "http://localhost:4000" ;
// const String appBaseUrl = "https://chopnowbackendrefixnew-production.up.railway.app" ;

//  const String appBaseUrl = "https://chopnow-backend-refix-newest-6ej3.vercel.app";

// "https://chopnowbackend-production.up.railway.app"


const String appBaseUrl = "http://172.191.58.151:4000";





List<String> orderList = [
  "New-",
  "Preparing-",
  "Active orders-",
  "Order history-",
  "Rejected orders-"
];

List<String> menuList = [
  "Meals",
  "Additives",
  "Packs"
];

List<String> foodCategories = [
 
    "Pizza",
"Chicken",
"Drink",
"Fit Farm",
"Soup",
"Burger",
"Rice",
"Spaghetti",
"Swallow",
"Grills",
"Pastries",
"Snacks",
"Smoothie",
"Ice cream",
"Sea Food",
"Chinese",
"Italian",
"Protein",
"Fries",
"Parfait",
];



final List<Map<String, String>> banks = [
  {'name': 'Access Bank', 'code': '044'},
  {'name': 'Access Bank (Diamond)', 'code': '063'},
  {'name': 'ALAT by Wema', 'code': '035A'},
  {'name': 'Ecobank Nigeria', 'code': '050'},
  {'name': 'Fidelity Bank', 'code': '070'},
  {'name': 'First Bank of Nigeria', 'code': '011'},
  {'name': 'First City Monument Bank (FCMB)', 'code': '214'},
  {'name': 'Guaranty Trust Bank (GTBank)', 'code': '058'},
  {'name': 'Heritage Bank', 'code': '030'},
  {'name': 'Keystone Bank', 'code': '082'},
  {'name': 'Polaris Bank', 'code': '076'},
  {'name': 'Providus Bank', 'code': '101'},
  {'name': 'Stanbic IBTC Bank', 'code': '221'},
  {'name': 'Standard Chartered Bank', 'code': '068'},
  {'name': 'Sterling Bank', 'code': '232'},
  {'name': 'Suntrust Bank', 'code': '100'},
  {'name': 'Union Bank of Nigeria', 'code': '032'},
  {'name': 'United Bank for Africa (UBA)', 'code': '033'},
  {'name': 'Unity Bank', 'code': '215'},
  {'name': 'Wema Bank', 'code': '035'},
  {'name': 'Zenith Bank', 'code': '057'},
  {'name': 'Jaiz Bank', 'code': '301'},
  {'name': 'Titan Trust Bank', 'code': '102'},
  {'name': 'Globus Bank', 'code': '00103'},
  {'name': 'Parallex Bank', 'code': '526'},
  {'name': 'TAJ Bank', 'code': '302'},
  {'name': 'Lotus Bank', 'code': '303'},
  {'name': 'PremiumTrust Bank', 'code': '104'},
  {'name': 'Signature Bank', 'code': '105'},
  {'name': 'Moniepoint Microfinance Bank', 'code': '50515'},
  {'name': 'Opay (Paycom)', 'code': '50593'},
  {'name': 'PalmPay', 'code': '50569'},
  {'name': 'Kuda Bank', 'code': '50211'},
  {'name': 'Rubies Bank', 'code': '125'},
  {'name': 'VFD Microfinance Bank', 'code': '566'},
  {'name': 'Sparkle Microfinance Bank', 'code': '51310'},
  {'name': 'Zenith Mobile', 'code': '32229'},
];
