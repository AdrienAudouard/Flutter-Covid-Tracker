import 'dart:async';

import 'package:covid_tracker/app/blocs/departement_bloc.dart';
import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:covid_tracker/app/models/hex_color.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapFrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    departementBloc.fetchDepartementList();

    return StreamBuilder(
        stream: departementBloc.departementList,
        builder: (context, AsyncSnapshot<List<DepartementModel>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: [
                  Text(
                      AppLocalizations.of(context)!.pageCovidPositiveThisWeek,
                      style: Theme.of(context).textTheme.subtitle1
                  ),
                  buildMap(snapshot.data!),
                  buildLegend(),
                ]
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  Widget buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildLegendItem('< 50', AppColors.green),
        buildLegendItem('< 150', AppColors.orange),
        buildLegendItem('< 250', AppColors.red),
        buildLegendItem('< 400', AppColors.darkViolet),
        buildLegendItem('> 400', AppColors.violet),
      ],
    );
  }

  Widget buildLegendItem(String text, HexColor color) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        getSizedBox(height: 1),
        Text(text),
      ],
    );
  }

  StreamBuilder<String> buildMap(List<DepartementModel> departements) {
    return StreamBuilder(
        stream: getFranceMapWithColor('assets/map-france.svg', departements).asStream(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return SvgPicture.string(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }

  Future<String> getFranceMapWithColor(String path, List<DepartementModel> departements) async {
    final xml = await readSvg(path);
    final departementElement = getXmlWithClass(xml, 'land departement');

    for (final value in departementElement) {
      final departement = getDepartementFromClass(value.getAttribute('class')!);
      value.setAttribute('fill', getDepartementColor(departement, departements));
      value.setAttribute('stroke', 'white');
      value.setAttribute('stroke-width', '0.5');
    }

    return xml.toXmlString();
  }

  Future<String> readFile(String filePath) {
    return rootBundle.loadString(filePath);
  }

  Future<XmlDocument> readSvg(String path) async {
    final content = await readFile(path);
    final xmlRoot = XmlDocument.parse(content);

    return xmlRoot;
  }

  List<XmlElement> getXmlWithClass(XmlDocument document, String className) {
    return document.descendants
        .whereType<XmlElement>()
        .where((p) => p.getAttribute('class')?.contains(className) != null)
        .toList();
  }

  String getDepartementColor(String departementNumber, List<DepartementModel> departements) {
    final departement = departements.firstWhere((element) => element.number.toLowerCase() == departementNumber.toLowerCase());

    return getIncidenceColorStr(departement.stats!.incidence);
  }

  String getDepartementFromClass(String className) {
    return className.replaceAll('land departement', '');
  }
}