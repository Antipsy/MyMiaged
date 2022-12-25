import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miaged/const/AppColors.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController ?_emailController;
  TextEditingController ?_datenController;
  TextEditingController ?_nomController;
  TextEditingController ?_prenomController;
  TextEditingController ?_adresseController;
  TextEditingController ?_codepController;
  TextEditingController ?_villeController;
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _datenController?.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }





  setDataToTextField(data){
    return  Column(
      children: [
        Center(child: Image.network("https://firebasestorage.googleapis.com/v0/b/vinted-clone-336fc.appspot.com/o/user1.png?alt=media&token=7cf9d7b8-f39e-450c-94b9-808fc5e5142e",height: 120,width: 120)),
        TextFormField(
          controller: _emailController = TextEditingController(text: auth.currentUser!.email),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
          readOnly: true,
        ),
        TextFormField(
          controller: _nomController = TextEditingController(text: data['nom']),
          decoration: InputDecoration(
            labelText: 'Nom',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
        ),
        TextFormField(
          controller: _prenomController = TextEditingController(text: data['prenom']),
          decoration: InputDecoration(
            labelText: 'Prenom',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
        ),
        TextField(
          controller: _datenController = TextEditingController(text: data['daten']),

          decoration: InputDecoration(
            labelText: 'Date de naissance',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
            suffixIcon: IconButton(
              onPressed: () => _selectDateFromPicker(context),
              icon: Icon(Icons.calendar_today_outlined),
            ),
          ),
        ),
        TextFormField(
          controller: _adresseController = TextEditingController(text: data['address']),
          decoration: InputDecoration(
            labelText: 'Address',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
        ),
        TextFormField(
          controller: _codepController = TextEditingController(text: data['codep']),
          decoration: InputDecoration(
            labelText: 'Code postal',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
        ),
        TextFormField(
          controller: _villeController = TextEditingController(text: data['ville']),
          decoration: InputDecoration(
            labelText: 'Ville',
            labelStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.vinted_color,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"),
          style: ElevatedButton.styleFrom(
          primary: AppColors.vinted_color,
          elevation: 3,
          ),)
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "nom":_nomController!.text,
          "prenom":_prenomController!.text,
          "address":_adresseController!.text,
          "daten":_datenController!.text,
          "codep":_codepController!.text,
          "ville":_villeController!.text,

        }
        ).then((value) => Fluttertoast.showToast(msg: "profil modifié"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      )),
    );
  }
}
