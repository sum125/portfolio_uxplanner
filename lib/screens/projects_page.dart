import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_uxplanner/widget/page_header.dart';
import 'package:portfolio_uxplanner/widget/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static const List<Map<String, String>> _projects = [
    {
      'id': 'chatbot',
      'title': '맥락을 놓치지 않는 대화 경험',
      'meta': '이탈 원인 재정의 → 하이브리드 인터랙션 설계',
    },
    {
      'id': 'lgsuite',
      'title': '회복으로 이어지는 회복 경험',
      'meta': '데이터 15,000건 → B2B 숙박 서비스 컨셉',
    },
    {
      'id': 'org',
      'title': '성장을 설계하는 조직 경험',
      'meta': '	경험 흐름 분석 → 자기개발 포인트 제도 설계',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'WORK'),
            const SizedBox(height: 60),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CATALOG — ${_projects.length} STUDIES',
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Mono',
                        fontSize: 11,
                        color: Color(0xFFA6A29B),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // STEP 5-4: 모바일 = 세로 목록, 데스크톱 = 기존 3열
                    isMobile
                        ? Column(
                            children: [
                              for (int i = 0; i < _projects.length; i++) ...[
                                ProjectCard(
                                  number: '0${i + 1}',
                                  title: _projects[i]['title']!,
                                  meta: _projects[i]['meta']!,
                                  onTap: () => context.go('/projects/${_projects[i]['id']}'),
                                ),
                                if (i != _projects.length - 1) const SizedBox(height: 20),
                              ],
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < _projects.length; i++) ...[
                                Expanded(
                                  child: ProjectCard(
                                    number: '0${i + 1}',
                                    title: _projects[i]['title']!,
                                    meta: _projects[i]['meta']!,
                                    onTap: () => context.go('/projects/${_projects[i]['id']}'),
                                  ),
                                ),
                                if (i != _projects.length - 1) const SizedBox(width: 24),
                              ],
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
