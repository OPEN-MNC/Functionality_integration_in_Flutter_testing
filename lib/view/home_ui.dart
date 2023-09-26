import 'package:first_app/provider/uswe_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Fetch data from the API when the widget initializes
    Provider.of<UserProvider>(context, listen: false).getDataFromAPI();
    debugPrint("initState run");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build function run");
    // We can use this method to access the models
    final userProvider = Provider.of<UserProvider>(context);
    // return Consumer<UserProvider>(
    //   builder: (context, yourDataModel, child) {
    //     // Use yourDataModel here.
    return Scaffold(
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : userProvider.error.isNotEmpty
              ? Center(
                  child: Text(
                      'Error: ${userProvider.error}'), // Show error message
                )
              : ListView.builder(
                  itemCount: userProvider.userData.length,
                  itemBuilder: (context, index) {
                    // Access individual properties of UserDataModel
                    final userData = userProvider.userData[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://media.licdn.com/dms/image/D4D03AQHWKO3uQaPt-w/profile-displayphoto-shrink_800_800/0/1684072768275?e=2147483647&v=beta&t=O2pci-Ns8Io-3kRP6S6f8Vqp3C5XBO4ZB33Hbh0xCtg"),
                        radius: 35,
                      ),
                      title: Text('User ID: ${userData.userId}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${userData.id}',
                          ),
                          Text('Title: ${userData.title}'),
                          Text(
                            'Body: ${userData.body}',
                            maxLines: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
