import 'package:flutter/material.dart';

class HomeScreenComponent extends StatelessWidget {
  final horizontalListItems = [];

  HomeScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 9,
              itemBuilder: (_, i) {
                if (i < 2) {
                  return _buildBox();
                } else if (i == 3)
                  return Column(
                    children: [
                      Center(child: const Text(" HorizontalView Layout starts Here")),
                      _horizontalListView(),
                      Center(child: const Text(" HorizontalView Layout Ends Here")),
                    ],
                  );
                else if (i == 6)
                  return  Column(
                    children:[
                      Center(child: const Text("Grid View Layout starts Here")),
                      _GridViewCount(),
                      Center(child: const Text(" Grid View Layout Ends Here")),
                    ],
                  );
                else
                  return _buildBox();
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => _buildBoxHorizontal(),
    ),
    );
  }

  Widget _buildBoxHorizontal() => Container(
    margin: EdgeInsets.all(12), height: 100, width: 200,child: Image.network("https://ik.imagekit.io/altajfood/ar_asset/pexels-fox-225157.jpg", fit: BoxFit.cover),);

  Widget _buildBox() => Container(
    margin: EdgeInsets.all(12), height: 100, width: 200,child: Image.network("https://ik.imagekit.io/altajfood/ar_asset/tenderplaceholder.jpg", fit: BoxFit.cover),);

  Widget _GridViewCount() => GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: <String>[
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
        'https://ik.imagekit.io/altajfood/ar_asset/pexels-alex-andrews-821750.jpg',
      ].map((String url) {
        return GridTile(
            child: Image.network(url, fit: BoxFit.cover));
      }).toList());
}