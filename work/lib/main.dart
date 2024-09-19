
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:work/UserPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';


final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
Future<void> main() async {//setup  async await db init


    emailController.text = "sam.danielsson@gritacademy.se";
    passwordController.text = "kotlin";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
const loggedInSnackBar = SnackBar(
  content: Text('logged in!'),
);


 Future<void> getUser(context, String email, String password) async {

     try {
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: email,
           password: password
       );
       if(credential.user!=null){
         emailController.clear();
         passwordController.clear();
         ScaffoldMessenger.of(context).showSnackBar(loggedInSnackBar);
         Navigator.pushNamed(context, '/userPage');
       }
       //ScaffoldMessenger.of(context).showSnackBar(loggedInSnackBar);

     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         print('No user found for that email.');
       } else if (e.code == 'wrong-password') {
         print('Wrong password provided for that user.');
       }

     }
   }



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => const MyHomePage(title: 'Login'),
        '/userPage':(context) => const MyUserPage(title:'UserPage'),
      },
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   Color? pink = Colors.pink[50];
   const double margin = 5.0;
   const double containerWidth = 400.0;



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
                height:150,
                child: const CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: NetworkImage('https://static0.gamerantimages.com/wordpress/wp-content/uploads/2024/05/silent-hill-3-remake-unreal-engine.jpg?q=49&fit=crop&w=1100&h=618&dpr=2'),
                )
            ),
          Container(
          color: pink,
            width: containerWidth,
              margin:const EdgeInsets.all(margin),
          child:
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(5),
                hintText: "Enter Your Email"
            ),
          ),
            ),
              Container(
                color: pink,
                width: containerWidth,
                margin:const EdgeInsets.all(margin),
                child: TextFormField(
                  controller: passwordController,
                     decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        hintText:  "Enter Your Password"
                    )
                ),
              ),
            Container(
              color: pink,
              margin:const EdgeInsets.all(margin),
              child: FilledButton(onPressed:() async =>{
                getUser(context,emailController.text,passwordController.text),

              }, child:Text("Login")),

            ),Container(
              color: pink,
              margin:const EdgeInsets.all(margin),
              child: FilledButton(onPressed:() {
                FirebaseAuth.instance.signOut();

              }, child:Text("Logout")),

            ),
          ],
        ),
      ),
    );
  }
}
