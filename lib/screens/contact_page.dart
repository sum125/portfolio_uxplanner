import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_uxplanner/widget/page_header.dart';
import 'package:portfolio_uxplanner/widget/icon_button_link.dart';
import 'package:portfolio_uxplanner/widget/linkedin_icon.dart';
import 'package:portfolio_uxplanner/widget/keyhole_hub.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const String _email = 'sumin031225@gmail.com';
  static const String _linkedinUrl = 'www.linkedin.com/in/김수민';
  static const String _resumeUrl = 'https://your-resume-link.com';

  Future<void> _launchEmail() async {
    final uri = Uri(scheme: 'mailto', path: _email);
    await launchUrl(uri);
  }

  Future<void> _launchLinkedin() async {
    final uri = Uri.parse(_linkedinUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchResume() async {
    final uri = Uri.parse(_resumeUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 20 : 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(label: 'CONTACT'),

            SizedBox(
              height: screenHeight - (isMobile ? 100 : 140),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 서사를 닫는 열쇠구멍
                      const KeyholeIcon(size: 40, color: Color(0xFFA73B2E)),
                      const SizedBox(height: 28),

                      const Text(
                        '다음 질문은\n함께 풀어가고 싶습니다',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Gowun Batang',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          height: 1.5,
                          color: Color(0xFF1D1D1B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '이메일, LinkedIn, 이력서 중 편한 방법으로 연락 주세요',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFFA6A29B),
                        ),
                      ),
                      const SizedBox(height: 48),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButtonLink(
                            imagePath: 'assets/email_button.png',
                            label: 'EMAIL',
                            onTap: _launchEmail,
                          ),
                          const SizedBox(width: 48),
                          IconButtonLink(
                            iconWidget: const LinkedinIcon(),
                            label: 'LINKEDIN',
                            onTap: _launchLinkedin,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // 이력서 — 주요 CTA로 강조 (채운 버튼)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _launchResume,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1D1D1B),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Text(
                                '이력서 다운로드',
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Mono',
                                  fontSize: 13,
                                  color: Color(0xFFF3F3EF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
