import 'package:flutter/material.dart';

class GridViewComponwnt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: <String>[
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',
          'https://ik.imagekit.io/altajfood/ar_asset/Screenshot%202023-07-31%20at%206.55.08%20AM.png',

        ].map((String url) {
          return GridTile(child: Image.network(url, fit: BoxFit.cover));
        }).toList());
  }
}

class HorizontalListViewComponwnt extends StatelessWidget {
  final horizontalListItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (_, i) {
              if (i < 2)
                return _buildBox(color: Colors.blue);
              else if (i == 3)
                return _horizontalListView();
              else
                return _buildBox(color: Colors.blue);
            },
          ),
        ),
      ],
    );
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => _buildBox(color: Colors.orange),
      ),
    );
  }

  Widget _buildBox({required Color color}) => Container(margin: EdgeInsets.all(12), height: 100, width: 200, color: color);
}


class VerticalListViewComponwnt extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: const <Widget>[
              ListTile(leading: Text("First"),),
              ListTile(leading: Text("First"),),
              ListTile(leading: Text("First"),),
              ListTile(leading: Text("First"),),
              ListTile(leading: Text("First"),),
            ],
          ),
        ),
      ],
    );
  }
}

