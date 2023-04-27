import 'package:flutter/material.dart';
import '../../shared/components/components.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:20,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text('Dashboard',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 24),),
            const    SizedBox(height: 20),
            itemOfDashboard(
                const Color.fromRGBO(146, 218, 201, 1),
                'Add Course',
              context

            ),

          ],
        ),
      ),
    );
  }
}
