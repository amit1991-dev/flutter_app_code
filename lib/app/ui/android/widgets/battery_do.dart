


import 'package:flutter/material.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:getx/app/data/constants/miscellaneous.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';


class DisableBO extends StatefulWidget {
  const DisableBO({super.key});

  @override
   State<DisableBO> createState() => _MyState();
}

class _MyState extends State<DisableBO> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: appColors["background"]!,
          extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   title: const Text('Disable Battery Optimizations'),
        //   backgroundColor: appColors["green"]!,
            
        // ),
        body: SafeArea(
          child:
           Column(
          
            children:[
           headerBar("Disable Battery \nOptimizations",parent:true,),
              const SizedBox(height: 300),
              ElevatedButton(
                 style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => appColors["purple-dark"]!),
                ),
                  child: const Text("Disable Battery Optimizations",
                  
                  style: TextStyle(color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,),
                  ),
               
                  onPressed: () {
                    DisableBatteryOptimization
                        .showDisableBatteryOptimizationSettings();
                        
                  }),
            ],
          ),
        
    ),
    );
  }
}