import 'package:covid_tracker/app/blocs/departement_bloc.dart';
import 'package:covid_tracker/app/models/departements/departement_model.dart';
import 'package:covid_tracker/app/utils/app_colors.dart';
import 'package:covid_tracker/app/utils/create_sized_box.dart';
import 'package:flutter/material.dart';

import 'widgets/departement.dart';

class Departements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    departementBloc.fetchDepartementList();

    return Scaffold(
      body: StreamBuilder(
        stream: departementBloc.departementList,
        builder: (context, AsyncSnapshot<List<DepartementModel>> snapshot) {
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

  Widget buildHome(List<DepartementModel> departements, BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildDropdown(departements, context),
                getSizedBox(height: 3),
                Departement(),
                getSizedBox(height: 3),
                Image.asset('assets/departement.png', height: 200,),
              ],
            ),
          ),
        )
    );
  }
  
  Widget buildDropdown(List<DepartementModel> departements, BuildContext context) {
    return StreamBuilder(
      stream: departementBloc.selectedDepartement,
      builder: (context, AsyncSnapshot<DepartementModel> snapshot) {
        return DropdownButton<String>(
          value: snapshot.data == null ? departements[0].number : snapshot.data!.number,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            departementBloc.setSelectedDepartement(newValue!);
          },
          items: departements
              .map<DropdownMenuItem<String>>((DepartementModel value) {
            return DropdownMenuItem<String>(
              value: value.number,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: getIncidenceColor(value.stats!.incidence),
                          shape: BoxShape.circle,
                        ),
                      ),
                      getSizedBox(width: 1),
                      Text('${value.number} - ${value.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontStyle: FontStyle.normal)),
                    ],
                  ),
                  Text(value.region, style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            );
          }).toList(),
        );
      }
    );
  }
}