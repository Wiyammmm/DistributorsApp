import 'dart:io';

import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/transactionhistory.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class GenerateReport extends StatefulWidget {
  const GenerateReport({super.key});

  @override
  State<GenerateReport> createState() => _GenerateReportState();
}

class _GenerateReportState extends State<GenerateReport> {
  MyModals myModals = MyModals();
  HttprequestService httprequestService = HttprequestService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final _myBox = Hive.box('myBox');

  Map<String, dynamic> userInfo = {};
  int selectedDateRangeId = 0;
  bool _isSubmitEnabled = false;
  DateTime? selectedFromDate;
  DateTime? selectedtoDate;

  final List<Map<String, dynamic>> dateRange = [
    {'id': 1, 'dateRange': 'Last 7 Days'},
    {'id': 2, 'dateRange': 'Last 30 Days'},
    {'id': 3, 'dateRange': 'Last 60 Days'},
    {'id': 4, 'dateRange': 'Custom'},
  ];
  String? selectedDateRange;
  @override
  void initState() {
    userInfo = _myBox.get('userInfo');
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _updateRangeDateController(int range) {
    DateTime today = DateTime.now();

    setState(() {
      switch (range) {
        case 1:
          DateTime daysAgo = today.subtract(Duration(days: 7));
          _isSubmitEnabled = true;
          _fromDateController.text =
              '${DateFormat('MMM dd,yyyy').format(daysAgo)}';
          _toDateController.text = '${DateFormat('MMM dd,yyyy').format(today)}';
          selectedFromDate = daysAgo;
          selectedtoDate = today;
          break;

        case 2:
          DateTime daysAgo = today.subtract(Duration(days: 30));
          _isSubmitEnabled = true;
          _fromDateController.text =
              '${DateFormat('MMM dd,yyyy').format(daysAgo)}';
          _toDateController.text = '${DateFormat('MMM dd,yyyy').format(today)}';
          selectedFromDate = daysAgo;
          selectedtoDate = today;
          break;
        case 3:
          DateTime daysAgo = today.subtract(Duration(days: 60));
          _isSubmitEnabled = true;
          _fromDateController.text =
              '${DateFormat('MMM dd,yyyy').format(daysAgo)}';
          _toDateController.text = '${DateFormat('MMM dd,yyyy').format(today)}';
          selectedFromDate = daysAgo;
          selectedtoDate = today;
          break;
        case 4:
          _isSubmitEnabled = false;
          _fromDateController.text = '';
          _toDateController.text = '';
          selectedFromDate = null;
          selectedtoDate = null;
          break;
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _toDateController.text = '';
        selectedFromDate = selectedDate;

        _fromDateController.text =
            DateFormat('MMM dd,yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    DateTime today = DateTime.now();
    if (selectedFromDate != null) {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedFromDate,
        firstDate: DateTime(selectedFromDate!.year, selectedFromDate!.month,
            selectedFromDate!.day),
        lastDate: today,
      );

      if (selectedDate != null) {
        setState(() {
          selectedtoDate = selectedDate;
          _toDateController.text =
              DateFormat('MMM dd,yyyy').format(selectedDate);
          _isSubmitEnabled = true;
        });
      }
    }
  }

  Future<bool> _generatePasswordProtectedPDFAndSendEmail(
      List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    final content = pw.Column(
      children: data
          .map(
              (item) => pw.Text('Reference Number: ${item['referenceNumber']}'))
          .toList(),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Generated Transaction History',
                    style: pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Text(
                    'From Date: ${DateFormat('MMM dd,yyyy').format(selectedFromDate!)}'),
                pw.Text(
                    'To Date: ${DateFormat('MMM dd,yyyy').format(selectedtoDate!)}'),
                pw.SizedBox(height: 20),
                pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Container(
                      width: 20,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text('Type'),
                    ),
                    pw.Container(
                      width: 70,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text('Reference Number'),
                    ),
                    pw.Container(
                      width: 30,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text('Previous Amount'),
                    ),
                    pw.Container(
                      width: 30,
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Text('New Amount'),
                    ),
                  ]),
                ]),
                for (var item in data)
                  pw.Table(
                    children: [
                      pw.TableRow(children: [
                        pw.Container(
                          width: 20,
                          alignment: pw.Alignment.center,
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(item['transactionType'] ?? ''),
                        ),
                        pw.Container(
                          width: 70,
                          alignment: pw.Alignment.center,
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(item['referenceNumber'] ?? ''),
                        ),
                        pw.Container(
                          width: 30,
                          alignment: pw.Alignment.center,
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(
                              item['senderPreviousBalance']?.toString() ?? ''),
                        ),
                        pw.Container(
                          width: 30,
                          alignment: pw.Alignment.center,
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(
                              item['senderNewBalance']?.toString() ?? ''),
                        ),
                      ]),
                    ],
                  )
              ]);
        },
      ),
    );

    // Save PDF to a temporary file
    final tempDir = await Directory.systemTemp.createTemp('pdf');
    final tempFile = File('${tempDir.path}/GeneratedTransactionHistory.pdf');
    await tempFile.writeAsBytes(await pdf.save());

    // Send email with PDF attachment
    final smtpServer = gmail('zxcv.jan1212@gmail.com', 'kxjtzodjsckajivd');
    final message = Message()
      ..from = const Address(
          'zxcv.jan1212@gmail.com', 'NO REPLY SEA DISTRIBUTORS APP')
      // ..recipients.add('${userInfo['email']}')
      ..recipients.add('zxcv.jan1216@gmail.com')
      ..subject = 'Transaction History'
      ..text =
          'Generated Transaction History, Please find the attached PDF report.'
      ..attachments.add(FileAttachment(tempFile)..location = Location.inline);

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport}');
      return true;
    } catch (e) {
      Navigator.of(context).pop();
      myModals.errorModal(
          context, 'Something went wrong, please try again later');
      print('Error occurred while sending email: $e');
      return false;
    }
  }

  Future<void> _generateReport() async {
    print('_generateReport');
    if (selectedFromDate != null && selectedtoDate != null) {
      myModals.showProcessing(context, 'Generating Reports');
      final responseTransactionHistory =
          await httprequestService.filterGetTransactionHistory({
        "fromDate": selectedFromDate!.toIso8601String(),
        "toDate": selectedtoDate!.toIso8601String(),
      });
      // try {
      if (responseTransactionHistory['messages'][0]['code'].toString() == "0") {
        final transactionList =
            (responseTransactionHistory['response'] as List<dynamic>)
                .cast<Map<String, dynamic>>();

        transactionList.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));

        print('transactionList: $transactionList');
        bool isSent =
            await _generatePasswordProtectedPDFAndSendEmail(transactionList);
        if (isSent) {
          Navigator.of(context).pop();
          myModals.successModal(context, 'Email Sent', (value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransactionHistoryPage()),
            );
          });
        } else {
          Navigator.of(context).pop();
          myModals.errorModal(
              context, 'Something went wrong, please try again later');
          print('Error occurred while sending email');
        }
      } else {
        Navigator.of(context).pop();
        myModals.errorModal(
            context, 'Something went wrong, please try again later');
      }
      // } catch (e) {
      //   Navigator.of(context).pop();
      //   myModals.errorModal(
      //       context, 'Something went wrong, please try again later');
      //   print('transactionList error:');
      //   print(e);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FloatingActionButton.extended(
              backgroundColor:
                  _isSubmitEnabled ? Colors.blueAccent : Colors.blue[100],
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_isSubmitEnabled) {
                    _generateReport();
                  }
                }
              },
              label: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        thiswidget: SingleChildScrollView(
          child: Column(
            children: [
              appBardarkblueWidget(
                  title: "Generate Report",
                  thisFunction: () {
                    Navigator.of(context).pop();
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction history request',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Divider(),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            'Your request will be sent to: ${userInfo['email']}')),
                    Text(
                      'Your transaction history will be sent to email address above. Not your email address? Update your profile',
                      style: TextStyle(
                          color: Color.fromARGB(118, 0, 0, 0), fontSize: 12),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Select a date range',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      'Tell use the data to be included in your transaction history. All transactions are in PH time (GMT +8)',
                      style: TextStyle(
                          color: Color.fromARGB(118, 0, 0, 0), fontSize: 12),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Select a date range',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueGrey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            'Select option',
                            style: TextStyle(color: Colors.grey[400]),
                          ), // Placeholder
                          value: selectedDateRange,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDateRange = newValue;
                              selectedDateRangeId = dateRange.firstWhere(
                                  (coop) =>
                                      coop['dateRange'] == newValue)['id'];
                            });
                            _updateRangeDateController(selectedDateRangeId);

                            print("selectedDateRangeId: $selectedDateRangeId");
                          },
                          items: dateRange.map<DropdownMenuItem<String>>(
                              (Map<String, dynamic> coop) {
                            return DropdownMenuItem<String>(
                              value: coop['dateRange'].toString(),
                              child: Text(
                                coop['dateRange'].toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: AbsorbPointer(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: _fromDateController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Select a start date",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: myColors.darkblue,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a date';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'To',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectToDate(context);
                            },
                            child: AbsorbPointer(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: _toDateController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Select a end date",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: myColors.darkblue,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select a date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        haveappbar: false);
  }
}
