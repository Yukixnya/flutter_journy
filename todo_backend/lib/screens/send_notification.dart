import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:todo_backend/screens/login_page.dart';

Future<String> getAccessToken() async {
  final serviceAccountJson = {
    "type": "service_account",
    "project_id": "todobackendflutter",
    "private_key_id": "8fd69971131be52933d5f1f1ecf86b48702e6672",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDN4y+8WdpoaG7n\nTBIIVO+9r7N/uMGUSUpTphyfYdj93xD2n/xf6VHmfc1/VgnLVvbm7Fo54oPsLQzY\nTiDEMMyyenepu5dNIFGsYrytWaOLctm/paW/nyV4JDaj+238PBJjSEzdHNzsP1vi\n1Fox9hTJLpWrccgCuoUz3v1eL2rqAc439anuh/KaldpaMfffLHHftGLk86DhrZ/k\n+uPt3tBviMkJThuJfAn0wuDoqFEkOqs6ZDCWDYhSo3vQgSjK8+SX2aeuh2VdfzBG\nYDPrtyzwp44E5EbTap/Snl06/qTN000QnbRBJjqLdn7ADRlpiO6JdNx0a2fnk0Fv\n8cbVMtLjAgMBAAECggEACcTzABSTnqrFeb7zQMOfbwokUefiAO0BIrPBLAuRC10K\n6YR7xpbZdqJXbL3CrG/BHjrEDJNufEztYmHtxt+kW1TLUufecIp+4hBsqZ1OF/EB\nPp60R8HN8y6BmsmRBy+Q+Oh9oE+kPfxtqD5xYr67xImdu0CWRy36b/hFCuyO9qoS\nnkZsoeXV/GbDXqsxUMitJTCRuQPX2zeJWfWgEAUgGTnJ0aX4rwWg9W4kHLi57DXc\njmO0rIoaBxg1NuR3RUyeDHyvhEGKXMqBRcOxdpfm6GSqj6aAqOL+pijLZVbbPzjF\nKhSUvd74+7wLdUrJZEoZRxHXunPecv3NmjRKydHsxQKBgQD6vI2umqqPO5K2pPuP\ny5m4RpzN+L9LmYDP1y9qMkjgqaOCCKFv/nhcBMfyRiFB/6MKZZSEIBiUhZHVowzQ\n3JCB3MU13+tCJIRXEeDs067g+dxwhyrLIzRIg9SYwHW+A933qIGHULZ8Eqk9F+aC\nilkRxVsHvBvqRn1iM4e5/E3yNQKBgQDSNZ237xFwczTc3/8sjf8YOZlD3oiRmd7h\nNZTUcwVxGHhD1887Xrxaapriw6l1Q7yyeAMiOvWRnYf8L+eb47INft1TJZHbFwc4\nEsCazlLgT/AfdrHHXZIXT+586BN4dz27XJQUQphQRVILh47ugJzqcx9NwDbwdSxO\napxEepXTtwKBgE5Q0pg06w0t+FdgFMsHNw5dz+Btz6JXYeqJNeAfsK+rjMyy0Wnf\nu8xSGfnMedrZdB1tOQRD2imZxsFJ2ljqa6CESnzXYe4Y5dUkWnLec4MFyBrFvVIR\nvuTfeGn1w1EEeDJAyaRwS29ZjM7uRiuD9uocEKDL2pRETCl+Gui2q8n5AoGALkPO\nqqTbWbyBbft+1feKpXJH4UAhHqqW+0onr3qBQBr6nTPqUE7RdbTw0efua/i0lzMC\nvY3sblgVjdOdThoXHhFF9P7X0ziGRjkaWvf+FZCCcOpWxmI5vRfCjYsmfeUAmTQP\nA0aE72XSYOc89hEoeBFOWnZroRCo57lfG1M/lpECgYBrTfsAYJGBY1t262rLFlhk\nklYIBibRml1K32OExvlHHdOJUglDJsrUXf1CkZWlmv4kwB/5m3w8ATDXJVLQIxv6\nvdzOOmujVmkigyKCmkL69OWyDuJL0yyHtkRPbVkqSVH6jgoWyh+n4RvhAHlJgfYe\nGIcFVGksiQDUwHD9QZLzJw==\n-----END PRIVATE KEY-----\n",
    "client_email":
        "firebase-adminsdk-fbsvc@todobackendflutter.iam.gserviceaccount.com",
    "client_id": "112037282323659684261",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40todobackendflutter.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
  };

  List<String> scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  http.Client client = await auth.clientViaServiceAccount(
    auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
    scopes,
  );

  auth.AccessCredentials credentials = await auth
      .obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );

  client.close();

  return credentials.accessToken.data;
}

Future<void> sendNotification({
  required token,
  required String title,
  required String body,
}) async {
  final String serverToken = await getAccessToken();
  print('Server Token: $serverToken');

  final Uri url = Uri.parse(
    'https://fcm.googleapis.com/v1/projects/todobackendflutter/messages:send',
  );

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $serverToken",
  };

  final bodyData = {
    "message": {
      "token": token,
      "notification": {"title": title, "body": body},
    },
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(bodyData),
    );

    if (response.statusCode == 200) {
      print("-----Notification Sent------");
    } else {
      print("-----Failed To Send------");
    }
  } on FirebaseException catch (e) {
    throw Exception('Error sending notification: ${e.message}');
  }
}


class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final TextEditingController _messageController = TextEditingController();

  Future<void> handleSendNotification() async {
    if(selectedUserId != null && _messageController.text.trim().isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a user and enter a message")));
      return;
    }

  final doc = await FirebaseFirestore.instance.collection('users').doc(selectedUserId).get();
  
  final data = doc.data() as Map<String, dynamic>?;
  final token = data?['fcmToken'];
  final name = data?['username'] ?? 'user';
  if (token != null && token.toString().isNotEmpty) {
    await sendNotification (token: token, title: "$name", body: _messageController.text);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notification sent successfully!")));
    }
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cannot send: This user hasn't logged in recently to register their notification token.")));
    }
  }
}

  String? selectedUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Notification"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter a text",
              ),
            ),
            SizedBox(height: 10),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final user = snapshot.data!.docs;

                return DropdownButtonFormField(
                  items: user.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return DropdownMenuItem<String>(
                      value: doc.id,
                      child: Text(data['username'] ?? "null"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUserId = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select a friend",
                  ),
                );
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: handleSendNotification, child: Text("Send Notification")),
          ],
        ),
      ),
    );
  }
}
