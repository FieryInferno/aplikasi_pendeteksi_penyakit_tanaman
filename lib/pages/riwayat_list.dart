import 'package:aplikasi_pendeteksi_penyakit_tanaman/components/title_widget.dart';
import 'package:flutter/material.dart';
import '/components/riwayat_list_item.dart';
import '/data/riwayat.dart';

class RiwayatList extends StatelessWidget {
  final List<Map<String, String>> _riwayatList = Riwayat().list;
  RiwayatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFE7F0EB),
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Color(0xFF116531),
                    ),
                  ),
                  const TitleWidget(title: 'Riwayat')
                ],
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    RiwayatListItem(data: _riwayatList[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: _riwayatList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
