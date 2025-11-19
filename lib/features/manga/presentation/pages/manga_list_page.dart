import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/manga_provider.dart';

class MangaListPage extends StatelessWidget {
  const MangaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MangaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes mangas')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.mangas.length,
              itemBuilder: (context, i) {
                final m = provider.mangas[i];
                return ListTile(
                  leading: m.imageUrl != null ? Image.network(m.imageUrl!) : null,
                  title: Text(m.title),
                  subtitle: Text(m.status.toString().split('.').last),
                  onTap: () {
                    // TODO: navigate to details page
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: afficher formulaire d'ajout
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
