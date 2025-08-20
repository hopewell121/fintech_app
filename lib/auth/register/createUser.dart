import 'package:flutter/material.dart';
import 'package:online_shop_app/auth/register/register_provider.dart';
import 'package:online_shop_app/auth/signin/login.dart';


class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  UserFormState createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   final _avatarcontroller = TextEditingController();
  bool _obscurePassword = true;
  bool isLoading = false;
  final RegisterProvider registerProvider = RegisterProvider();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _avatarcontroller.dispose();
    super.dispose();
  }

  void _submitForm() async{

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    if (_formKey.currentState!.validate()) {
      // Process the form data
      setState(() {
        isLoading =true;
      });
    if( _formKey.currentState!.validate()){
      await registerProvider.register(
        context,
        _nameController.text.trim(),
        _emailController.text.trim(), 
        _passwordController.text.trim(),
         _avatarcontroller.text.trim());
    }
    setState(() {
      isLoading =false;
    });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),):
      
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0,),


              TextFormField(
                controller: _avatarcontroller,
                decoration: InputDecoration(
                  labelText: 'Avatar',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.person
                    ),
                    onPressed: () {
                      setState(() {
                       
                      });
                    },
                  ),
                ),
               
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your pics';
                  }
                  if (value.length < 6) {
                    return '';
                  }
                  return null;
                },
              ),
SizedBox(height: 20,),
              Row(
                children: [
                  Text('If you also have account?'),
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: Text(' Sign In', style: TextStyle(fontSize: 20,color: Colors.amber, fontWeight: FontWeight.bold),))
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.amber
                ),
                child: const Text( 
                  'Submit',
                  style: TextStyle(fontSize: 20, color: Colors.white,),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}