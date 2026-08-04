import 'package:flutter/material.dart';
import 'package:portfolio_uxplanner/widget/page_header.dart';
import 'package:portfolio_uxplanner/widget/redefinition_mark.dart';
import 'package:portfolio_uxplanner/widget/rich_body_text.dart';
import 'package:portfolio_uxplanner/widget/process_flow.dart';
import 'package:portfolio_uxplanner/widget/tool_tags.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 48),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(label: 'ABOUT'),
                const SizedBox(height: 60),

                // 사진 + 정체성 재정의
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPhoto(),
                          const SizedBox(height: 32),
                          _buildIdentity(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPhoto(),
                          const SizedBox(width: 48),
                          Expanded(child: _buildIdentity()),
                        ],
                      ),

                const SizedBox(height: 64),

                // 이력 — 타임라인
                const Text(
                  'EDUCATION & CAREER',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 11,
                    color: Color(0xFFA73B2E),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 24),
                const ProcessFlow(
                  steps: [
                    ProcessStep(
                      title: '한국외국어대학교 · 경제학 / 상담·UX심리학',
                      description: '2026년 8월 졸업 예정',
                    ),
                    ProcessStep(
                      title: '에프엠커뮤니케이션즈 XTL부서',
                      description: '2024.07.01 ~ 2024.12.31 인턴',
                    ),
                  ],
                ),

                const SizedBox(height: 56),

                // 툴 & 방법론
                const Text(
                  'TOOLS & METHODOLOGY',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Mono',
                    fontSize: 11,
                    color: Color(0xFFA73B2E),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                const ToolTags(
                  tags: [
                    'Figma',
                    'Flutter',
                    '스크리닝 서베이',
                    '심층 인터뷰',
                    'Sequential Monadic',
                    'SBERT · UMAP · KMeans',
                    'Python',
                  ],
                ),

                const SizedBox(height: 72),

                // 종합 회고 — 담백한 클로징
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 32),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFDDDAD1), width: 0.7),
                    ),
                  ),
                  child: const RichBodyText(
                    text: '주어진 질문에 바로 답하지 않는 것, 그 질문 자체가 맞는지부터 따지는 것. 좋은 기획은 거기서 시작된다고 믿습니다.',
                    style: TextStyle(
                      fontFamily: 'Gowun Batang',
                      fontSize: 16,
                      height: 1.9,
                      color: Color(0xFF1D1D1B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto() {
    return Container(
      width: 220,
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D1D1B).withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/me.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFFE3E1D8),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '김수민',
          style: TextStyle(
            fontFamily: 'Gowun Batang',
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color(0xFF1D1D1B),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '한국외국어대학교 · 경제학 / 상담·UX심리학 복수전공\n2026년 8월 졸업 예정',
          style: TextStyle(
            fontFamily: 'IBM Plex Mono',
            fontSize: 12,
            height: 1.6,
            color: Color(0xFFA6A29B),
          ),
        ),
        const SizedBox(height: 28),

        const RedefinitionMark(
          original: '사람은 합리적으로 선택한다',
          redefined: '사람은 자신만의 맥락 안에서 선택한다',
        ),
        const SizedBox(height: 28),

        const RichBodyText(
          text:
              '경제학은 사람이 합리적으로 선택한다고 가정합니다. 그런데 실제론 그렇지 않은 선택들이 계속 보였고, 맥락을 이해하고 싶어서 상담·UX심리학을 함께 공부했습니다.\n\n사람의 행동과 심리를 관찰해 인사이트를 찾고, 관찰에서 찾은 인사이트가 실제 서비스의 구조와 화면으로 바뀌는 순간이 좋았습니다. 그래서 발견에서 멈추지 않고 결정하고 설계하는 일을 하고 싶습니다.',
          style: TextStyle(
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w300,
            fontSize: 15,
            height: 1.8,
            color: Color(0xFF1D1D1B),
          ),
        ),
      ],
    );
  }
}
