import 'package:attendance_admin/Components/Colors.dart';
import 'package:attendance_admin/Components/Image.dart';
import 'package:attendance_admin/Models/Controller.dart';
import 'package:flutter/material.dart';

import '../Components/MainComponents.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
   String Choosevalue = 'Employee1';
   final li = [
    'Employee1',
    'Employee2',
    'Employee3',
    'Employee4',

  ];
   String Choosevaluepurpose = 'purpose1';
   final purpose = [
    'purpose1',
    'purpose2',
    'purpose3',
    'purpose4',

  ];
  String Choosevaluesupervisor = 'supervisor1';
   final supervisor = [
    'supervisor1',
    'supervisor2',
    'supervisor3',
    'supervisor4',

  ];
  String Choosevaluesite = 'Site1';
   final Site = [
    'Site1',
    'Site2',
    'Site3',
    'Site4',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              MainComponents().wallet_back("back", "Logout", context),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: MainComponents().txtview18("Add Expense")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainComponents().Textfields("Amount", Amount, "Enter Amount", Icons.attach_money_outlined,TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                
                           
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: Choosevaluepurpose,
                     borderRadius: BorderRadius.circular(10),
                      hint: MainComponents().txtview14("Select Purpose"),
                      isExpanded: true,
                            items: purpose.map(
                              (e){
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e));
                              }
                             ).toList(),
                              onChanged: (value) { 
                              setState(() {
                                Choosevalue = value.toString();
                              });
                             },
                            ),
                  )
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(           
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: Choosevaluesupervisor,
                     borderRadius: BorderRadius.circular(10),
                      hint: MainComponents().txtview14("Select Purpose"),
                      isExpanded: true,
                            items: supervisor.map(
                              (e){
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e));
                              }
                             ).toList(),
                              onChanged: (value) { 
                              setState(() {
                                Choosevalue = value.toString();
                              });
                             },
                            ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(           
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: Choosevaluesite,
                     borderRadius: BorderRadius.circular(10),
                      hint: MainComponents().txtview14("Select Purpose"),
                      isExpanded: true,
                            items: Site.map(
                              (e){
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e));
                              }
                             ).toList(),
                              onChanged: (value) { 
                              setState(() {
                                Choosevalue = value.toString();
                              });
                             },
                            ),
                  )
                ),
              ),


              MainComponents().Button("Add Expense", () => null, blue)
             
              
            ],
          ),
        ),
      ),
    );
  }
}