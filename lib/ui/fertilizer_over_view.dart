import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fertilizer_provider.dart';
import '../ui/add_fertilizer.dart';
import '../widgets/fertilizer_item.dart';

class FertilizerOverView extends StatefulWidget {
  static const routName = '/fertilizer-overview';
  const FertilizerOverView({Key? key}) : super(key: key);
  @override
  _FertilizerOverViewState createState() => _FertilizerOverViewState();
}

class _FertilizerOverViewState extends State<FertilizerOverView> {
  @override
  Widget build(BuildContext context) {
    final fertilizerData = Provider.of<FertilizerProvider>(context);
    final fertilzerList = fertilizerData.fertilizerList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fertilizer Details'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: fertilzerList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => FertilzerItem(
          name: fertilzerList[i].name,
          type: fertilzerList[i].type,
          unitPrice: fertilzerList[i].unitPrice,
          image: fertilzerList[i].image,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddFertilizer.routName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
