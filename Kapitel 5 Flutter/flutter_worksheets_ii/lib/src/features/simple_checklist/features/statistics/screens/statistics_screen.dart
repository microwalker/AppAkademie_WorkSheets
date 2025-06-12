import 'package:flutter/material.dart';

import '../../../../../data/checklist_repositories/database_repository.dart';
import '../widgets/task_counter_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;

  void loadItemCount() async {
    int taskCount = await widget.repository.getItemCount();

    if (taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadItemCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(taskCount: currentTaskCount),
          ],
        ),
      ),
    );
  }
}
