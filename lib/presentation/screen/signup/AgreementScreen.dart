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
    final pageController = PageCo oller(); // Replace with actual controller if needed
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
이 약관은 BitWay(이하 "회사")가 제공하는 서비스를 이용함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (서비스의 내용)
회사는 사용자가 디지털 자산 시세 정보, AI 차트 분석, 투자 커뮤니티 등 다양한 기능을 사용할 수 있도록 서비스를 제공합니다.

제3조 (회원가입)
이용자는 본 약관에 동의함으로써 회원가입 절차를 완료하며, 제공한 정보는 진실하고 정확해야 합니다.

제4조 (계정 관리)
회원은 계정 정보(이메일, 비밀번호 등)를 직접 관리해야 하며, 타인에게 양도하거나 공유할 수 없습니다.

제5조 (서비스 이용 제한)
다음과 같은 행위는 금지되며, 위반 시 서비스 이용이 제한될 수 있습니다:
- 불법적인 거래 시도
- 시스템 해킹 및 부정 접속
- 타인의 개인정보 도용

제6조 (책임의 한계)
회사는 실시간 시세, AI 분석 정보 제공에 최선을 다하나, 투자 판단 및 손익에 대한 책임은 사용자 본인에게 있습니다.

제7조 (약관 변경)
회사는 필요한 경우 약관을 변경할 수 있으며, 변경 시 앱 또는 웹사이트를 통해 공지합니다.

(이하 생략)
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