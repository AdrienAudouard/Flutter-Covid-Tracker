import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/ui/departements/departements.dart';
import 'package:covid_tracker/app/ui/vaccine/vaccine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'covid_stats/covid_stats.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CovidStats(),
    Departements(),
    Vaccine()
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: _children[_currentIndex],
        backgroundColor: HexColor('#ecf0f1'),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/virus.svg', height: 30, width: 30),
              label: AppLocalizations.of(context)!.bottomNavigationBarCovid,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/france-icon.svg', height: 30, width: 30),
              label: AppLocalizations.of(context)!.bottomNavigationBarDepartements,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/syringe.svg', height: 30, width: 30),
              label: AppLocalizations.of(context)!.bottomNavigationBarVaccin,
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}