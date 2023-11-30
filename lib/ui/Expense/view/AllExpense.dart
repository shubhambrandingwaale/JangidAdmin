import 'package:attendance_admin/Cards/ExpenseCard.dart';
import 'package:attendance_admin/Components/MainComponents.dart';
import 'package:attendance_admin/ui/Expense/controller/ExpenseRepository.dart';
import 'package:attendance_admin/utility/MyStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListController extends StatelessWidget {
  ExpenseListController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ExpenseRepository(),
      child: Consumer(
        builder: (context, ExpenseRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return AllExpense();
            case Status.Unauthenticated:
              return AllExpense();
            case Status.Authenticating:
              return AllExpense();
            case Status.Authenticated:
              return AllExpense();
            case Status.error:
              return AllExpense();
          }
        },
      ),
    );
  }
}

class AllExpense extends StatefulWidget {
  const AllExpense({super.key});

  @override
  State<AllExpense> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final auth = context.read<ExpenseRepository>();
      auth.getExpenseList(context);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<ExpenseRepository>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainComponents().wallet_back("back", "987124", context),
                // MainComponents().txtview14("All Expense this month"),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: auth.expenseList.length,
                //   itemBuilder: (BuildContext context, index) {
                //     return GestureDetector(
                //       onTap: () {},
                //       child: ExpenseCard(expenseList:auth.expenseList[index]),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
