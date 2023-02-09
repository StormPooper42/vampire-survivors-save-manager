import 'package:flutter/material.dart';

import 'app_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
      title: 'Vampire Survivors Save Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      )
    );
  }
}

// devo aggiungere una appbar col titolo
// il pulsante lo voglio cambiare per renderlo "fisico"
// aggiungere pulsante per opzioni
// rimuovere la preview del file

/*class ExportTab extends StatefulWidget {
  const ExportTab({super.key});

  @override
  State<ExportTab> createState() => ExportTabState();
}

class ExportTabState extends State<ExportTab> {
  bool rename = true;

  @override
  Widget build(BuildContext context) {
    void exportSave() {
      Saf.getDynamicDirectoryPermission();

      final file = File('/storage/emulated/0/Android/data/com.poncle.vampiresurvivors/files/SaveDataUnity.sav');
      if (!file.existsSync()) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Cannot find the save file in the game directory'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text('Close'),
                    ),
                )
              ],
            )
        );
      } else {
        file.copySync('/storage/emulated/0/Download');
        if (rename) {
          file.renameSync('SaveData');
        }
        const snackBar = SnackBar(
          content: Text('File successfully exported!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
              onPressed: exportSave,
              child: const Text('Export'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Rename file'),
                Checkbox(
                  value: rename,
                  onChanged: (bool? value) {
                    setState(() {
                      rename = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImportTab extends StatelessWidget {
  const ImportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Import'),
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}*/
