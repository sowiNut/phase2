import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';

class SpiderInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SpiderInventoryPage(),
    );
  }
}

class SpiderEntry {
  final String speciesName;
  final String commonName;
  final String venomStatus;
  final String dangerLevel;
  final String origin;

  SpiderEntry({
    required this.speciesName,
    required this.commonName,
    required this.venomStatus,
    required this.dangerLevel,
    required this.origin,
  });
}

class SpiderInventoryPage extends StatefulWidget {
  @override
  _SpiderInventoryPageState createState() => _SpiderInventoryPageState();
}

class _SpiderInventoryPageState extends State<SpiderInventoryPage> {
  final List<SpiderEntry> allSpiders = [
    SpiderEntry(
      speciesName: 'Latrodectus mactans',
      commonName: 'Black Widow',
      venomStatus: 'Highly Venomous',
      dangerLevel: 'High',
      origin: 'North America',
    ),
    SpiderEntry(
      speciesName: 'Loxosceles reclusa',
      commonName: 'Brown Recluse',
      venomStatus: 'Venomous',
      dangerLevel: 'Moderate',
      origin: 'United States',
    ),
    SpiderEntry(
      speciesName: 'Phoneutria fera',
      commonName: 'Brazilian Wandering Spider',
      venomStatus: 'Highly Venomous',
      dangerLevel: 'Extreme',
      origin: 'South America',
    ),
  ];

  List<SpiderEntry> filteredSpiders = [];

  @override
  void initState() {
    super.initState();
    filteredSpiders = allSpiders;
  }

  Color _getColor(String level) {
    switch (level) {
      case 'Extreme':
        return Colors.red.shade300;
      case 'High':
        return Colors.orange.shade300;
      case 'Moderate':
        return Colors.yellow.shade700;
      default:
        return Colors.green.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Last Classification',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight + 16, left: 12, right: 12),
        child: ListView.builder(
          itemCount: filteredSpiders.length,
          itemBuilder: (context, index) {
            final spider = filteredSpiders[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // stronger blur
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.12), // lighter opacity for more translucency
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: _getColor(spider.dangerLevel),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              spider.commonName[0],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  spider.commonName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  spider.speciesName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        spider.venomStatus,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_outward, size: 16, color: Colors.grey),
                                        SizedBox(width: 4),
                                        Text(
                                          spider.dangerLevel,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
