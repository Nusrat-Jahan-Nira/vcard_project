import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard_project/models/contact_model.dart';
import 'package:vcard_project/pages/home_page.dart';
import 'package:vcard_project/providers/contact_provider.dart';
import 'package:vcard_project/utils/constants.dart';
import 'package:vcard_project/utils/helper_function.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';

  final ContactModel contactModel;

  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    emailController.text = widget.contactModel.email;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    websiteController.text = widget.contactModel.website;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        actions: [
          IconButton(
            onPressed: saveContact,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Contact Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: mobileController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Street Address'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Company Name'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: designationController,
              decoration: const InputDecoration(labelText: 'Designation'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: websiteController,
              decoration: const InputDecoration(labelText: 'Website'),
              validator: (value) {
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    companyController.dispose();
    designationController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  void saveContact() {
    if(_formKey.currentState!.validate()){
     widget.contactModel.name = nameController.text;
     widget.contactModel.mobile = mobileController.text;
     widget.contactModel.email = emailController.text;
     widget.contactModel.address = addressController.text;
     widget.contactModel.company = companyController.text;
     widget.contactModel.designation = designationController.text;
     widget.contactModel.website = websiteController.text;


     Provider.of<ContactProvider>(context, listen: false).insertContact(
         widget.contactModel)
         .then((value){
       if(value > 0){
         showMsg(context, 'Saved!');
         context.goNamed(HomePage.routeName);

       }
     })
         .catchError((onError){
       showMsg(context, 'Failed to save!');
     });

    }

   }
}
