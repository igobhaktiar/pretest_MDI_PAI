import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretest_mdi_pai/pages/detail_page.dart';
import '../api/api.dart';
import '../data/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _users;
  final limitController = TextEditingController();
  final queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _users = Api().searchUser(query: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  color: Colors.grey.withOpacity(0.2),
                  child: Center(
                    child: TextField(
                      controller: queryController,
                      // menampilkan data pencarian
                      onChanged: (query) {
                        setState(() {
                          // menampilkan data tanpa limit data
                          if (limitController.text.isEmpty) {
                            _users = Api().searchUser(query: query);
                          } else {
                            // menampilkan limit data
                            final limit = limitController == ""
                                ? 100
                                : int.parse(limitController.text);
                            _users = Api().searchUser(
                                query: queryController.text, limit: limit);
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Insert Data Lenght :",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextField(
                                // controller limit data
                                controller: limitController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    // menampilkan data tanpa limit data
                                    if (limitController.text.isEmpty) {
                                      final query = queryController.text;
                                      _users = Api().searchUser(query: query);
                                    } else {
                                      // menampilkan limit data dari input limit data
                                      final limit = limitController == ""
                                          ? 100
                                          : int.parse(limitController.text);
                                      _users = Api().searchUser(
                                          query: queryController.text,
                                          limit: limit);
                                    }
                                  });

                                  print(limitController.text);
                                  Navigator.pop(context);
                                },
                                color: Colors.blue,
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.tune_outlined),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _users,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(userData: data),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        child: Column(
                          children: [
                            Text("${data.firstName} ${data.lastName}"),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
