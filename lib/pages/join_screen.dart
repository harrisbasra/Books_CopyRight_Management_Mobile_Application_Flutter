import 'package:flutter/material.dart';
import 'api_call.dart';
import 'ils_screen.dart';
import 'package:videosdk/videosdk.dart';

class JoinScreen extends StatelessWidget {
  final _meetingIdController = TextEditingController();

  JoinScreen({super.key});

  //Creates new Meeting Id and joins it in CONFERNCE mode.
  void onCreateButtonPressed(BuildContext context) async {
    // call api to create meeting and navigate to ILSScreen with meetingId,token and mode
    await createMeeting().then((meetingId) {
      if (!context.mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: Mode.CONFERENCE,
          ),
        ),
      );
    });
  }

  //Join the provided meeting with given Mode and meetingId
  void onJoinButtonPressed(BuildContext context, Mode mode) {
    // check meeting id is not null or invaild
    // if meeting id is vaild then navigate to ILSScreen with meetingId, token and mode
    String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: mode,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid meeting id"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Live Stream'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Creating a new meeting
            ElevatedButton(
              onPressed: () => onCreateButtonPressed(context),
              child: const Text('Instant Meeting'),
            ),
            const SizedBox(height: 40),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter Meeting Id',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.white),
              ),
              controller: _meetingIdController,
            ),
            //Joining the meeting as host
            ElevatedButton(
              onPressed: () => onJoinButtonPressed(context, Mode.CONFERENCE),
              child: const Text('Host Meeting '),
            ),
            //Joining the meeting as viewer
            ElevatedButton(
              onPressed: () => onJoinButtonPressed(context, Mode.VIEWER),
              child: const Text('Join Meeting as Viewer'),
            ),
          ],
        ),
      ),
    );
  }
}