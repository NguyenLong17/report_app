import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/model/contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final contacts = <Contact>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Contact'),
      body: FutureBuilder<List<Contact>>(
        future: getContacts(),
        builder: (context, snapshot){
          contacts.clear();
          contacts.addAll(snapshot.data ?? []);
          if (snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          return buildList();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getContacts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return buildItem(contact);
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: contacts.length,
    );
  }

  Widget buildItem(Contact contact) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text('#${contact.id}'),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(contact.avatar ?? '', fit: BoxFit.cover,),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(contact.name ?? ''),
          ),
        ],
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    final uri = Uri.parse('http://api.quynhtao.com/api/users');
    final response = await http.get(uri);

    print('response');
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      return List<Contact>.from(json.map((e) => Contact.fromJson(e)));

    }

    throw Exception('Có lỗi xảy ra, http status code: ${response.statusCode}');


  }
}
