import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskminder/bloc/bloc_exports.dart';
import 'package:taskminder/helpers/guid_gen.dart';
import 'package:taskminder/helpers/string_extension.dart';
import 'package:taskminder/models/task.dart';

class EditTaskFormWidget extends StatefulWidget {
  EditTaskFormWidget({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  final Task oldTask;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<EditTaskFormWidget> createState() => _EditTaskFormWidgetState();
}

class _EditTaskFormWidgetState extends State<EditTaskFormWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final deadlineFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.oldTask.title;
    descriptionController.text = widget.oldTask.description ?? '';
    deadlineController.text = widget.oldTask.deadLine ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    deadlineFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: EditTaskFormWidget._formKey,
            child: Column(
              children: [
                Text(
                  'Edit Task',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: titleController,
                  focusNode: titleFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Task Title'),
                    suffixIcon: Icon(Icons.title_outlined),
                  ),
                  validator: (val) {
                    if (!val!.isValidTitle) {
                      return 'Please enter valid title';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: descriptionController,
                  focusNode: descriptionFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Task Description'),
                    suffixIcon: Icon(Icons.description_outlined),
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: deadlineController,
                  focusNode: deadlineFocusNode,
                  readOnly: true,
                  onTap: () async {
                    deadlineFocusNode.requestFocus();
                    DateTime? deadlineDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (deadlineDate == null) {
                      deadlineFocusNode.unfocus();
                      return;
                    }

                    TimeOfDay? deadlineTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: 12,
                        minute: 0,
                      ),
                    );

                    if (deadlineTime == null) {
                      deadlineFocusNode.unfocus();
                      return;
                    }

                    final DateTime deadlineDateTime = DateTime(
                      deadlineDate.year,
                      deadlineDate.month,
                      deadlineDate.day,
                      deadlineTime.hour,
                      deadlineTime.minute,
                    );

                    deadlineController.text = DateFormat('dd-MM-yyyy HH:mm').format(deadlineDateTime).toString();
                    deadlineFocusNode.unfocus();
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Task Deadline'),
                    suffixIcon: Icon(Icons.access_time_rounded),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0.0),
                        ),
                        onPressed: () {
                          if (EditTaskFormWidget._formKey.currentState!.validate()) {
                            Task editedTask = Task(
                              id: GUIDGen.generate(),
                              title: titleController.text,
                              description: descriptionController.text,
                              deadLine: deadlineController.text,
                              isCompleted: widget.oldTask.isCompleted,
                              isFavorite: widget.oldTask.isFavorite,
                            );
                            context.read<TasksBloc>().add(EditTaskEvent(oldTask: widget.oldTask, newTask: editedTask));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
