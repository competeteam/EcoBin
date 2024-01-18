import 'package:dinacom_2024/components/profile/title_form_field.dart';
import 'package:dinacom_2024/models/complaint_model.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:dinacom_2024/services/complaint_service.dart';
import 'package:dinacom_2024/services/select_image_service.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:flutter/material.dart';
import 'package:dinacom_2024/components/common/checbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddComplaintPage extends StatefulWidget {
  String? lat;
  String? lng;
  String? adrs;
  AddComplaintPage({super.key, this.lat, this.lng, this.adrs});

  @override
  State<AddComplaintPage> createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {
  final _formKey = GlobalKey<FormState>();

  final ComplaintService _complaintService = ComplaintService();
  final SelectImageService _selectImageService = SelectImageService();

  ComplaintType? _type;
  String _displayPictureImagePath = 'null';
  ImageProvider image = const AssetImage('assets/images/default_trash_bin.png');
  String fillCount = '999';
  String content = '';

  bool isOrganicChecked = false;
  bool isPaperChecked = false;
  bool isChemicalChecked = false;
  bool isPlasticChecked = false;
  bool isGlassChecked = false;
  bool isMetalChecked = false;
  bool isEWasteChecked = false;
  bool isError = false;
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 30.0),
              child: TextButton(
                onPressed: () async {
                  await _complaintService.addComplaint(
                      deletedAt: DateTime.now(),
                      createdAt: DateTime.now(),
                      uid: 'apaja',
                      cid: 'apaja',
                      content: content,
                      location: widget.adrs!,
                      type: _type!,
                      createdBy: 'nanti');
                  context.goNamed('Garbage');
                },
                child: const Text('Done',
                    style: TextStyle(color: Color(0xFF75BC7B), fontSize: 16.0)),
              ),
            ),
          ],
          backgroundColor: const Color(0xFF222222),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Add Complaint',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFF222222),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Location',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              Text(widget.adrs!,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0)),
              const SizedBox(height: 15.0),
              TitleFormField(
                  formTitle: 'Complaint content',
                  formValue: content,
                  validatorFunction: (val) =>
                      val!.trim().isEmpty ? 'Location cannot be empty' : null,
                  onChangedFunction: (val) =>
                      setState(() => content = val.trim())),
              const SizedBox(height: 15.0),
              const Text('Complaint Type',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      "Damaged",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.damaged,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Full",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.full,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Improperly sorted",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.improperlySorted,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "No label",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.noLabel,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Not found",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.notFound,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Unusual odors",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.unusualOdor,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Others",
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Radio<ComplaintType>(
                      value: ComplaintType.others,
                      groupValue: _type,
                      onChanged: (ComplaintType? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              isError
                  ? const SizedBox(height: 5.0)
                  : const SizedBox(height: 0.0),
              Text(isError ? 'One trash bin type must be selected' : '',
                  style: TextStyle(color: Colors.red.shade900, fontSize: 12.0)),
              isFull
                  ? Container(
                      height: 40.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF75BC7B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: InkWell(
                          onTap: () {
                            setState(() => isFull = false);
                          },
                          child: const Center(
                              child: Text('Empty Trash Bin',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0)))),
                    )
                  : const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
