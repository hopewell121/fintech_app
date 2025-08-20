import 'package:flutter/material.dart';
import 'package:online_shop_app/screens/profile/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
@override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          if (profile.profileModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              children: [
                
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    profile.profileModel!.avatar.toString(),
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  
                  leading: const Icon(Icons.email),
                  title: Text(profile.profileModel!.email.toString()),
                 
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),

                ),

                 ListTile(
                  
                  leading: const Icon(Icons.person),
                  title: Text(profile.profileModel!.name.toString()),
             
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),

                ),
                 ListTile(
                  
                  leading: const Icon(Icons.password),
                  title: Text(profile.profileModel!.password.toString()),
              
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),

                ),

                 ListTile(
                  
                  leading: const Icon(Icons.card_giftcard),
                  title: Text(profile.profileModel!.id.toString()),
              
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),

                ),

                 ListTile(
                  
                  leading: const Icon(Icons.person),
                  title: Text(profile.profileModel!.role.toString()),
              
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),

                ),

                 
              ],
            ),
          );
        }),
    );
  }
}