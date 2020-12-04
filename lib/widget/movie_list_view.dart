import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {
  final list;
  const MovieListView(this.list, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();
        else
          return ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String image = snapshot.data[index].postImage;
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          );
      },
    );
  }
}
