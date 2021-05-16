import 'package:auto_parts/models/part.dart';
import 'package:auto_parts/providers/parts_provider.dart';
import 'package:auto_parts/widgets/parts/part_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PartsProvider partProvider = context.read<PartsProvider>();
    partProvider.init();

    final double width = MediaQuery.of(context).size.width;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is ScrollUpdateNotification) {}
        if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
          partProvider.getNextPage();
        }
        return true;
      },
      child: StreamBuilder<List<Part>>(
        stream: partProvider.controller.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Part>> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PartItem(
                    width: width,
                    part: snapshot.data[index],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
