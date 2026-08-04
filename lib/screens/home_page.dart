import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_uxplanner/widget/keyhole_hub.dart';
import 'package:portfolio_uxplanner/widget/keyhole_cursor_area.dart';
import 'package:portfolio_uxplanner/widget/page_header.dart';
import 'package:portfolio_uxplanner/widget/section_heading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;

  late final AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final screenHeight = MediaQuery.of(context).size.height;
    setState(() {
      _progress = (_scrollController.offset / screenHeight).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildSectionA(context),
            _buildSectionB(context),
          ],
        ),
      ),
    );
  }

  // ── Section A: 첫 화면 ──────────────────────────────────────────
  Widget _buildSectionA(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: Color.lerp(Colors.black, Colors.white, _progress),
            child: Center(
              child: Opacity(
                opacity: 1 - _progress,
                child: Transform.scale(
                  scale: 1 + (_progress * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _bounceController,
                        builder: (context, child) {
                          final double bounceOffset = _bounceController.value * 10;
                          return Transform.translate(
                            offset: Offset(0, -bounceOffset),
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/union.png',
                          width: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'KIM SUMIN — UX / SERVICE PLANNER',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Mono',
                          fontSize: 13,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '질문을 다시 세우는 것에서, 기획은 시작됩니다',
                        style: TextStyle(
                          fontFamily: 'Gowun Batang',
                          fontSize: 17,
                          color: Color(0xFFCCC9C0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 1 - _progress,
              child: const Center(
                child: Text(
                  'SCROLL',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 11,
                    color: Color(0xFF888888),
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section B: 질문 → 세 개의 리서치 + CTA ──────────────────────
  // 물음표 하나(질문)에서 세 카드(잠긴 질문들)로 뻗는 구조.
  // 화면 폭과 무관하게 항상 중앙 정렬되어 넓은 화면에서도 여백이 어색해지지 않는다.
  Widget _buildSectionB(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    final double screenHeight = MediaQuery.of(context).size.height;

    final Widget topBlock = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/union.png',
              width: 40,
              color: const Color(0xFF1D1D1B),
            ),
            const SizedBox(height: 14),
            const Text(
              '올바른 질문이 문제를 푸는 열쇠가 되었습니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Noto Sans KR',
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF1D1D1B),
              ),
            ),
            SizedBox(height: isMobile ? 28 : 36),
            isMobile ? _mobileNodes(context) : _desktopNodes(context),
          ],
        ),
      ),
    );

    final Widget headingRow = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                title: "사용자의 망설임을 관찰합니다",
                subtitle: "질문을 다시 세우는 것에서, 리서치는 시작됩니다",
              ),
              const SizedBox(height: 20),
              _viewAllCta(context),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: SectionHeading(
                  title: "사용자의 망설임을 관찰합니다",
                  subtitle: "질문을 다시 세우는 것에서, 리서치는 시작됩니다",
                ),
              ),
              _viewAllCta(context),
            ],
          );

    // 모바일 — 고정 높이 없이 자연스럽게 쌓기 (내용 넘침 방지)
    if (isMobile) {
      return Container(
        width: double.infinity,
        color: const Color(0xFFF3F3EF),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(),
            const SizedBox(height: 40),
            topBlock,
            const SizedBox(height: 36),
            headingRow,
            const SizedBox(height: 40),
          ],
        ),
      );
    }

    // 데스크톱 — 화면 높이 고정 + 남는 공간을 물음표 블록에 자동 배분
    return SizedBox(
      width: double.infinity,
      height: screenHeight,
      child: Container(
        color: const Color(0xFFF3F3EF),
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(),
            Expanded(child: topBlock), // 남는 공간을 다 차지하고, 그 안에서 topBlock을 세로 중앙 정렬
            headingRow,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _desktopNodes(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _nodeCard(
            context,
            label: 'Project 01',
            title: '맥락을 놓치지 않는 대화 경험',
            onTap: () => context.go('/projects/chatbot'),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _nodeCard(
            context,
            label: 'Project 02',
            title: '회복으로 이어지는 숙박 경험',
            onTap: () => context.go('/projects/lgsuite'),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _nodeCard(
            context,
            label: 'Project 03',
            title: '성장을 설계하는 조직 경험',
            onTap: () => context.go('/projects/org'),
          ),
        ),
      ],
    );
  }

  Widget _mobileNodes(BuildContext context) {
    return Column(
      children: [
        _nodeCard(
          context,
          label: 'Project 01',
          title: '맥락을 놓치지 않는 대화 경험',
          onTap: () => context.go('/projects/chatbot'),
        ),
        const SizedBox(height: 16),
        _nodeCard(
          context,
          label: 'Project 02',
          title: '회복으로 이어지는 숙박 경험',
          onTap: () => context.go('/projects/lgsuite'),
        ),
        const SizedBox(height: 16),
        _nodeCard(
          context,
          label: 'Project 03',
          title: '성장을 설계하는 조직 경험',
          onTap: () => context.go('/projects/org'),
        ),
      ],
    );
  }

  Widget _nodeCard(
    BuildContext context, {
    required String label,
    required String title,
    required VoidCallback onTap,
  }) {
    return Semantics(
      button: true,
      label: '$title 프로젝트 상세 보기',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        hoverColor: const Color(0x0DA73B2E),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDDDAD1)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 34,
                height: 41,
                child: KeyholeCursorArea(
                  child: const KeyholeIcon(size: 34),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Mono',
                  fontSize: 11,
                  color: Color(0xFFA6A29B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$title →',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Noto Sans KR',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1D1D1B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewAllCta(BuildContext context) {
    return Semantics(
      button: true,
      label: '모든 프로젝트 보기',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () => context.go('/projects'),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1D1D1B)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '모든 프로젝트 보기 →',
              style: TextStyle(
                fontFamily: 'IBM Plex Mono',
                fontSize: 13,
                color: Color(0xFF1D1D1B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
