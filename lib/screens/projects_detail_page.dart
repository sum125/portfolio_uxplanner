import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_uxplanner/widget/page_header.dart';
import 'package:portfolio_uxplanner/widget/redefinition_mark.dart';
import 'package:portfolio_uxplanner/widget/spec_table.dart';
import 'package:portfolio_uxplanner/widget/story_section.dart';
import 'package:portfolio_uxplanner/widget/key_moment.dart';
import 'package:portfolio_uxplanner/widget/section_nav_dots.dart';
import 'package:portfolio_uxplanner/widget/prototype_carousel.dart';
import 'package:portfolio_uxplanner/widget/prev_next_project_nav.dart';
import 'package:portfolio_uxplanner/widget/process_flow.dart';
import 'package:portfolio_uxplanner/widget/question_flow.dart';
import 'package:portfolio_uxplanner/widget/glossary_term.dart';
import 'package:portfolio_uxplanner/widget/rich_body_text.dart';

class ProjectsDetailPage extends StatefulWidget {
  final String projectId;
  const ProjectsDetailPage({super.key, required this.projectId});

  @override
  State<ProjectsDetailPage> createState() => _ProjectsDetailPageState();
}

class _ProjectsDetailPageState extends State<ProjectsDetailPage> {
  final ScrollController _scrollController = ScrollController();
  int _activeSection = 0;

  final List<String> _sectionLabels = [
    '문제',
    '재정의',
    '검증',
    '발견',
    '설계',
    '회고',
  ];
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    int closestIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;
      final distance = (position - 120).abs();

      if (position <= 150 && distance < closestDistance) {
        closestDistance = distance;
        closestIndex = i;
      }
    }

    if (closestIndex != _activeSection) {
      setState(() => _activeSection = closestIndex);
    }
  }

  void _jumpTo(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _launchExternal(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static const Map<String, Map<String, dynamic>> _data = {
    'chatbot': {
      'sku': 'Project NO. 01',
      'affiliation': '학부 프로젝트 → 학술지 투고 (리비전 중)',
      'title': 'AI 멘탈케어 챗봇 인터랙션 분석',
      'summary':
          '가이드형과 개방형 중 무엇이 나은지 비교해보는 것에서 출발했지만, 두 구조 모두에서 반복되는 이탈의 원인이 맥락 파악 실패에 있다는 것을 확인했습니다. 그래서 하나의 정답 구조를 고르는 대신, 사용자가 필요할 때 구조를 켜고 끌 수 있는 하이브리드 인터랙션을 설계하고 진입·대화·종결 3단계 프로토타입으로 구체화했습니다. 진입 단계의 시점 선택권은 "대화를 강요당한다"는 불만에, 감정 칩은 맥락 확인 실패라는 핵심 이탈 원인에, 종결 선택권은 "끝없는 공감이 답답하다"는 핵심 페인포인트에 각각 대응하는 설계입니다.',
      'original': '가이드형과 개방형, 어떤 인터랙션이 더 나은가',
      'redefined': '구조와 무관하게, 사용자는 언제 맥락을 잃고 이탈하는가',
      'specs': {
        '기간': '4주 (+ 논문 보강 1주)',
        '표본': '스크리닝 100명 · 심층인터뷰 20명 (초기 22명·8명에서 확대)',
        '방법론': 'Sequential Monadic',
      },
      'methodReason':
          '가이드형과 개방형을 다른 사람에게 각각 보여주면 응답자 성향 차이가 결과에 섞여버립니다. 같은 사람이 두 인터랙션을 순차 체험하게 해서, 두 번째 경험에서 드러나는 미세한 불편과 상대적 체감 차이를 포착하는 방법을 택했습니다. 먼저 쓴 앱이 나중 평가에 영향을 주지 않도록 가이드형 앱(Wysa) 선행/개방형 앱(GPT) 선행 그룹을 교차 배치했고, 앱 이름을 언급하지 않는 블라인드 방식으로 선입견도 배제했습니다.\n\n초기 22명, 8명이었던 표본은 성향별로 패턴이 갈리는 걸 확인한 뒤, 검증을 위해 100명, 20명까지 넓혔습니다.',
      'process': null,
      'journeyStages': null,
      'activeJourneyIndices': null,
      'interviewQuestions': null,
      'pivot':
          '처음엔 **에너지 상태**를 분석 축으로 잡았습니다. 그런데 에너지는 그날그날 바뀌는 값이라, 같은 사람도 측정 시점에 따라 다른 답을 낼 수 있었습니다.\n\n이대로면 노이즈를 성향으로 오독할 위험이 있다고 판단해, **평소 감정을 다루는 성향**(promotion/prevention)으로 축을 바꿨습니다 — 상태보다 훨씬 안정적으로 유지되는 변수였습니다.',
      'decision':
          '안정적인 변수로 바꾸고 나서야 진짜 패턴이 보였습니다. promotion 성향은 개방형을, prevention 성향은 가이드형을 선호했습니다. 다양한 관점으로 분석을 하다보니 중요한 발견이 있었습니다 — 사용자마다 해결의 정의 자체가 달랐습니다. 그저 들어주는 것만으로 만족하는 사람에게는 개방형(GPT)의 기계적인 해결 시도가 오히려 방해였고, 명확한 답을 원하는 사람에게는 가이드형(Wysa)의 얕은 조언과 끝없는 공감이 답답함으로 남았습니다.\n\n구조를 아무리 잘 맞춰도 해결책이 모호하거나 맥락에 맞는 공감이 아니면 결국 이탈한다는 뜻이었습니다. 좋은 가이드의 전제는 형식이 아니라 맥락 파악 여부라는 결론을 내렸고, 하이브리드 인터랙션 구조의 핵심을 **사용자의 맥락을 잘 따라가는** 시스템으로 결합하는 개선안으로 이어졌습니다.',
      'retrospective':
          '문제를 인터랙션 형태(가이드형 vs 개방형)로 두면 너무 한정적이라는 것을 배웠습니다. **맥락 반영 실패의 반복**이라는 하나의 공통적인 중요한 문제로 정의하고 나서야 개선안이 명확해졌습니다.\n\n사람이 왜 대화를 멈추는지, 그 이유를 끝까지 좁혀가는 과정 자체가 흥미로웠던 프로젝트입니다.',
      'prototypes': [
        {
          'image': 'assets/mental_entry.png',
          'caption': '진입 단계 — 진행 시점 선택권 추가',
        },
        {
          'image': 'assets/mental_emotion.png',
          'caption': '대화 진행 단계 — 맥락 확인 질문(감정 칩) 시스템',
        },
        {
          'image': 'assets/mental_finish.png',
          'caption': '마무리 단계 — 종결 시점의 선택권',
        },
      ],
      'sideProjectUrl': 'https://chatbot5-wheat.vercel.app/',
      'outcomeHeight': null,
      'outcomeWidth': null,

      'paperStatus': 'JMIR Human Factors 투고 · 수정 후 게재 판정을 받아 재심사 중입니다',
      'paperMotivation': null,
      'paperExpansion':
          '표본도 다시 설계했습니다. 초기 인터뷰 8명은 패턴을 발견하기엔 충분했지만, 그 패턴이 우연이 아니라는 걸 증명하기엔 부족했습니다. 설문 조사를 100명으로, 직접 사용해보는 인터뷰는 20명으로 확장해 연구를 확장했습니다.\n\n설문 설계, 인터뷰 진행, 정성 코딩, 통계분석을 진행하였습니다.',
      'paperReframe':
          '학기 프로젝트 때 썼던 promotion/prevention 축은 자체 제작한 문항 2개로 판단한 것이었고, 검증된 도구가 아니었습니다. 학술적으로 이 결과를 발표하려면 타당성이 확인된 척도가 필요하다고 판단해, 이미 검증된 한국어 척도(IUS-12, K-STAI-T, K-DERS)로 완전히 교체했습니다.\n\n기존 인터뷰 참가자 8명에게도 새 척도로 설문을 다시 받아 소급 적용했습니다. 예측 불가능한 상황을 못 견디는 정도(IU)가 높을수록 예측 가능한 가이드형 구조를 선호할 거라는 가설로 다시 세웠습니다.',
      'paperConclusion':
          '결론은 하나의 정답이 아니라, 두 구조 모두 **올바르게 구현됐을 때만** 도움이 된다는 것이었습니다. 가이드형은 예측 가능함이 강점이지만 맥락을 무시한 반복 질문은 오히려 대화의 통제권을 빼앗았고, 개방형은 자유로움이 강점이지만 스스로 대화를 이끌어야 하는 부담이 있었습니다.\n\n그래서 최종 제안은 고정된 하나의 구조가 아니라, 사용자가 필요할 때 구조를 켜고 끌 수 있는 프로파일 기반 하이브리드 인터페이스였습니다.',
    },
    'lgsuite': {
      'sku': 'Project NO. 02',
      'affiliation': 'LG DX School · 학부 팀 프로젝트',
      'title': '액티브 시니어의 삶에서의 LG가전 경험 설계',
      'summary':
          'LG전자는 가전 시장 점유율 1위지만, 여러 제품을 함께 경험해본 고객은 세대·구매력 면에서 한정적이었습니다. 액티브 시니어의 관심사를 넓게 크롤링하다가 **여행**이 가장 두드러진 주제라는 걸 데이터로 발견했고, 그 안에서도 **숙소가 목적지**라고 답하는 사람들의 회복 니즈를 찾아 제품 경험으로 연결했습니다.',
      'original': '체험 공간을 만들면, 고객이 찾아올 것이다',
      'redefined': '고객을 찾아오게 하는 대신, 고객의 삶(여행) 속으로 먼저 들어가야 한다',
      'specs': {
        '표본': '1차 4,889건 · 2차 16,027건 (총 45,000건+ 원본 수집)',
        '방법론': 'SBERT 임베딩 · UMAP · HDBSCAN · NMF',
        '도구': 'SBERT+RandomForest 분류기 · TF-IDF · Opportunity Map',
      },
      'methodReason':
          '먼저 타겟부터 데이터로 검증했습니다. 2026년 한국 50세 이상 인구가 46%를 넘고, 2050년엔 이들의 소비지출 비중이 71%까지 늘어날 것으로 전망됩니다. 그중에서도 **액티브 시니어**와 **일반 시니어**는 다른 집단으로 구분지어야 합니다. 신한카드 데이터에 따르면 액티브 시니어의 소비는 늘고(+10%) 일반 시니어는 줄고(-22%) 있었기 때문입니다.\n\n이들이 원하는 건 돌봄이 아니라 경험 가치인데, LG는 아직 기능 제공에 머물러 있다는 게 저희가 잡은 핵심 난제였습니다.',
      'process': [
        {
          'title': '타겟 검증',
          'description': '액티브 시니어를 데이터로 검증 (인구·소비 지표)\n시니어 라이프스타일 카페 3곳에서 5,197건을 모아 전처리 후 4,889건을 확보했습니다.',
        },
        {
          'title': '기회 발굴',
          'description': '관심사 전반 크롤링(노후소득, 건강여가, 가족, 여행여가) → 여행이 최대 주제로 부상 (4,889건)',
        },
        {
          'title': '니즈 구조화',
          'description': '2차 크롤링을 통해 얻은 여행 데이터 16,027건을 4개 Actor로 군집화, Opportunity Map으로 미충족 영역 특정',
        },
        {
          'title': '컨셉 결정',
          'description': '여행을 온전히 즐기기 위한 회복 니즈 → LG SUITE 컨셉 정의, 경쟁사 검증',
        },
      ],
      'pivot':
          '4개 클러스터 모두가 후보는 아니었습니다. 국내 당일치기 여행객은 숙소 체류 시간이 짧아 개입할 맥락 자체가 부족했고, 여행 기록·공유형은 숙소를 콘텐츠 배경으로만 쓸 뿐 회복이 핵심 가치로 작동하지 않았습니다. 장거리 해외여행 일정 조율형도 고려했지만, 이들의 페인포인트는 동선·교통편 같은 이동 문제에 가까웠습니다.\n\n반면 숙소 품질·위치 비교형은 실제 데이터에서 **관광이 아니라 숙소가 목적지**라고 말하고 있었고, **여행의 피로는 이동에서부터 누적된다 — 숙소 도착이 곧 회복의 시작이어야 한다**는 인사이트가 나왔습니다. 이에 따라, 객실 안의 가전 경험을 설계하는 LG SUITE를 제안했습니다.',
      'decision':
          '**숙소에 머무는 것 또한 여행의 큰 즐거움이 되었으면 좋겠다**는 이 페르소나의 바람을, **일상처럼 편안하고 회복되는 숙박 경험**이라는 서비스 가치로 바꿔 제안했습니다. 가전을 전면에 내세우지 않고, 체크인 전부터 실내 환경을 선제적으로 세팅해 여행객이 도착하자마자 회복을 시작할 수 있게 설계했습니다.\n\n경쟁 사례(Samsung-Accor 등)를 먼저 조사해 이 논리가 무너질 수 있는 지점부터 검증했고, 운영자가 아닌 고객의 회복 경험을 중심에 둔 접근이라는 차별점을 확인했습니다.',
      'retrospective':
          '데이터는 질문이 먼저 있을 때에만 방향이 된다는 걸 배웠습니다. 처음부터 **여행**을 정해두고 크롤링했다면 이 발견은 없었을 겁니다.\n\n관심사 전체를 넓게 열어두고 봤기 때문에 여행이라는 주제가, 그리고 그 안에서도 **숙소가 목적지**라는 뜻밖의 인사이트가 데이터 안에서 스스로 드러날 수 있었습니다.',
      'prototypes': null,
      'outcomes': [
        {'image': 'assets/lg_map.png', 'caption': 'UMAP + HDBSCAN Actor 클러스터 시각화'},
        {'image': 'assets/lg_opportunity.png', 'caption': 'Actor-Action Opportunity Matrix — Underserved 영역 발견'},
      ],
      'outcomeHeight': null,
      'outcomeWidth': null,
      'paperStatus': null,
      'paperMotivation': null,
      'paperExpansion': null,
      'paperReframe': null,
      'paperConclusion': null,
    },
    'org': {
      'sku': 'Project NO. 03',
      'affiliation': '학부 팀 프로젝트',
      'title': '성장 몰입을 만드는 조직 제도 설계 — GGP',
      'summary': '조직 문화를 만족도 조사로 접근하지 않기로 결정하고, 구성원의 실제 경험 흐름을 인터뷰로 재구성해 조직 경험이 형성되는 지점을 분석했습니다.',
      'original': '구성원들은 조직 생활에 얼마나 만족하는가',
      'redefined': '구성원은 입사부터 지금까지 어떤 경험 흐름을 지나왔고, 그 흐름의 어디서 몰입이 생기고 어디서 단절되는가',
      'specs': {
        '기간': '4~5주 (주당 5~8시간)',
        '방법론': '반구조화 인터뷰 · 경험 흐름 재구성',
        '흐름': '입사 → 적응 → 관계형성 → 업무경험 → 몰입',
      },
      'methodReason':
          '설문 조사를 통해 조사를 해볼 수 있었지만, 만족도 점수는 왜 그런 점수가 나왔는지 충분히 설명하지 못한다고 판단했습니다. 그래서 실제로 있었던 경험 사례를 말하게 하는 질문으로 인터뷰를 설계했습니다.\n\n 인터뷰 후 경험을 긍정/부정으로 나누고 흐름 순서로 정리해나갔습니다.',
      'process': null,
      'journeyStages': ['입사', '적응・성장', '휴식과 일상', '성장 동기부여', '퇴직'],
      'activeJourneyIndices': [2, 3],
      'interviewQuestions': [
        {
          'stage': '휴식과 일상',
          'question': '운영 중인 복지 제도에는 어떤 것들이 있는지 간단히 소개해주실 수 있을까요?',
          'answer':
              '대학원 무료 지원, 자녀 학자금, 건강검진, 대출·전자제품 할인 등 혜택은 많다. 하지만 역량강화교육 같은 자기개발 관련 복지는 "학교에서 열어줄 테니 알아서 들어라" 수준이고, 이를 지원하는 금전적 지원은 없다. 제도들이 따로 놀아서 한 분야 전문가로 성장할 수 있는 트랙이 부재하다.',
        },
        {
          'stage': '성장 동기부여',
          'question': '업무 성과에 대해서는 보통 어떤 방식으로 인정이나 보상이 이루어지나요?',
          'answer':
              '직무의 가치를 평가해 성과에 따라 보상하는 시스템이 부족하고, 기존 호봉제만으로는 업무 동기부여가 어렵다. 전문가로 성장할 수 있는 트랙(박사 학위, 해외 파견, 교환 프로그램 등)이 확대되었으면 좋겠다는 바람이 있다.',
        },
      ],
      'pivot':
          '제도가 잘 갖춰진 조직이라도 구성원의 몰입도가 늘 높지는 않았습니다. 제도를 실제로 활용하는 정도, 조직원이 원하는 제도인지가 조직 경험의 만족도를 가르는 기준이었습니다.\n\n조직이 설계한 것과 구성원이 실제로 겪는 것 사이엔 예상보다 뚜렷한 간극이 있었습니다.',
      'decision':
          '몰입은 **자신이 계속 성장해나가는 순간**에서 생긴다는 인사이트를 바탕으로, 피드백 구조 강화와 기여를 명확히 전달하는 장치, 초기 적응 경험 개선을 제안했습니다.\n\n특히 구성원의 성장을 위한 자기개발 지원 체계가 부족하다는 발견을 바탕으로 HUFS Global Growth Point(GGP)라는 자기주도 학습 포인트 제도를 설계했습니다.',
      'retrospective':
          '경험을 분석할 때는 분석 기준을 먼저 명확히 세우는 것이 결과의 신뢰도를 결정한다는 걸 배웠습니다.\n\n제품 및 서비스가 아니더라도, 사람이 겪는 흐름이 있는 곳이면 같은 방법론이 통한다는 것도 이 프로젝트에서 확인했습니다.',
      'prototypes': null,
      'outcomes': [
        {'image': 'assets/IDA.png', 'caption': '시범운영 신청서 양식(IDP) 설계'},
      ],
      'outcomeHeight': 640,
      'outcomeWidth': 480,
      'paperStatus': null,
      'paperMotivation': null,
      'paperExpansion': null,
      'paperReframe': null,
      'paperConclusion': null,
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = _data[widget.projectId];

    if (data == null) {
      return const Scaffold(
        body: Center(child: Text('존재하지 않는 프로젝트입니다')),
      );
    }

    final List<String> ids = _data.keys.toList();
    final int currentIndex = ids.indexOf(widget.projectId);
    final String prevId = ids[(currentIndex - 1 + ids.length) % ids.length];
    final String nextId = ids[(currentIndex + 1) % ids.length];
    final Map<String, dynamic> prevData = _data[prevId]!;
    final Map<String, dynamic> nextData = _data[nextId]!;

    final List<dynamic>? prototypes = data['prototypes'];
    final List<dynamic>? outcomes = data['outcomes'];
    final List<dynamic>? process = data['process'];
    final List<dynamic>? journeyStages = data['journeyStages'];
    final bool hasPaperExtension = data['paperExpansion'] != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3EF),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(label: 'PROJECT'),
                const SizedBox(height: 60),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(key: _sectionKeys[0], child: const SizedBox()),
                        Text(
                          data['sku'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Mono',
                            fontSize: 11,
                            color: Color(0xFFA73B2E),
                          ),
                        ),
                        if (data['affiliation'] != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            data['affiliation'],
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 10,
                              color: Color(0xFFA6A29B),
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          data['title'],
                          style: const TextStyle(
                            fontFamily: 'Gowun Batang',
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0xFF1D1D1B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        RichBodyText(
                          text: data['summary'],
                          style: const TextStyle(
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            height: 1.7,
                            color: Color(0xFF1D1D1B),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(key: _sectionKeys[1], child: const SizedBox()),
                        RedefinitionMark(
                          original: data['original'],
                          redefined: data['redefined'],
                        ),
                        const SizedBox(height: 32),
                        Container(key: _sectionKeys[2], child: const SizedBox()),
                        SpecTable(specs: Map<String, String>.from(data['specs'])),
                        const SizedBox(height: 12),
                        StorySection(
                          heading: 'WHY THIS METHOD',
                          body: data['methodReason'],
                        ),
                        const SizedBox(height: 32),
                        if (journeyStages != null) ...[
                          QuestionFlow(
                            journeyStages: List<String>.from(journeyStages),
                            activeIndices: List<int>.from(data['activeJourneyIndices']),
                            steps: (data['interviewQuestions'] as List)
                                .map(
                                  (q) => QuestionStep(
                                    stage: q['stage'] as String,
                                    question: q['question'] as String,
                                    answer: q['answer'] as String?,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 32),
                        ],
                        if (process != null) ...[
                          const Text(
                            'PROCESS',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ProcessFlow(
                            steps: process
                                .map(
                                  (p) => ProcessStep(
                                    title: p['title'] as String,
                                    description: p['description'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 48),
                        ] else
                          const SizedBox(height: 16),
                        Container(key: _sectionKeys[3], child: const SizedBox()),
                        KeyMoment(body: data['pivot']),
                        const SizedBox(height: 48),
                        Container(key: _sectionKeys[4], child: const SizedBox()),
                        StorySection(
                          heading: 'INSIGHT TO DECISION',
                          body: data['decision'],
                        ),
                        const SizedBox(height: 32),
                        if (prototypes != null && prototypes.isNotEmpty) ...[
                          PrototypeCarousel(
                            items: prototypes
                                .map(
                                  (p) => PrototypeItem(
                                    imagePath: p['image'] as String,
                                    caption: p['caption'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 40),
                        ],
                        if (outcomes != null && outcomes.isNotEmpty) ...[
                          const Text(
                            'OUTCOME',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PrototypeCarousel(
                            height: (data['outcomeHeight'] as num?)?.toDouble() ?? 420,
                            width: (data['outcomeWidth'] as num?)?.toDouble(),
                            items: outcomes
                                .map(
                                  (o) => PrototypeItem(
                                    imagePath: o['image'] as String,
                                    caption: o['caption'] as String,
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 48),
                        ],
                        Container(key: _sectionKeys[5], child: const SizedBox()),
                        StorySection(
                          heading: 'RETROSPECTIVE',
                          body: data['retrospective'],
                        ),
                        const SizedBox(height: 48),
                        if (hasPaperExtension) ...[
                          const Text(
                            'PAPER EXTENSION',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data['paperStatus'],
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA6A29B),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'WHY GO FURTHER',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GlossaryParagraph(
                            segments: [
                              const GlossarySegment.text('프로젝트 결과를 보신 지도교수님의 제안으로 후속 연구를 시작했습니다. 학기 프로젝트에서 쓴 성향 축은 저희가 만든 '),
                              GlossarySegment.term(
                                text: '문항 2개',
                                definition:
                                    'Q7. 정말 지치고 힘든 하루를 보냈습니다. 친구에게 하소연하려는데, 기대하는 반응은?\n'
                                    'A. 구체적으로 먼저 질문해주는 것\n'
                                    'B. "다 들어줄게"라며 판을 깔아주는 것\n'
                                    'C. 조용히 옆에 있어주거나 짧은 위로만 해주는 것\n\n'
                                    'Q8. 힘들 때 주변 사람에게 표현하는 방식은?\n'
                                    'A. 상대가 눈치채고 물어봐 줄 때까지 기다림\n'
                                    'B. 내가 먼저 상황과 감정을 구체적으로 이야기함\n'
                                    'C. 누구에게도 말하지 않고 혼자 해결함',
                                rationale:
                                    '표준화된 도구가 아니라, 저희가 논리적으로 추론해서 만든 임시 문항이었습니다. (AA이면 prevention/BB이면 promotion)',
                              ),
                              const GlossarySegment.text(
                                '로 판단한 것이었습니다. 그럴듯해 보이는 패턴이었지만, 학술적으로 발표하려면 타당성이 검증되지 않은 자체 지표로는 부족하다고 판단했습니다.',
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          StorySection(
                            heading: 'EXPANDING THE STUDY',
                            body: data['paperExpansion'],
                          ),
                          const SizedBox(height: 32),
                          StorySection(
                            heading: 'REFRAMING THE THEORY',
                            body: data['paperReframe'],
                          ),
                          const SizedBox(height: 24),
                          GlossaryParagraph(
                            segments: [
                              const GlossarySegment.text(
                                'IU가 높은 참가자 중 53%가 가이드형을 선택한 반면, 낮은 참가자는 28%만 가이드형을 선택했습니다. 이 차이는 ',
                              ),
                              GlossarySegment.term(
                                text: '카이제곱 검정',
                                definition: '두 집단의 비율 차이가 우연이 아닌지 확인하는 통계 검정입니다.',
                                rationale: '표본이 100명으로 늘면서, 관찰된 패턴이 우연인지 아닌지 통계적으로 확인할 수 있게 됐습니다.',
                              ),
                              const GlossarySegment.text(' 결과 통계적으로 유의했습니다 (χ²=6.4, p=.011).'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GlossaryParagraph(
                            segments: [
                              const GlossarySegment.text('다만 IU를 연속값으로 넣은 '),
                              GlossarySegment.term(
                                text: '로지스틱 회귀',
                                definition: '두 집단으로 딱 나누지 않고, 점수 차이가 결과에 미치는 영향을 정밀하게 분석하는 통계 방법입니다.',
                                rationale: '집단을 나눈 경계선 때문에 생긴 착시인지 확인하기 위해 추가로 검증했습니다.',
                              ),
                              const GlossarySegment.text(
                                '에서는 이 관계가 유의하지 않았습니다. 그래서 이 결과를 확정된 효과가 아니라, 추가 검증이 필요한 탐색적 패턴으로 정직하게 보고했습니다.',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GlossaryParagraph(
                            segments: [
                              const GlossarySegment.text('정성 분석은 '),
                              GlossarySegment.term(
                                text: 'CQR',
                                definition: '소규모 표본을 체계적으로 분석하는 정성 연구 방법론입니다. 코더 간 합의와 외부 감사를 거쳐 신뢰도를 확보합니다.',
                                rationale: '20명이라는 적은 인원에서도 신뢰할 수 있는 패턴을 뽑아내기 위해 채택했습니다.',
                              ),
                              const GlossarySegment.text(
                                ' 방식으로, 두 명이 독립적으로 코딩한 뒤 합의하고 외부 감사자에게 검증받는 절차를 거쳤습니다. 가이드형의 반복 질문이 오히려 대화의 통제권을 뺏는다고 느낀 참가자가 13명으로 가장 많았습니다.',
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          StorySection(
                            heading: 'REVISED CONCLUSION',
                            body: data['paperConclusion'],
                          ),
                          const SizedBox(height: 48),
                        ],
                        if (data['sideProjectUrl'] != null) ...[
                          const Text(
                            'AFTER THE PAPER',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA73B2E),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '논문이 마무리된 후, 개인적으로 만들어본 사이드 프로젝트입니다',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Mono',
                              fontSize: 11,
                              color: Color(0xFFA6A29B),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GlossaryParagraph(
                            segments: [
                              const GlossarySegment.text(
                                '인터뷰에서 반복해서 들었던 인사이트가 있었습니다 — ',
                              ),
                              GlossarySegment.term(
                                text: '감정을 정확히 정의하는 것',
                                definition:
                                    '지금 느끼는 감정이 무엇인지 정확한 언어로 짚어내는 것. 논문에서 다룬 정서명료성(Emotion Clarity, K-DERS)과 같은 개념입니다.',
                                rationale:
                                    '정서명료성이 낮을수록 챗봇에게 기대하는 게 달라진다는 게 논문의 핵심 발견 중 하나였는데, 그 발견을 실제로 써먹어보고 싶었습니다.',
                              ),
                              const GlossarySegment.text(
                                '만으로도 위로가 된다는 것이었습니다. 이 발견을 직접 구현해보고 싶어서, 감정을 정의하도록 돕는 하이브리드형 챗봇을 혼자 만들었습니다.',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const RichBodyText(
                            text:
                                '해달은 무리 지어 서로 손을 잡고 함께 떠 있는 습성이 있습니다. 그 습성에서 착안해, 사용자 곁에 친근하게 머무르는 캐릭터로 UI를 구성했습니다.',
                            style: TextStyle(
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              height: 1.8,
                              color: Color(0xFF1D1D1B),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => _launchExternal(
                              data['sideProjectUrl'] as String,
                            ),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFA73B2E),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.play_circle_outline,
                                      size: 18,
                                      color: Color(0xFFA73B2E),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        'Claude Code로 바이브 코딩해 직접 구현한 챗봇입니다',
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans KR',
                                          fontSize: 13,
                                          height: 1.6,
                                          color: Color(0xFF1D1D1B),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      '바로가기 →',
                                      style: TextStyle(
                                        fontFamily: 'IBM Plex Mono',
                                        fontSize: 12,
                                        color: Color(0xFFA73B2E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                        ],
                        PrevNextProjectNav(
                          prevTitle: prevData['title'],
                          nextTitle: nextData['title'],
                          onTapPrev: () => context.go('/projects/$prevId'),
                          onTapNext: () => context.go('/projects/$nextId'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 32,
            top: 0,
            bottom: 0,
            child: Center(
              child: SectionNavDots(
                labels: _sectionLabels,
                activeIndex: _activeSection,
                onTapDot: _jumpTo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
