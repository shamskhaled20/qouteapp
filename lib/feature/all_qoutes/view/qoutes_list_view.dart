import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoute/feature/all_qoutes/view_model/get_all_qoutes_cubit/get_all_qoutes_status.dart';
import '../../../core/utits/thema.dart';
import '../data/model_qoute.dart';
import '../view_model/add_qoute_cubit/add_qoute_cubit.dart';
import '../view_model/get_all_qoutes_cubit/get_all_qoutes_cubit.dart';

class QouteList extends StatefulWidget {
  @override
  _QouteListState createState() => _QouteListState();
}

class _QouteListState extends State<QouteList> {
  late AddQuoteCubit addQuoteCubit;
  TextEditingController quoteController = TextEditingController();
  TextEditingController authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<QoutesCubit>().fetchProducts();
    addQuoteCubit = context.read<AddQuoteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final ThemeProvider themeProvider = context.watch<ThemeProvider>();

        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.themeData,
          darkTheme: ThemeData.dark(),
          themeMode: context.watch<ThemeCubit>().state,
          home: Scaffold(
            appBar: AppBar(
              title: Text('Quote List'),
              actions: [
                IconButton(
                  icon: Icon(Icons.lightbulb),
                  onPressed: () {
                    // Toggle between light and dark mode
                    final Brightness newBrightness =
                    themeProvider.themeData.brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light;
                    themeProvider.setThemeData(
                      ThemeData(
                        brightness: newBrightness,
                        // Other theme properties
                      ),
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<QoutesCubit, QouteState>(
              builder: (context, state) {
                if (state is QouteInitial) {
                  return Center(child: Text('Please fetch quotes.'));
                } else if (state is QouteLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is QouteLoaded) {
                  List<Quote> quotes = state.quotes;
                  return ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0), // Adjust these values as needed
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Author: ${quotes[index].author}'),
                            ],
                          ),
                          subtitle: Text('Quote: ${quotes[index].quote}'),
                        ),
                      );
                    },
                  );
                  ;
                } else if (state is QouteError) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else {
                  return Center(child: Text('Unexpected state.'));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAlertDialog(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Quote'),
          content: Column(
            children: [
              TextField(
                controller: quoteController,
                decoration: InputDecoration(labelText: 'Quote'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String quote = quoteController.text;
                String author = authorController.text;

                addQuoteCubit.addQuote(quote, author);

                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

