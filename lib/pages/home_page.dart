import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../pages/detail_page.dart';
import '../pages/crew_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? titles;
  List<dynamic>? genres; // Lista de gêneros
  String? selectedGenre; // Gênero selecionado
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchGenres(); // Busca os gêneros
    fetchTitles();
  }

  Future<void> fetchGenres() async {
    try {
      final Map<String, dynamic> data = await _apiService.getGenres();
      setState(() {
        genres = data['genres'];
      });
    } catch (error) {
      print('Error fetching genres: $error');
    }
  }

  Future<void> fetchTitles() async {
    try {
      final Map<String, dynamic> data = await _apiService.getTitlesByYear(2023);
      setState(() {
        titles = data['results'];
      });
    } catch (error) {
      print('Error fetching titles: $error');
    }
  }

  void navigateToDetailsPage(Map<String, dynamic> title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(title: title),
      ),
    );
  }

  void navigateToCrewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CrewPage(
          titles: ['Brenno Yves Damasceno Morais'],
        ),
      ),
    );
  }

  void onGenreChanged(String? genre) {
    setState(() {
      selectedGenre = genre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Database'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: navigateToCrewPage,
          ),
        ],
        // Adicione o DropdownButton no AppBar
        flexibleSpace: selectedGenre != null
            ? Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 16),
                child: DropdownButton<String>(
                  value: selectedGenre,
                  items: genres?.map((genre) {
                    return DropdownMenuItem<String>(
                      value: genre,
                      child: Text(
                        genre,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: onGenreChanged,
                ),
              )
            : null,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: titles != null
              ? ListView.builder(
                  itemCount: titles!.length,
                  itemBuilder: (context, index) {
                    final title = titles![index];
                    // Verifica se o gênero selecionado é igual ao gênero do título
                    if (selectedGenre == null ||
                        title['genres']?['genres']?[0]?['text'] == selectedGenre) {
                      return GestureDetector(
                        onTap: () => navigateToDetailsPage(title),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                          ),
                          child: ListTile(
                            title: Text(
                              title['titleText']['text'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              title['titleType']['text'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Retorna um Container vazio para não exibir o título
                      return Container();
                    }
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
