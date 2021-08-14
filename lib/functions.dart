import 'dart:convert';

import 'package:cron/cron.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

import 'package:http/http.dart' as http;

@CloudFunction()
Future<Response> function(Request request) async {
  // var listJob = <NotificationJob>[];

  final cron = Cron();
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    try {
      var notification = {};
      notification['body'] = 'Teste de Mensagem Rest';

      var s = jsonEncode(
        <String, dynamic>{
          'to':
              'cDJdDgc3RdqOqqUxjo05cb:APA91bFKCQtrkyTBiHqLQ-lGvsuLHLeJ-qAFSCpTm8BdM8Za-9hvb3PXLlE468mjiekY__Uq8030OJrJZ8HJjaSGou0rDIkj_eGMYHrFemeRA_e_B-tfwo3KG0iMcyFSuLvvVK-iDXUo',
          'notification': notification
        },
      );

      print(s);

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAbqXGUq0:APA91bGsncFGi-quetMeVbmn_1vN3XRNPPQSmx-lBR7PChmlve-l54zJ7sHTKDKJQ1jWZt5WUt57RzK74TE8VTdr6zRhLckJ3GtNRkMBY0731e0QYikPQngQbBvvmgI_-rDzhVLmvaqa',
        },
        body: s,
      );
    } on Exception catch (e) {
      print(e);
    }
  });

  // listJob.add(NotificationJob(1, cron));
  // final cron1 = Cron();
  // cron.schedule(Schedule.parse('*/1 * * * *'), () async {
  //   print('2');
  // });
  // listJob.add(NotificationJob(2, cron1));

  return Response.ok('Hello, World!');
}

class NotificationJob {
  final int id;
  final Cron cron;

  NotificationJob(this.id, this.cron);
}
