import 'package:flutter/material.dart';
import 'package:rapidapi_app/models/title_model.dart';

class TitleCard extends StatelessWidget {
  final TitleModel title;

  const TitleCard({required this.title});

  @override
  Widget build(BuildContext context) {
    print('Title: $title'); // Log
    return ListTile(
      leading: Image.network(title.primaryImage),
      title: Text(title.titleText),
      subtitle: Text('${title.releaseDate} - ${title.genres.join(", ")}'),
    );
  }
}