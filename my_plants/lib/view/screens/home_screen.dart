import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_plants/bloc/navigation_bar/navigation_bar_bloc.dart';
import 'package:my_plants/models/plant.dart';
import 'package:my_plants/view/widgets/tip_card.dart';
import 'package:my_plants/view/widgets/title_page.dart';
import 'package:my_plants/view/widgets/widgets.dart';

final plants = <Plant>[
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://asset.bloomnation.com/c_pad,d_vendor:global:catalog:product:image.png,f_auto,fl_preserve_transparency,q_auto/v1638511570/vendor/6043/catalog/product/2/0/20210422044402_file_6081a7d2cc497_6081a8c3dfcc6..png",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn11.bigcommerce.com/s-ym10hve4zo/images/stencil/1920w/products/157/512/6__HB_-_Spider_Plant_-_Chlorophytum_comosum_-_Standard__29128.1619630987.png?c=1",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/peacelily4in_1024x1024.png?v=1609956111",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://bloomingartificial.imgix.net/product-images/sansevieria/Sansevira_green.png?auto=format%2Ccompress&fill=solid&fit=fillmax&h=780&ixlib=php-3.3.1&w=1020",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
  Plant(
      id: "1",
      name: "name",
      picture:
          "https://cdn.shopify.com/s/files/1/0262/7875/6434/products/Jade6inwebv2_1024x1024.png?v=1595356130",
      description: "description",
      maintenance: Maintenance(
          minimumTemperature: "minimumTemperature",
          idealTemperature: "idealTemperature",
          sunlight: "sunlight",
          irrigation: "irrigation")),
];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _Layout(),
          _Navigation(),
        ],
      ),
    );
  }
}

class _Layout extends StatefulWidget {
  const _Layout({
    Key? key,
  }) : super(key: key);

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  late ScrollController scrollControler;
  double _oldY = 0.0;
  bool _showNavigator = true;
  @override
  void initState() {
    final navigatorBloc =
        BlocProvider.of<NavigationBarBloc>(context, listen: false);
    scrollControler = ScrollController();
    scrollControler.addListener(() {
      if (_oldY < scrollControler.offset && scrollControler.offset > 150) {
        _oldY = scrollControler.offset;
        if (_showNavigator) {
          _showNavigator = false;
          navigatorBloc.add(ShowNavigationBarEvent(show: _showNavigator));
        }
      } else {
        _oldY = scrollControler.offset;
        if (!_showNavigator) {
          _showNavigator = true;
          navigatorBloc.add(ShowNavigationBarEvent(show: _showNavigator));
        }
      }
      //print(_oldY);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollControler.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
        controller: scrollControler,
        physics: BouncingScrollPhysics(),
        children: [
          TitlePage(),
          TipCard(),
          GridView(
            shrinkWrap: true, // You won't see infinite size error
            physics: NeverScrollableScrollPhysics(),
            children: [
              ...plants
                  .map((plant) => CardPlant(
                        plant: plant,
                      ))
                  .toList()
            ],
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: (size.width * 0.5),
                mainAxisExtent: (size.height * 0.37),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
          ),
        ]);
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        child: Align(alignment: Alignment.bottomCenter, child: NavigationBar()),
      ),
    );
  }
}
