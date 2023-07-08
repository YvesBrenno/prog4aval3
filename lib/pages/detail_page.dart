import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> title;

  const DetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title['titleText']['text'] ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title['primaryImage'] != null)
                SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    title['primaryImage']['url'],
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tipo: ${title['titleType']?['text'] ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Gênero: ${title['genres']?['genres']?[0]?['text'] ?? 'Gênero desconhecido'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ano de lançamento: ${title['releaseYear']?['year'] ?? ''}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sinopse: ${title['plot']?['plotText']?['plainText'] ?? 'Sinopse desconhecida'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Classificação: ${title['ratingsSummary']?['aggregateRating'] ?? 'Sem classificação'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
