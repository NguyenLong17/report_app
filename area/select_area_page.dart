import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/MyTextField.dart';
import 'package:flutter_demo/models/area.dart';
import 'package:flutter_demo/module/account/profile_page.dart';
import 'package:flutter_demo/module/area/select_area_bloc.dart';

class SelectAreaPage extends StatefulWidget {
  final Function(Area, Area) onDone;

  const SelectAreaPage({super.key, required this.onDone});

  @override
  State<SelectAreaPage> createState() => _SelectAreaPageState();
}

class _SelectAreaPageState extends State<SelectAreaPage> {
  late SelectAreaBloc bloc;
  final keywordController = TextEditingController();

  @override
  void initState() {
    bloc = SelectAreaBloc();
    bloc.getCities();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Text(bloc.citySelected == null ? 'Tỉnh/Thành phố' : 'Quận/Huyện');
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          MyTextField(
            controller: keywordController,
            hintText: 'Tìm kiếm...',
            onChanged: bloc.onFilter,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<Area>>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final area = list[index];
                    return buildItem(area);
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: list.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(Area area) {
    return GestureDetector(
      onTap: () {
        if (bloc.citySelected == null) {
          keywordController.text = "";
          bloc.citySelected = area;
          bloc.getDistricts(cityId: area.id ?? '');
        } else {
          widget.onDone(bloc.citySelected!, area);
          Navigator.of(context).pop();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(area.name ?? ''),
      ),
    );
  }
}
