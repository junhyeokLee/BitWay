import 'package:bitway/presentation/screen/main/home_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../provider/auth/SignupProvider.dart';
import 'AgreementScreen.dart';

class SignUpEmailScreen extends HookConsumerWidget {
  const SignUpEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final codeController = useTextEditingController();

    final state = ref.watch(signupNotifierProvider);
    final notifier = ref.read(signupNotifierProvider.notifier);

    final pageController = usePageController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();
    final nicknameController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final isPasswordValid = useState(false);
    final isEmailValid = useState(false);
    final isCodeValid = useState(false);
    final isNicknameValid = useState(false);

    void validatePasswordFields() {
      final pw = passwordController.text;
      final confirm = confirmController.text;

      final isValid = pw.isNotEmpty &&
          confirm.isNotEmpty &&
          pw.length >= 8 &&
          RegExp(r'[A-Za-z]').hasMatch(pw) &&
          RegExp(r'[0-9]').hasMatch(pw) &&
          pw == confirm;

      isPasswordValid.value = isValid;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("이메일 인증"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // 1. 이메일 입력
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "이메일 입력",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    isEmailValid.value = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,4}$").hasMatch(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "이메일 주소",
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isEmailValid.value
                      ? () async {
                          final success = await notifier.sendEmailCode(emailController.text);
                          if (success) {
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("인증 코드 받기", style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ],
            ),
          ),

          // 2. 인증 코드 입력
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "인증 코드 입력",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    labelText: "코드 6자리",
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) {
                    isCodeValid.value = val.length == 6;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isCodeValid.value
                      ? () async {
                          final verified = await notifier.verifyEmailCode(codeController.text);
                          if (verified) {
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("인증 코드가 유효하지 않습니다.")),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("코드 확인", style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ],
            ),
          ),

          // 3. 비밀번호 입력
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "비밀번호 설정",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "안전한 비밀번호를 입력해주세요. (영문 + 숫자 포함 8자 이상)",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "비밀번호",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "비밀번호를 입력해주세요";
                      if (value.length < 8 || !RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
                        return "8자 이상, 영문+숫자 포함 필요";
                      }
                      return null;
                    },
                    onChanged: (_) => validatePasswordFields(),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: confirmController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "비밀번호 확인",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) return "비밀번호가 일치하지 않습니다";
                      return null;
                    },
                    onChanged: (_) => validatePasswordFields(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isPasswordValid.value
                          ? () {
                              if (!formKey.currentState!.validate()) return;
                              notifier.updatePassword(passwordController.text);
                              pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        disabledBackgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("다음", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. 닉네임 입력
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("닉네임 입력", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nicknameController,
                    decoration: InputDecoration(
                      labelText: "닉네임",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      isNicknameValid.value = value.trim().isNotEmpty;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isNicknameValid.value
                        ? () {
                            notifier.updateNickname(nicknameController.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => AgreementScreen()),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      disabledBackgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("다음", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),

          // 5. 가입 완료 - success animation
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/success_ani.json', width: 200, height: 200),
                  const SizedBox(height: 32),
                  const Text("가입이 완료되었습니다!", style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen2()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("시작하기", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}