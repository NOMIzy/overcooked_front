import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const RebotWebApp());
}

class RebotWebApp extends StatelessWidget {
  const RebotWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'reBot // 具身智能展示系统',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const PresentationPage(),
    );
  }
}

class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = PresentationConfig.sample();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 90),
                _buildHeroSection(config),
                _buildDashboardSection(config),
                _buildMetricsSection(config),
                _buildTimelineSection(config),
              ],
            ),
          ),
          _TopNav(
            system: config.system,
            dashboard: config.dashboard,
            onOpenTeleop: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const TeleopMonitorPage(),
                ),
              );
            },
            onOpenIntro: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ProjectIntroPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(PresentationConfig config) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${config.context.title}\nCooking.',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w800,
                  height: 0.9,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Text(
                  config.context.desc,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.65),
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 980;
                  final items = config.context.cards
                      .map(
                        (card) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                            color: const Color(0xFF111111),
                          ),
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.label,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  letterSpacing: 1.5,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                card.value,
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFF5722),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                card.detail,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.72),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList();

                  if (isNarrow) {
                    return Column(
                      children: items
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: item,
                            ),
                          )
                          .toList(),
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .map(
                          (item) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: item,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardSection(PresentationConfig config) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 1040;
              if (isNarrow) {
                return Column(
                  children: [
                    _liveFeedCard(config.dashboard),
                    const SizedBox(height: 10),
                    _logCard(config.dashboard),
                    const SizedBox(height: 10),
                    _systemCard(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 8, child: _liveFeedCard(config.dashboard)),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 520,
                      child: Column(
                      children: [
                        _logCard(config.dashboard),
                        const SizedBox(height: 10),
                        _systemCard(),
                      ],
                    ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _liveFeedCard(DashboardData dashboard) {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x3300FF41)),
        color: const Color(0xFF050505),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(
                <double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0, 0, 0, 1, 0,
                ],
              ),
              child: _safeNetworkImage(
                dashboard.videoUrl,
                fit: BoxFit.cover,
                opacity: 0.45,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: GridOverlayPainter(),
            ),
          ),
          Positioned(
            top: 18,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: const Color(0x5500FF41)),
              ),
              child: const Text(
                'LIVE_FEED',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Color(0xFF00FF41),
                ),
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: 260,
            child: Container(
              width: 140,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00FF41)),
                color: const Color(0x2200FF41),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Transform.translate(
                  offset: const Offset(0, -18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    color: const Color(0xFF00FF41),
                    child: const Text(
                      'TRACKING_TARGET',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.black,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logCard(DashboardData dashboard) {
    return _terminalPanel(
      title: 'EXECUTION_LOG',
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashboard.logs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              '> ${dashboard.logs[index]}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xCC00FF41),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _systemCard() {
    return _terminalPanel(
      title: 'SYSTEM_METRICS',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MetricLine(label: 'CPU_TEMP', value: '42°C'),
          SizedBox(height: 12),
          _MetricLine(label: 'MEMORY', value: '12.4GB / 16GB'),
          SizedBox(height: 12),
          _MetricLine(label: 'VOLTAGE', value: '24.2V'),
        ],
      ),
    );
  }

  Widget _terminalPanel({required String title, required Widget child}) {
    return Container(
      height: 255,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x3300FF41)),
        color: const Color(0xFF050505),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x3300FF41)),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: Color(0x8800FF41),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildMetricsSection(PresentationConfig config) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth < 980
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 24) / 4;

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: config.metrics
                    .map(
                      (metric) => SizedBox(
                        width: cardWidth,
                        child: Container(
                          color: const Color(0xFF111111),
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                metric.title,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    metric.value,
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 52,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      metric.unit,
                                      style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 13,
                                        color: Colors.white.withOpacity(0.55),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                metric.desc,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.45),
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineSection(PresentationConfig config) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 28),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
                ),
                child: const Text(
                  'Data Evolution',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.white.withOpacity(0.12))),
                ),
                padding: const EdgeInsets.only(left: 22),
                child: Column(
                  children: config.iteration
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 42),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: const Offset(-27, 0),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(top: 4, right: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFFF5722), width: 2),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.time} | ${item.status}',
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 10,
                                        color: Color(0xFFFF5722),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.desc,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.55),
                                        height: 1.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav({
    required this.system,
    required this.dashboard,
    required this.onOpenTeleop,
    required this.onOpenIntro,
  });

  final SystemData system;
  final DashboardData dashboard;
  final VoidCallback onOpenTeleop;
  final VoidCallback onOpenIntro;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
        color: Colors.black.withOpacity(0.84),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                system.name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: onOpenIntro,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0x66FFFFFF)),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        letterSpacing: 1.0,
                      ),
                    ),
                    child: const Text('项目介绍'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: onOpenTeleop,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0x6600FF41)),
                      foregroundColor: const Color(0xFF00FF41),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      textStyle: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        letterSpacing: 1.0,
                      ),
                    ),
                    child: const Text('遥操作监控'),
                  ),
                  const SizedBox(width: 24),
                  _navItem('COMPUTE', system.compute),
                  const SizedBox(width: 34),
                  _navItem('LATENCY', dashboard.vlaLatency),
                  const SizedBox(width: 34),
                  _navItem('ERROR', dashboard.errorBound),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        letterSpacing: 1.0,
        color: Colors.white,
      ),
    );
  }
}

class TeleopMonitorPage extends StatelessWidget {
  const TeleopMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teleop = TeleopConfig.sample();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),
                _teleopHero(teleop),
                _teleopMain(teleop),
                _teleopBottom(teleop),
              ],
            ),
          ),
          _TeleopTopNav(
            title: teleop.systemName,
            onBack: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _teleopHero(TeleopConfig teleop) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Remote Operation\nManipulator Monitor',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w800,
                  height: 0.95,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                teleop.subtitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.65),
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: teleop.quickStats
                    .map(
                      (s) => Container(
                        width: 250,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.label,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.55),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              s.value,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFF5722),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teleopMain(TeleopConfig teleop) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 1100;
              if (narrow) {
                return Column(
                  children: [
                    _cameraCard(teleop),
                    const SizedBox(height: 10),
                    _jointCard(teleop),
                    const SizedBox(height: 10),
                    _poseCard(teleop),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: _cameraCard(teleop)),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _jointCard(teleop),
                        const SizedBox(height: 10),
                        _poseCard(teleop),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _cameraCard(TeleopConfig teleop) {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        color: const Color(0xFF050505),
        border: Border.all(color: const Color(0x3300FF41)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: _safeNetworkImage(
              teleop.cameraImageUrl,
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: GridOverlayPainter())),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x6600FF41)),
                color: Colors.black.withOpacity(0.75),
              ),
              child: Text(
                teleop.cameraLabel,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF00FF41),
                ),
              ),
            ),
          ),
          Positioned(
            right: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(color: Color(0xCC111111)),
              child: Text(
                'RTT ${teleop.networkRtt}',
                style: const TextStyle(
                  color: Color(0xFF00FF41),
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _jointCard(TeleopConfig teleop) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x3300FF41)),
        color: const Color(0xFF050505),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'JOINT STATE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0x8800FF41),
            ),
          ),
          const SizedBox(height: 12),
          ...teleop.joints.map(
            (joint) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      joint.name,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: joint.load,
                        minHeight: 8,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          joint.warning ? const Color(0xFFFF5722) : const Color(0xFF00FF41),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 58,
                    child: Text(
                      joint.value,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: joint.warning ? const Color(0xFFFF5722) : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _poseCard(TeleopConfig teleop) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x3300FF41)),
        color: const Color(0xFF050505),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'END-EFFECTOR POSE',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0x8800FF41),
            ),
          ),
          const SizedBox(height: 12),
          ...teleop.poseEntries.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.label,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    e.value,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF00FF41),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teleopBottom(TeleopConfig teleop) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 90),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _panelList(
                  title: 'TASK QUEUE',
                  lines: teleop.taskQueue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _panelList(
                  title: 'ALERT LOG',
                  lines: teleop.alertLogs,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panelList({required String title, required List<String> lines}) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0x88FFFFFF),
            ),
          ),
          const SizedBox(height: 12),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '> $line',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xCC00FF41),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeleopTopNav extends StatelessWidget {
  const _TeleopTopNav({
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
        color: Colors.black.withOpacity(0.84),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0x66FFFFFF)),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('返回展示页'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricLine extends StatelessWidget {
  const _MetricLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xCCFFFFFF),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    );
  }
}

class GridOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x2200FF41)
      ..strokeWidth = 1;

    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PresentationConfig {
  PresentationConfig({
    required this.system,
    required this.context,
    required this.dashboard,
    required this.metrics,
    required this.iteration,
  });

  final SystemData system;
  final ContextData context;
  final DashboardData dashboard;
  final List<MetricData> metrics;
  final List<IterationData> iteration;

  factory PresentationConfig.sample() {
    return PresentationConfig(
      system: SystemData(
        name: 'reBot // B601-DM',
        mode: 'AUTONOMOUS_MODE',
        compute: 'Orin NX 157 TOPS',
        uptime: '47:12:08',
      ),
      context: ContextData(
        title: 'Reconstructing Cooking.',
        desc: '基于 reBot B601-DM 的物理约束，我们将烹饪解构为连续动力学与三维目标检测。',
        cards: [
          ContextCard(
            label: 'PHYSICAL LIMIT',
            value: '1.5 kg',
            detail: '额定负载极限。放弃传统颠勺，依靠 6 DOF 腕部微操突破负载边界。',
          ),
          ContextCard(
            label: 'TASK 01: DISH',
            value: '可乐鸡翅',
            detail: '关注点在于鸡翅翻面受力控制与糖色阶段火候识别，结合视觉状态机实现煎制-炖煮的时序切换。',
          ),
          ContextCard(
            label: 'TASK 02: DISH',
            value: '蛋炒饭',
            detail: '重点解决米饭颗粒分离、蛋液包裹一致性与锅内轨迹连续性，通过动作策略优化翻炒质量。',
          ),
        ],
      ),
      dashboard: DashboardData(
        cameraLabel: 'CAM_01: ORBBEC_GEMINI_2_ACTIVE_IR',
        videoUrl: 'app/public/images/cola-wings-v2-03.jpg',
        vlaLatency: '42ms',
        errorBound: '0.12mm',
        logs: const [
          '[SYS] Starting autonomous execution sequence...',
          '[VISION] Processing point cloud from Gemini 2 sensor...',
          '[AI] Target isolated. Confidence score: 0.98',
          '[WARN] Joint 2 approaching torque threshold.',
          '[CTRL] Executing maillard reaction detection proxy...',
          '[SYS] Action complete. Move to next state.',
        ],
      ),
      metrics: const [
        MetricData(
          title: '推理延迟',
          value: '42',
          unit: 'ms',
          desc: '边缘算力保障实时避障与姿态纠正。',
        ),
        MetricData(
          title: '轨迹误差',
          value: '<0.5',
          unit: 'mm',
          desc: '高精度运动控制还原人类烹饪轨迹精度。',
        ),
        MetricData(
          title: '抓取成功率',
          value: '96.4',
          unit: '%',
          desc: '克服复杂表面与光照环境下的感知挑战。',
        ),
        MetricData(
          title: '综合评分',
          value: '5.0',
          unit: 'pts',
          desc: '色泽/质地/完成度综合闭环评价。',
        ),
      ],
      iteration: const [
        IterationData(
          time: 'T-Minus 36:00',
          status: 'FAILURE',
          title: '物理引擎偏差',
          desc: '初始扭矩无法击破隔夜饭静摩擦力，导致米粒焦化。',
        ),
        IterationData(
          time: 'T-Minus 14:00',
          status: 'CORNER CASE',
          title: '视觉遮挡挑战',
          desc: '俯视视角盲区导致翻面失败。引入混合状态机补偿决策。',
        ),
        IterationData(
          time: 'T-Minus 02:00',
          status: 'SUCCESS',
          title: '全流程贯通',
          desc: '端到端执行稳定，显存与负载处于安全区间。',
        ),
      ],
    );
  }
}

class SystemData {
  SystemData({
    required this.name,
    required this.mode,
    required this.compute,
    required this.uptime,
  });

  final String name;
  final String mode;
  final String compute;
  final String uptime;
}

class ContextData {
  ContextData({
    required this.title,
    required this.desc,
    required this.cards,
  });

  final String title;
  final String desc;
  final List<ContextCard> cards;
}

class ContextCard {
  ContextCard({
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final String value;
  final String detail;
}

class DashboardData {
  DashboardData({
    required this.cameraLabel,
    required this.videoUrl,
    required this.vlaLatency,
    required this.errorBound,
    required this.logs,
  });

  final String cameraLabel;
  final String videoUrl;
  final String vlaLatency;
  final String errorBound;
  final List<String> logs;
}

class MetricData {
  const MetricData({
    required this.title,
    required this.value,
    required this.unit,
    required this.desc,
  });

  final String title;
  final String value;
  final String unit;
  final String desc;
}

class IterationData {
  const IterationData({
    required this.time,
    required this.status,
    required this.title,
    required this.desc,
  });

  final String time;
  final String status;
  final String title;
  final String desc;
}

class TeleopConfig {
  TeleopConfig({
    required this.systemName,
    required this.subtitle,
    required this.cameraLabel,
    required this.cameraImageUrl,
    required this.networkRtt,
    required this.quickStats,
    required this.joints,
    required this.poseEntries,
    required this.taskQueue,
    required this.alertLogs,
  });

  final String systemName;
  final String subtitle;
  final String cameraLabel;
  final String cameraImageUrl;
  final String networkRtt;
  final List<QuickStat> quickStats;
  final List<TeleopJointState> joints;
  final List<PoseEntry> poseEntries;
  final List<String> taskQueue;
  final List<String> alertLogs;

  factory TeleopConfig.sample() {
    return TeleopConfig(
      systemName: 'reBot // Teleoperation Console',
      subtitle: '远程操作链路已接入，实时展示机械臂关节负载、末端位姿、任务队列与系统告警。',
      cameraLabel: 'CAM_02: WRIST_RGBD_STREAM',
      cameraImageUrl: 'app/public/images/egg-rice-v2-03.jpg',
      networkRtt: '18ms',
      quickStats: const [
        QuickStat(label: '遥操作模式', value: 'ASSISTED'),
        QuickStat(label: '控制刷新率', value: '120 Hz'),
        QuickStat(label: '链路质量', value: '98.7%'),
        QuickStat(label: '安全状态', value: 'NORMAL'),
      ],
      joints: const [
        TeleopJointState(name: 'J1', load: 0.32, value: '11.2Nm'),
        TeleopJointState(name: 'J2', load: 0.74, value: '24.7Nm', warning: true),
        TeleopJointState(name: 'J3', load: 0.48, value: '15.6Nm'),
        TeleopJointState(name: 'J4', load: 0.22, value: '8.1Nm'),
        TeleopJointState(name: 'J5', load: 0.38, value: '12.5Nm'),
        TeleopJointState(name: 'J6', load: 0.68, value: 'CLOSED'),
      ],
      poseEntries: const [
        PoseEntry(label: 'X', value: '+0.412 m'),
        PoseEntry(label: 'Y', value: '-0.187 m'),
        PoseEntry(label: 'Z', value: '+0.265 m'),
        PoseEntry(label: 'Roll', value: '+13.2°'),
        PoseEntry(label: 'Pitch', value: '-6.4°'),
        PoseEntry(label: 'Yaw', value: '+88.1°'),
      ],
      taskQueue: const [
        '[Q1] Approach pan center',
        '[Q2] Align spatula with edge',
        '[Q3] Lift and rotate 28 deg',
        '[Q4] Place to target tray',
      ],
      alertLogs: const [
        '[INFO] Operator handoff complete',
        '[INFO] Haptic feedback enabled',
        '[WARN] Joint2 load near threshold',
        '[INFO] Trajectory smoothing active',
      ],
    );
  }
}

class QuickStat {
  const QuickStat({required this.label, required this.value});

  final String label;
  final String value;
}

class TeleopJointState {
  const TeleopJointState({
    required this.name,
    required this.load,
    required this.value,
    this.warning = false,
  });

  final String name;
  final double load;
  final String value;
  final bool warning;
}

class PoseEntry {
  const PoseEntry({required this.label, required this.value});

  final String label;
  final String value;
}

class ProjectIntroPage extends StatelessWidget {
  const ProjectIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final intro = ProjectIntroData.sample();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 90),
                _introHero(intro),
                _introAbout(intro),
                _introHighlight(intro),
                _introArchitecture(intro),
                _introGallery(intro),
                _introPerformance(intro),
                _introOpenSource(intro),
                _introFooter(intro),
              ],
            ),
          ),
          _IntroTopNav(onBack: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Widget _introHero(ProjectIntroData intro) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            children: [
              Text(
                intro.heroTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w700, height: 1.15),
              ),
              const SizedBox(height: 16),
              Text(
                intro.heroDesc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8), height: 1.6),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: intro.heroTags
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          border: Border.all(color: const Color(0x664CAF50)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introAbout(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFFF1F8F1),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: LayoutBuilder(
            builder: (context, c) {
              final narrow = c.maxWidth < 980;
              final left = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 4, height: 52, color: const Color(0xFF4CAF50)),
                  const SizedBox(height: 12),
                  const Text(
                    '我们的项目',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    intro.aboutParagraph1,
                    style: const TextStyle(fontSize: 16, height: 1.8, color: Color(0xFF2D2D2D)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    intro.aboutParagraph2,
                    style: const TextStyle(fontSize: 16, height: 1.8, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 24,
                    runSpacing: 12,
                    children: intro.aboutStats
                        .map(
                          (s) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.value,
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: s.highlight ? const Color(0xFF4CAF50) : const Color(0xFFFF9800),
                                ),
                              ),
                              Text(s.label, style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
              final right = Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _safeNetworkImage(
                      intro.aboutImage,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayerWidget(assetPath: intro.aboutVideo),
                    ),
                  ),
                ],
              );
              if (narrow) {
                return Column(children: [left, const SizedBox(height: 18), right]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: left),
                  const SizedBox(width: 48),
                  Expanded(flex: 7, child: right),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _introArchitecture(ProjectIntroData intro) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              const Text(
                '全栈开源架构',
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w700, color: Color(0xFF2D2D2D)),
              ),
              const SizedBox(height: 42),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: intro.archLayers
                    .map(
                      (l) => SizedBox(
                        width: 380,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black,
                            image: DecorationImage(
                              image: _imageProvider(l.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.darken),
                            ),
                          ),
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: l.color,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  l.subtitle.toUpperCase(),
                                  style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(l.title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Text(l.desc, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 6),
                              Text(l.detail, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introHighlight(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFF0D1410),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: LayoutBuilder(
            builder: (context, c) {
              final narrow = c.maxWidth < 980;
              final textBlock = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '项目亮点',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    intro.highlightDesc,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.75,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x224CAF50),
                      border: Border.all(color: const Color(0x664CAF50)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '核心方法：高成功率子任务优先 + 动态重排',
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
              final videoBlock = ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayerWidget(assetPath: intro.highlightVideo),
                ),
              );

              if (narrow) {
                return Column(
                  children: [
                    textBlock,
                    const SizedBox(height: 18),
                    videoBlock,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: textBlock),
                  const SizedBox(width: 28),
                  Expanded(flex: 7, child: videoBlock),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _introGallery(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: Column(
            children: [
              const Text('机械臂主厨的拿手菜', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: intro.dishes
                    .map(
                      (d) => SizedBox(
                        width: 248,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white12),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF111111),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _safeNetworkImage(
                                d.image,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  '${d.title} · ${d.desc}',
                                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introPerformance(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFF1A2E1A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              const Text('AI 主厨性能参数', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(
                'reBot Arm B601-DM 开源机械臂核心指标',
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.65)),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: intro.specs
                    .map(
                      (s) => SizedBox(
                        width: 290,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.05),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Column(
                            children: [
                              Text(s.icon, style: const TextStyle(fontSize: 22, color: Color(0xFF4CAF50))),
                              const SizedBox(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: s.value,
                                  style: const TextStyle(
                                    fontSize: 46,
                                    color: Color(0xFFFF9800),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: s.unit,
                                      style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.65)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(s.label, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text(
                                s.desc,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.55), height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introOpenSource(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              const Text('我们的开源技术栈', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(
                '基于开源生态构建，所有代码与模型将向社区开放',
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.55)),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: intro.techStack
                    .map(
                      (t) => SizedBox(
                        width: 400,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            border: Border.all(color: Colors.white.withOpacity(0.08)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t.name,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color(0xFF4CAF50),
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0x22FF9800),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      t.role,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFFFF9800),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(t.desc, style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.65))),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 26),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                ),
                child: const Text('查看项目代码（GitHub）'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introFooter(ProjectIntroData intro) {
    return Container(
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '好菜，"臂" 需有讲究',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                intro.footerDesc,
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.5)),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: intro.partners
                    .map(
                      (p) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(p, style: const TextStyle(color: Color(0xFFE5E5E5))),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 26),
              Text(
                '© 2026 胡闹厨房黑客松参赛项目. All rights reserved.',
                style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroTopNav extends StatelessWidget {
  const _IntroTopNav({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
        color: Colors.black.withOpacity(0.84),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'COOK WITH ROBOT // PROJECT INTRO',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0x664CAF50)),
                    foregroundColor: const Color(0xFF4CAF50),
                  ),
                  child: const Text('返回主入口'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectIntroData {
  ProjectIntroData({
    required this.heroTitle,
    required this.heroDesc,
    required this.heroTags,
    required this.aboutParagraph1,
    required this.aboutParagraph2,
    required this.aboutImage,
    required this.aboutVideo,
    required this.aboutStats,
    required this.highlightDesc,
    required this.highlightVideo,
    required this.archLayers,
    required this.dishes,
    required this.specs,
    required this.techStack,
    required this.footerDesc,
    required this.partners,
  });

  final String heroTitle;
  final String heroDesc;
  final List<String> heroTags;
  final String aboutParagraph1;
  final String aboutParagraph2;
  final String aboutImage;
  final String aboutVideo;
  final List<IntroStat> aboutStats;
  final String highlightDesc;
  final String highlightVideo;
  final List<ArchLayer> archLayers;
  final List<DishItem> dishes;
  final List<PerfSpec> specs;
  final List<TechItem> techStack;
  final String footerDesc;
  final List<String> partners;

  factory ProjectIntroData.sample() {
    return ProjectIntroData(
      heroTitle: '当具身智能，遇见人间烟火',
      heroDesc: '基于 reBot 机械臂、Gemini2 深度相机与 NVIDIA Jetson 的 AI 主厨系统',
      heroTags: const ['LeRobot', 'ROS2', 'PyTorch', 'Gemini2', 'Jetson'],
      aboutParagraph1:
          '我们是「胡闹厨房：Cook with Robot」黑客松参赛选手。在48小时挑战中，基于 reBot Arm B601-DM 开源机械臂、reComputer Robotics Jetson 边缘计算机和 Gemini2 深度相机，从零构建了 AI 主厨系统。',
      aboutParagraph2:
          '目标是实现可乐鸡翅与蛋炒饭两道菜的全自动烹饪，从食材识别、轨迹规划到精准控制，完成从原材料到成品的全流程自动化。',
      aboutImage: 'app/public/images/cola-wings-v2-01.jpg',
      aboutVideo: 'app/public/videos/robot-arm-motion.mp4',
      aboutStats: const [
        IntroStat(value: '2', label: '道菜品', highlight: true),
        IntroStat(value: '6DoF', label: '机械臂', highlight: false),
        IntroStat(value: '全开源', label: '技术栈', highlight: true),
      ],
      highlightDesc:
          '我们将长程烹饪任务拆解为可评估的子任务集合，优先编排高概率完成的动作时序。当前版本不做状态反馈自动重排，但支持人工编辑与调整任务顺序，从而保证整道菜流程可控完成。',
      highlightVideo: 'app/public/videos/gantt.mp4',
      archLayers: const [
        ArchLayer(
          title: '感知层',
          subtitle: 'Perception',
          desc: 'Gemini2 深度相机',
          detail: '3D视觉识别 · 物体检测 · 空间定位',
          image: 'app/public/images/cola-wings-v2-02.jpg',
          color: Color(0xFF4CAF50),
        ),
        ArchLayer(
          title: '决策层',
          subtitle: 'Decision',
          desc: 'NVIDIA Jetson 边缘推理',
          detail: 'ACT策略 · 轨迹规划 · 动作预测',
          image: 'app/public/images/egg-rice-v2-02.jpg',
          color: Color(0xFFFF9800),
        ),
        ArchLayer(
          title: '执行层',
          subtitle: 'Execution',
          desc: 'reBot 6DoF 机械臂',
          detail: '精准控制 · 力反馈 · 夹爪操作',
          image: 'app/public/images/cola-wings-v2-05.jpg',
          color: Color(0xFF4CAF50),
        ),
      ],
      dishes: const [
        DishItem(title: '可乐鸡翅', desc: '食材准备', image: 'app/public/images/cola-wings-v2-01.jpg'),
        DishItem(title: '可乐鸡翅', desc: '焯水去腥', image: 'app/public/images/cola-wings-v2-02.jpg'),
        DishItem(title: '可乐鸡翅', desc: '煎制上色', image: 'app/public/images/cola-wings-v2-03.jpg'),
        DishItem(title: '可乐鸡翅', desc: '可乐炖煮', image: 'app/public/images/cola-wings-v2-04.jpg'),
        DishItem(title: '可乐鸡翅', desc: '出锅装盘', image: 'app/public/images/cola-wings-v2-05.jpg'),
        DishItem(title: '蛋炒饭', desc: '备料打蛋', image: 'app/public/images/egg-rice-v2-01.jpg'),
        DishItem(title: '蛋炒饭', desc: '热油炒饭', image: 'app/public/images/egg-rice-v2-02.jpg'),
        DishItem(title: '蛋炒饭', desc: '蛋液包裹', image: 'app/public/images/egg-rice-v2-03.jpg'),
        DishItem(title: '蛋炒饭', desc: '调味撒葱', image: 'app/public/images/egg-rice-v2-04.jpg'),
        DishItem(title: '蛋炒饭', desc: '成品展示', image: 'app/public/images/egg-rice-v2-05.jpg'),
      ],
      specs: const [
        PerfSpec(value: '±0.05', unit: 'mm', label: '末端精度', desc: '重复定位精度，亚毫米级精准操控', icon: '◉'),
        PerfSpec(value: '1.5', unit: 'kg', label: '最大负载', desc: '轻松端起锅具与食材', icon: '◈'),
        PerfSpec(value: '767', unit: 'mm', label: '工作半径', desc: '覆盖完整厨房操作台面', icon: '◎'),
        PerfSpec(value: '30', unit: 'FPS', label: '视觉帧率', desc: 'Gemini2 深度相机实时感知', icon: '◉'),
      ],
      techStack: const [
        TechItem(name: 'LeRobot', desc: 'HuggingFace 机器人学习框架', role: '策略学习'),
        TechItem(name: 'ROS2', desc: '机器人操作系统', role: '通信中间件'),
        TechItem(name: 'PyTorch', desc: '深度学习框架', role: '模型训练'),
        TechItem(name: 'CUDA', desc: 'GPU 并行计算', role: '推理加速'),
        TechItem(name: 'Gemini2', desc: '奥比中光深度相机', role: '视觉感知'),
        TechItem(name: 'Jetson', desc: 'NVIDIA 边缘计算', role: '端侧推理'),
      ],
      footerDesc: '胡闹厨房黑客松参赛项目 · 基于 reBot + Gemini2 + Jetson 的 AI 主厨系统',
      partners: const ['Seeed Studio', 'Orbbec', 'NVIDIA'],
    );
  }
}

class IntroStat {
  const IntroStat({required this.value, required this.label, required this.highlight});
  final String value;
  final String label;
  final bool highlight;
}

class ArchLayer {
  const ArchLayer({
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.detail,
    required this.image,
    required this.color,
  });
  final String title;
  final String subtitle;
  final String desc;
  final String detail;
  final String image;
  final Color color;
}

class DishItem {
  const DishItem({required this.title, required this.desc, required this.image});
  final String title;
  final String desc;
  final String image;
}

class PerfSpec {
  const PerfSpec({
    required this.value,
    required this.unit,
    required this.label,
    required this.desc,
    required this.icon,
  });
  final String value;
  final String unit;
  final String label;
  final String desc;
  final String icon;
}

class TechItem {
  const TechItem({required this.name, required this.desc, required this.role});
  final String name;
  final String desc;
  final String role;
}

Widget _safeNetworkImage(
  String url, {
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
  double? opacity,
}) {
  final isAsset = !url.startsWith('http://') && !url.startsWith('https://');
  if (isAsset) {
    return Image.asset(
      url,
      fit: fit,
      width: width,
      height: height,
      opacity: opacity == null ? null : AlwaysStoppedAnimation(opacity),
      filterQuality: FilterQuality.low,
      errorBuilder: (context, error, stackTrace) => _imageFallback(width, height),
    );
  }
  return Image.network(
    url,
    fit: fit,
    width: width,
    height: height,
    opacity: opacity == null ? null : AlwaysStoppedAnimation(opacity),
    filterQuality: FilterQuality.low,
    errorBuilder: (context, error, stackTrace) => _imageFallback(width, height),
  );
}

ImageProvider _imageProvider(String src) {
  final isAsset = !src.startsWith('http://') && !src.startsWith('https://');
  if (isAsset) {
    return AssetImage(src);
  }
  return NetworkImage(src);
}

Widget _imageFallback(double? width, double? height) {
  return Container(
    width: width,
    height: height,
    color: const Color(0xFF1A1A1A),
    alignment: Alignment.center,
    child: const Text(
      'IMAGE OFFLINE',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFF00FF41),
      ),
    ),
  );
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.assetPath});

  final String assetPath;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        _controller.play();
      }).catchError((error) {
        if (!mounted) return;
        setState(() {
          _videoError = error.toString();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoError != null) {
      return Container(
        color: const Color(0xFF1A1A1A),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          'VIDEO LOAD FAILED\n$_videoError',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFFFF5722),
          ),
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return Container(
        color: const Color(0xFF1A1A1A),
        alignment: Alignment.center,
        child: const Text(
          'VIDEO LOADING...',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF00FF41),
          ),
        ),
      );
    }
    return VideoPlayer(_controller);
  }
}
