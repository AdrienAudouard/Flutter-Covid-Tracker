import 'package:covid_tracker/app/blocs/stat_bloc.dart';
import 'package:covid_tracker/app/models/daily_stats/covid_data.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/cas.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/daily_cases_graph.dart';
import 'package:covid_tracker/app/ui/shared/section.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/hospital.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/indicators.dart';
import 'package:covid_tracker/app/ui/covid_stats/widgets/map_france.dart';
import 'package:covid_tracker/app/ui/shared/card.dart';
import 'package:covid_tracker/app/ui/shared/french_header.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CovidStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CovidStatsState();
  }

}

class _CovidStatsState extends State<CovidStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: statBloc.mainStats,
        builder: (context, AsyncSnapshot<CovidData> snapshot) {
          if (snapshot.hasData) {
            return buildHome(snapshot.data!, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildHome(CovidData covidData, BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrenchHeader(AppLocalizations.of(context)!.pageCovidTitle),
                getSizedBox(height: 3),
                Section(AppLocalizations.of(context)!.pageCovidLatestNews,
                    AppLocalizations.of(context)!.pageCovidUpdatedThe(covidData.mainData.newReanimation.date),
                    [
                      CtCard(Indicators(covidData.mainData)),
                      CtCard(Cas(covidData)),
                      CtCard(Hospital(covidData)),
                    ]),
                getSizedBox(height: 3),
                Section(
                    AppLocalizations.of(context)!.pageCovidEvolution,
                    AppLocalizations.of(context)!.pageCovidUpdatedThe(covidData.mainData.newReanimation.date),
                    [
                      DailyCasesGraph(
                        covidData.dailyCases.cas,
                        AppLocalizations.of(context)!.pageCovidPositiveCases,
                        yStep: 10000,
                        legend: AppLocalizations.of(context)!.pageCovidGraphLegend(covidData.dailyCases.cas.values.last),
                      ),
                      DailyCasesGraph(
                          covidData.dailyCases.reanimation,
                          AppLocalizations.of(context)!.pageCovidRea,
                          gradientColors: const [
                            Color(0xffED213A),
                            Color(0xffED213A),
                          ],
                          legend: AppLocalizations.of(context)!.pageCovidReaActual(covidData.dailyCases.reanimation.values.last)
                      )
                    ]
                ),
                Section(
                    AppLocalizations.of(context)!.pageCovidIncidence,
                    AppLocalizations.of(context)!.pageCovidUpdatedThe(covidData.mainData.newReanimation.date),
                    [
                      CtCard(MapFrance())
                    ]
                ),
                getSizedBox(height: 3),
                Image.asset('assets/home.png'),
              ],
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    statBloc.fetchStat();
    super.initState();
  }

  @override
  void dispose() {
    statBloc.dispose();
    super.dispose();
  }
}