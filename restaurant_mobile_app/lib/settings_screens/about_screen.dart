import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Style Template
    var _headingTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    // Open Url
    Future<void> _openUrl(String url) async {
      Uri uri = Uri.parse(url);
      !await launchUrl(uri);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // shape: Border(
        //   bottom: BorderSide(color: Colors.black, width: 0.2),
        // ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Description",
                      style: _headingTextStyle,
                    ),
                  ),
                  Text(
                      "Create Simple Mobile App with Flutter that connected with RESTful API"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Creator",
                      style: _headingTextStyle,
                    ),
                  ),
                  Text("Khip01 (Akhmad Aakhif Athallah)"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Link",
                    style: _headingTextStyle,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    leading: SizedBox(
                      child: ClipOval(
                        child: Image.asset(
                          "assets/gitProfPic.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      width: 24,
                    ),
                    title: Text(
                      "Github Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "github.com/Khip01",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    onTap: () async =>
                        await _openUrl("https://github.com/Khip01"),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    leading: SizedBox(
                      child: ClipOval(
                        child: Image.asset(
                          "assets/githubIcon.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      width: 24,
                    ),
                    minLeadingWidth: 10,
                    title: Text(
                      "Github Repo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "github.com/Khip01/Restaurant_Khip01",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    onTap: () async => await _openUrl(
                        "https://github.com/Khip01/Restaurant_Khip01"),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    leading: SizedBox(
                      child: ClipOval(
                        child: Image.asset(
                          "assets/linkedInIcon.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      width: 24,
                    ),
                    minLeadingWidth: 10,
                    title: Text(
                      "LinkedIn",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "linkedin.com/in/khip01",
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    onTap: () async => await _openUrl(
                        "https://www.linkedin.com/in/khip01"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
