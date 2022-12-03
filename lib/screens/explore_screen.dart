import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';
class ExploreScreen extends StatefulWidget {


  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final controller = ScrollController();
// 1
  final mockService = MockFooderlichService();

  
  @override
  void initState(){
    super.initState();
    controller.addListener(listenScrolling);
  }
  void listenScrolling()
  {
    if(controller.position.atEdge)
    {
      final isTop = controller.position.pixels == 0;

      if(isTop)
      {
        print('i am at the top!');
      }else
      {
        print('i am at the bottom!');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
// 1
    return FutureBuilder(
// 2
      future: mockService.getExploreData(),
// 3
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
// 4
        if (snapshot.connectionState == ConnectionState.done) {
// 5
          return ListView(
            controller: controller,
// 6
            scrollDirection: Axis.vertical,
            children: [
// 7
              TodayRecipeListView(recipes:
              snapshot.data?.todayRecipes ?? []),
// 8
              const SizedBox(height: 16),
// 9
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ??
                  []),
            ],
          );
        } else {
// 10
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}