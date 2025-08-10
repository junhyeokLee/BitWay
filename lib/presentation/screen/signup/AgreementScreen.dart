import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../provider/auth/SignupProvider.dart';
import 'CoinSelectScreen.dart';

class AgreementScreen extends ConsumerStatefulWidget {
  const AgreementScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends ConsumerState<AgreementScreen> {
  bool agreeTerms = false;
  bool agreePrivacy = false;
  bool agreeMarketing = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signupNotifierProvider.notifier);
    final pageController = PageController(); // Replace with actual controller if needed
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "약관 동의",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BitWay 이용을 위해 아래 약관에 동의해주세요.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 24),
            // 이용약관 동의 (필수)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: agreeTerms,
                    onChanged: (val) => setState(() => agreeTerms = val ?? false),
                    title: const Text("이용약관 동의 (필수)", style: TextStyle(color: Colors.white)),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blueAccent,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text("이용약관", style: TextStyle(color: Colors.white)),
                        content: const SingleChildScrollView(
                          child: Text(
                            '''[BitWay 이용약관]

제1조 (목적)
이 약관은 BitWay(이하 "회사")가 제공하는 모든 서비스(이하 "서비스")의 이용 조건 및 절차, 회사와 회원 간의 권리와 의무, 책임사항 등을 규정함을 목적으로 합니다.

제2조 (정의)
1. "회원"이란 회사에 개인정보를 제공하고 서비스 이용계약을 체결한 자를 말합니다.
2. "콘텐츠"란 회사가 서비스에서 제공하는 정보, 데이터, 텍스트, 그래픽, 이미지 등을 말합니다.

제3조 (약관의 효력 및 변경)
1. 본 약관은 회원이 서비스에 가입함과 동시에 효력을 발생합니다.
2. 회사는 필요 시 약관을 변경할 수 있으며, 변경 시 앱 또는 홈페이지를 통해 사전 공지합니다.

제4조 (회원가입)
1. 회원가입은 이용자가 약관에 동의하고 가입 양식을 작성한 후 회사의 승낙으로 성립됩니다.
2. 회사는 다음 각 호에 해당하는 경우 회원가입을 거부하거나 사후 해지할 수 있습니다.
  - 허위 정보를 기재한 경우
  - 타인의 정보를 도용한 경우

제5조 (서비스 이용)
1. 서비스는 연중무휴, 1일 24시간 제공함을 원칙으로 합니다.
2. 회사는 시스템 점검, 서버 교체 등의 사유로 서비스 이용을 일시 중단할 수 있습니다.

제6조 (회원의 의무)
1. 회원은 서비스 이용 시 관계 법령, 약관, 회사의 공지사항을 준수해야 합니다.
2. 타인의 정보 도용, 해킹, 광고성 정보 전송 등의 행위를 해서는 안 됩니다.

제7조 (회사의 의무)
1. 회사는 관련 법령을 준수하며, 회원이 안전하게 서비스를 이용할 수 있도록 최선을 다합니다.
2. 회원의 개인정보는 별도의 동의 없이 제3자에게 제공하지 않습니다.

제8조 (서비스 이용 제한 및 계약 해지)
1. 회원이 약관을 위반한 경우 회사는 사전 통보 없이 서비스 이용을 제한할 수 있습니다.
2. 회원은 언제든지 탈퇴를 요청할 수 있으며, 회사는 즉시 처리합니다.

제9조 (책임 제한)
1. 회사는 천재지변, 불가항력적 사유로 인한 서비스 중단에 대해 책임을 지지 않습니다.
2. 회사는 회원이 서비스를 통해 얻은 정보로 인한 손해에 책임을 지지 않습니다.

제10조 (준거법 및 관할법원)
1. 본 약관은 대한민국 법령에 따라 해석되며, 서비스 이용과 관련하여 분쟁이 발생할 경우 서울중앙지방법원을 관할 법원으로 합니다.
''',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("닫기", style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("보기", style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
            // 개인정보 수집 및 이용 동의 (필수)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: agreePrivacy,
                    onChanged: (val) => setState(() => agreePrivacy = val ?? false),
                    title: const Text("개인정보 수집 및 이용 동의 (필수)", style: TextStyle(color: Colors.white)),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blueAccent,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text("개인정보 수집 및 이용", style: TextStyle(color: Colors.white)),
                        content: const SingleChildScrollView(
                          child: Text(
                            '''[개인정보 수집 및 이용 동의서]

회사는 회원 가입 및 서비스 제공을 위해 아래와 같은 개인정보를 수집합니다.

1. 수집 항목
- 이메일, 비밀번호, 닉네임, 전화번호, 접속기기 정보

2. 수집 목적
- 회원 식별 및 서비스 제공
- 커뮤니티 기능 및 푸시 알림
- 고객 문의 및 기술 지원 응대

3. 보유 및 이용 기간
- 회원 탈퇴 시 즉시 삭제
- 법적 보관 필요 시 관련법에 따라 보관

4. 동의를 거부할 권리
이용자는 동의를 거부할 수 있으며, 거부 시 서비스 이용이 제한될 수 있습니다.
''',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("닫기", style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("보기", style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
            // 마케팅 수신 동의 (선택)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: agreeMarketing,
                    onChanged: (val) => setState(() => agreeMarketing = val ?? false),
                    title: const Text("마케팅 수신 동의 (선택)", style: TextStyle(color: Colors.white)),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blueAccent,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text("마케팅 수신 동의", style: TextStyle(color: Colors.white)),
                        content: const SingleChildScrollView(
                          child: Text(
                            '''[마케팅 수신 동의 안내]

회사는 이벤트, 서비스 안내, 맞춤형 광고 제공을 위해 이메일, 앱 푸시 등을 활용한 마케팅 정보를 발송할 수 있습니다.

1. 발송 수단
- 이메일, 앱 푸시 알림

2. 수신 거부
- 설정 화면 또는 알림 수신 설정을 통해 언제든지 거부할 수 있습니다.

3. 선택 동의
- 본 동의는 선택사항이며, 거부 시에도 서비스 이용에 제한은 없습니다.
''',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("닫기", style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("보기", style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: agreeTerms && agreePrivacy
                  ? () {
                      notifier.updateAgreement(
                        terms: agreeTerms,
                        privacy: agreePrivacy,
                        marketing: agreeMarketing,
                      );
                      // Use your actual navigation/page controller logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CoinSelectScreen(),
                        ),
                      );
                      // If using a PageController, replace above with:
                      // pageController.nextPage(
                      //   duration: const Duration(milliseconds: 500),
                      //   curve: Curves.easeInOut,
                      // );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: agreeTerms && agreePrivacy ? Colors.blueAccent : Colors.grey,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("다음", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}