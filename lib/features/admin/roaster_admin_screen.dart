import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/app_localizations.dart';

class RoasterAdminScreen extends ConsumerWidget {
  const RoasterAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.t('roaster_panel')),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.amber),
            label: Text(ref.t('export_data'), style: const TextStyle(color: Colors.amber)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              children: [
                const SizedBox(height: 32),
                ListTile(
                  leading: Icon(Icons.dashboard, color: Theme.of(context).colorScheme.primary),
                  title: Text(ref.t('dashboard')),
                  selected: true,
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.inventory, color: Colors.white70),
                  title: Text(ref.t('lots_mgmt')),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.analytics, color: Colors.white70),
                  title: Text(ref.t('quality_analytics')),
                  onTap: () {},
                ),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white70),
                  title: Text(ref.t('settings')),
                  onTap: () {},
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ref.t('overview'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _StatCard(title: ref.t('total_lots'), value: '42', color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 16),
                      _StatCard(title: ref.t('active_fermentation'), value: '8', color: Colors.amber),
                      const SizedBox(width: 16),
                      _StatCard(title: ref.t('avg_q_grade'), value: '86.4', color: Colors.green),
                      const SizedBox(width: 16),
                      _StatCard(title: ref.t('tflite_accuracy'), value: '94%', color: Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Text(ref.t('recent_trends'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  const SizedBox(
                    height: 300,
                    child: _TrendChart(),
                  ),
                  const SizedBox(height: 48),
                  Text(ref.t('recent_lots'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const _LotsTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withValues(alpha: 0.2),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  const _TrendChart();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true, border: Border.all(color: Colors.white10)),
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2.5), FlSpot(3, 4.5), FlSpot(4, 3.8)],
            color: Colors.amber,
            isCurved: true,
          ),
        ],
      ),
    );
  }
}

class _LotsTable extends ConsumerWidget {
  const _LotsTable();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: DataTable(
        columns: [
          DataColumn(label: Text(ref.t('lot_id'))),
          DataColumn(label: Text(ref.t('region'))),
          DataColumn(label: Text(ref.t('method'))),
          DataColumn(label: Text(ref.t('q_grade'))),
          DataColumn(label: Text(ref.t('status'))),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(Text('#1204')),
            const DataCell(Text('Ethiopia')),
            const DataCell(Text('Natural')),
            const DataCell(Text('87.5')),
            DataCell(Chip(label: Text(ref.t('ready')))),
          ]),
          DataRow(cells: [
            const DataCell(Text('#1205')),
            const DataCell(Text('Colombia')),
            const DataCell(Text('Anaerobic')),
            const DataCell(Text('85.2')),
            DataCell(Chip(label: Text(ref.t('fermenting')))),
          ]),
          DataRow(cells: [
            const DataCell(Text('#1206')),
            const DataCell(Text('Brazil')),
            const DataCell(Text('Pulped')),
            const DataCell(Text('84.0')),
            DataCell(Chip(label: Text(ref.t('drying')))),
          ]),
        ],
      ),
    );
  }
}
