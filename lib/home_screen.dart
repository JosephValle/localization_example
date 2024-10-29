import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const HomeScreen({super.key, required this.onLocaleChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _name = '';

  void submitForm() {
    setState(() {
      _name = _controller.text;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String locale) {
              widget.onLocaleChange(Locale(locale));
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'it',
                  child: Text('Italiano'),
                ),
                PopupMenuItem(
                  value: 'es',
                  child: Text('Español'),
                ),
                PopupMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.subtitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              loc.body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: loc.textInputHint,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: submitForm,
                  child: Text(loc.buttonText),
                ),
              ],
            ),
            if (_name.trim().isNotEmpty) const SizedBox(height: 10),
            if (_name.trim().isNotEmpty)
              Text(
                loc.textInput(_name.trim()),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
