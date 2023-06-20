import 'package:flutter/material.dart';
import '../components/page_wrap.dart';
import '../components/riwayat_list_item.dart';
import '../components/click_widget.dart';
import '../data/riwayat.dart';
import '../pages/result.dart';

class RiwayatList extends StatelessWidget {
  final List<Map<String, String>> _riwayatList = Riwayat().list;

  RiwayatList({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      'Blog',
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => ClickWidget(
          destination: Result(
            riwayat: _riwayatList[index],
          ),
          child: RiwayatListItem(data: _riwayatList[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: _riwayatList.length,
      ),
    );
  }
}
