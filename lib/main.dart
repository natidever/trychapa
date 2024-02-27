import 'package:flutter/material.dart';
import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:trychapa/webview_checkout.dart';

void main() {
  Chapa.configure(privateKey: "CHASECK_TEST-rxfy3hUQIwYjfUXl39TnOQEfCmpaSqsb");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? url;

  Future<void> pay() async {
    print('pay function start here ');
    String? paymentUrl = await Chapa.getInstance.startPayment(
      enableInAppPayment: false,
      amount: '789',
      currency: 'ETB',
    );
    print('url$url');
    // Ensure the URL has a scheme
    if (paymentUrl != null &&
        !paymentUrl.startsWith('http://') &&
        !paymentUrl.startsWith('https://')) {
      paymentUrl = 'http://$paymentUrl';
    }
    url = paymentUrl;
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                pay();
                print('Clicked');
                print(url);

                url == null
                    ? Text('Loading')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => WebView(
                                  url: url ?? '',
                                ))));
              },
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13), color: Colors.red),
                child: Center(child: Text("Pay")),
              ),
            ),
            url == null ? Text('loading') : Text(url ?? 'still null'),
            Text('Balance :0.00')
          ],
        ),
      ),
    );
  }
}
