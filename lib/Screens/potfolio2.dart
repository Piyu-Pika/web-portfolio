import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectUI extends StatefulWidget {
  @override
  _ProjectUIState createState() => _ProjectUIState();
}

class _ProjectUIState extends State<ProjectUI> {
  late Stream<QuerySnapshot> _projectsStream;

  @override
  void initState() {
    super.initState();
    _projectsStream =
        FirebaseFirestore.instance.collection('projects').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _projectsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProjectDetailScreen(projectId: document.id),
                          ),
                        );
                      },
                      child: ChatItemWidget(
                          ProjectItem: ChatItem.fromMap(data, document.id)),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem {
  final String id;
  final String name;
  final String? message;
  final String? file;
  final int? count;
  final String? date;

  ChatItem({
    required this.id,
    required this.name,
    this.message,
    this.file,
    this.count,
    this.date,
  });

  factory ChatItem.fromMap(Map<String, dynamic> map, String id) {
    return ChatItem(
      id: id,
      name: map['name'] ?? '',
      message: map['message'],
      file: map['file'],
      count: map['count'],
      date: map['date'],
    );
  }
}

class ChatItemWidget extends StatelessWidget {
  final ChatItem ProjectItem;

  const ChatItemWidget({super.key, required this.ProjectItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(ProjectItem.name[0]),
      ),
      title: Text(ProjectItem.name),
      subtitle: ProjectItem.message != null
          ? Text(ProjectItem.message!)
          : ProjectItem.file != null
              ? Text(ProjectItem.file!)
              : null,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (ProjectItem.count != null)
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.deepPurpleAccent,
              child: Text(
                ProjectItem.count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          if (ProjectItem.date != null)
            Text(
              ProjectItem.date!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('projects')
            .doc(projectId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data['imageUrl'] ?? ''),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      data['content'] ?? '',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(data['link'] ?? ''),
                      child: const Text('Visit Link'),
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
