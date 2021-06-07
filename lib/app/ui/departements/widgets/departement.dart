import 'package:covid_tracker/app/blocs/departement_bloc.dart';
import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:covid_tracker/app/ui/departements/widgets/saturation_hospital_card.dart';
import 'package:covid_tracker/app/ui/departements/widgets/simple_data_card.dart';
import 'package:covid_tracker/app/ui/departements/widgets/variant.dart';
import 'package:covid_tracker/app/ui/shared/section.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Departement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: departementBloc.selectedDepartement,
        builder: (context, AsyncSnapshot<DepartementModel> snapshot) {
          if (snapshot.hasData) {
            return buildPage(snapshot.data!, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget buildPage(DepartementModel departementModel, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Section(
              AppLocalizations.of(context)!.pageDepartementData,
              AppLocalizations.of(context)!
                  .pageCovidUpdatedThe(departementBloc.lastUpdated!),
              [
                SimpleDataCard(
                  AppLocalizations.of(context)!.pageDepartementInsidence,
                  departementModel.stats!.incidence.toString(),
                  AppLocalizations.of(context)!
                      .pageDepartementInsidenceExplanation,
                  valueColor:
                  getIncidenceColor(departementModel.stats!.incidence),
                ),
                SimpleDataCard(
                  AppLocalizations.of(context)!.pageDepartementPositivity,
                  '${departementModel.stats!.positivity.toString()}%',
                  AppLocalizations.of(context)!
                      .pageDepartementPositivityExplanation,
                ),
                SaturationHospitalCard(departementModel.stats!),
                Variant(departementModel.stats!)
              ])
        ],
      ),
    );
  }
}
