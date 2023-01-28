import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vampire Survivors Save Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const PermissionHandlerScreen(),
    );
  }
}

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({super.key});

  @override
  State<PermissionHandlerScreen> createState() => PermissionHandlerScreenState();
}

class PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  @override
  void initState() {
    super.initState();
    permissionServiceCall();
  }

  permissionServiceCall() async {
    await permissionServices().then(
        (value) {
          if (value[Permission.storage] != null && value[Permission.manageExternalStorage] != null) {
            if (value[Permission.storage]!.isGranted && value[Permission.manageExternalStorage]!.isGranted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const HomePage(title: 'Vampire Survivors Save Manager')
                )
              );
            }
          }
        }
    );
  }

  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (statuses[Permission.storage] != null && statuses[Permission.manageExternalStorage] != null) {
      if (statuses[Permission.storage]!.isPermanentlyDenied || statuses[Permission.manageExternalStorage]!.isPermanentlyDenied) {
        await openAppSettings();
      }
    }

    return statuses;
  }

  @override
  Widget build(BuildContext context) {
    permissionServiceCall();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              permissionServiceCall();
            },
            child: const Text('Click here to enable Enable Permission Screen'),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.download)),
              Tab(icon: Icon(Icons.upload)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExportTab(),
            ImportTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}

class ExportTab extends StatefulWidget {
  const ExportTab({super.key});

  @override
  State<ExportTab> createState() => ExportTabState();
}

class ExportTabState extends State<ExportTab> {
  bool rename = true;

  @override
  Widget build(BuildContext context) {
    void exportSave() {
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
}
