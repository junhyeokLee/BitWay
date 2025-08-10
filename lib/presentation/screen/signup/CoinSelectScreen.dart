import 'package:bitway/presentation/screen/main/home_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/repository/coin/CoinRepository.dart';
import '../../../data/coin/req/FavoriteCoinReq.dart';
import '../../provider/auth/SignupProvider.dart';


class CoinSelectScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<Set<String>>({});
    // final coinFuture = useFuture(useMemoized(() => CoinRepository().fetchCoinList()));

    void toggle(String coin) {
      selected.value = {
        ...selected.value,
        if (selected.value.contains(coin)) ...[] else coin
      }..removeWhere((c) => selected.value.contains(coin) && c == coin);
    }

    void completeSignup() async {
      final vm = ref.read(signupNotifierProvider.notifier);
      final email = ref.read(signupNotifierProvider).email;

      // 1. 회원가입 먼저 수행 → JWT 토큰 획득
      final success = await vm.submitSignup();
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("회원가입 실패")));
        return;
      }

      // 2. 즐겨찾기 등록 (회원가입 후, 로그인 된 상태에서 수행)
      final dto = FavoriteCoinReq(
        email: email,
        symbols: selected.value.toList(),
        alertEnabled: true,
      );
      // await CoinRepository().saveFavoriteCoins(dto);

      // 3. 메인으로 이동
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen2()));
    }

    return Scaffold(
      appBar: AppBar(title: Text("관심 코인 선택")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // child: coinFuture.connectionState != ConnectionState.done
        //     ? Center(child: CircularProgressIndicator())
            // : coinFuture.hasError
            //     ? Center(child: Text("코인 불러오기 실패"))
            //     : Column(
            //         children: [
            //           Text("최소 3개 이상 선택해주세요", style: TextStyle(fontSize: 16)),
            //           SizedBox(height: 16),
            //           Expanded(
            //             child: GridView.count(
            //               crossAxisCount: 3,
            //               crossAxisSpacing: 12,
            //               mainAxisSpacing: 12,
            //               children: coinFuture.data!.map((coin) {
            //                 final isSelected = selected.value.contains(coin.symbol);
            //                 return GestureDetector(
            //                   onTap: () => toggle(coin.symbol),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                       color: isSelected ? Colors.blue : Colors.grey[200],
            //                       borderRadius: BorderRadius.circular(8),
            //                     ),
            //                     child: Center(
            //                       child: Text(
            //                         coin.symbol,
            //                         style: TextStyle(
            //                           color: isSelected ? Colors.white : Colors.black,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 );
            //               }).toList(),
            //             ),
            //           ),
            //           ElevatedButton(
            //             onPressed: selected.value.length >= 3 ? completeSignup : null,
            //             child: Text("가입 완료"),
            //           )
            //         ],
            //       ),
      ),
    );
  }
}
