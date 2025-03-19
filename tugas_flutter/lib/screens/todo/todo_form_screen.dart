import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/todo.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/priority_badge.dart';

class TodoFormScreen extends StatefulWidget {
  final Todo? todo;

  const TodoFormScreen({Key? key, this.todo}) : super(key: key);

  @override
  _TodoFormScreenState createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _deadline = DateTime.now();
  Priority _priority = Priority.rendah;
  int? _categoryId;
  int? _labelId;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
      _deadline = widget.todo!.deadline;
      _priority = widget.todo!.status;
      _categoryId = widget.todo!.categoryId;
      _labelId = widget.todo!.labelId;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _deadline,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null && picked != _deadline) {
                          setState(() {
                            _deadline = picked;
                          });
                        }
                      },
                      child: Text(
                        'Deadline: ${_deadline.toLocal()}'.split(' ')[0],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<Priority>(
                    value: _priority,
                    onChanged: (Priority? newValue) {
                      setState(() {
                        _priority = newValue!;
                      });
                    },
                    items: Priority.values.map<DropdownMenuItem<Priority>>((
                      Priority value,
                    ) {
                      return DropdownMenuItem<Priority>(
                        value: value,
                        child: PriorityBadge(priority: value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final todoProvider = Provider.of<TodoProvider>(
                      context,
                      listen: false,
                    );
                    final todo = Todo(
                      id: widget.todo?.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deadline: _deadline,
                      status: _priority,
                      categoryId: _categoryId!,
                      labelId: _labelId!,
                    );
                    if (widget.todo == null) {
                      await todoProvider.createTodo(todo);
                    } else {
                      await todoProvider.updateTodo(widget.todo!.id!, todo);
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.todo == null ? 'Add Todo' : 'Update Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
