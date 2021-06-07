import 'package:covid_tracker/app/blocs/vaccine_bloc.dart';
import 'package:covid_tracker/app/models/vaccine/daily_vaccine_model.dart';
import 'package:covid_tracker/app/ui/shared/french_header.dart';
import 'package:covid_tracker/app/ui/shared/section.dart';
import 'package:covid_tracker/app/ui/vaccine/widgets/first_dose.dart';
import 'package:covid_tracker/app/ui/vaccine/widgets/fully_vaccinated.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:covid_tracker/app/utils/utils_func.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Vaccine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VaccineState();
  }
}

class _VaccineState extends State<Vaccine> {
  @override
  void initState() {
    vaccineBloc.fetchStat();
    super.initState();
  }

  @override
  void dispose() {
    vaccineBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: vaccineBloc.franceVaccine,
        builder: (context, AsyncSnapshot<DailyVaccineFranceModel> snapshot) {
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

  Widget buildHome(DailyVaccineFranceModel dailyVaccine, BuildContext context) {
    final latestUpdateDate = toShortDate(dailyVaccine.dates.last);

    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrenchHeader(AppLocalizations.of(context)!.pageVaccineTitle),
                getSizedBox(height: 3),
                Section(
                    AppLocalizations.of(context)!.pageVaccineFirstDose,
                    AppLocalizations.of(context)!.pageCovidUpdatedThe(latestUpdateDate),
                    [FirstDose(dailyVaccine)]
                ),
                getSizedBox(height: 3),
                Section(
                    AppLocalizations.of(context)!.pageVaccineAllDoses,
                    AppLocalizations.of(context)!.pageCovidUpdatedThe(latestUpdateDate),
                    [FullyVaccinated(dailyVaccine)]
                ),
                getSizedBox(height: 3),
                Image.asset('assets/vaccine.png')
              ],
            ),
          ),
        )
    );
  }

}