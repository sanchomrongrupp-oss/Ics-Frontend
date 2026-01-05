import 'package:flutter/material.dart';
import 'package:ics_frontend/Moon/switchmode.dart';
import 'package:ics_frontend/View/Dashboard_Main_Conten/dash_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDark = false;
  final ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Builder(builder: (context) {
       final _ = Theme.of(context);
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
            children: [
              Card(
                color: Colors.white,
                child:SizedBox(
                  width: 300,
                  height: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text("Inventory", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,color: Colors.red),),
                      Text("Control System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                      const SizedBox(height: 50),
                      customListTile(icon: Image.asset('icons/dashboard.png',height: 32,width: 32), title: 'Dashboard', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/inventorys.png',height: 32,width: 32), title: 'Inventory', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/office.png',height: 32,width: 32), title: 'Office', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/brands.png',height: 32,width: 32), title: 'Brands', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/towuser.png',height: 32,width: 32), title: 'Employees', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/finances.png',height: 32,width: 32), title: 'Finances', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/sale.png',height: 32,width: 32), title: 'Sale', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/layer.png',height: 32,width: 32), title: 'New Collections', onTap: () {}),
                      SizedBox(height: 10),
                      customListTile(icon: Image.asset('icons/settings.png',height: 32,width: 32), title: 'Settings', onTap: () {}),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CustomLightModeSwitch(
                          isDarkMode: _isDark,
                          onChanged: (val) {
                            setState(() {
                              _isDark = val;
                            });
                          },
                        )
                      ),
                      // Add more navigation items here
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Boder on circle avatar
                                Container(
                                  padding: const EdgeInsets.all(2), // border thickness
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage('icons/dog.png'),
                                  ),
                                ),
                    
                                const SizedBox(width: 50),
                                // Notification Bell with Red Dot
                                customIconButton(
                                  onPressed: (){
                    
                                  }, 
                                  icon: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image.asset(
                                        'icons/bell.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    
                                const SizedBox(width: 50),
                                // Message Icon with Red Dot
                                customIconButton(
                                  onPressed: (){
                    
                                  }, 
                                  icon: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image.asset(
                                        'icons/message.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    
                                SizedBox(width: 50),
                                // Document Icon
                                customIconButton(
                                  onPressed: (){
                    
                                  }, 
                                  icon: Image.asset(
                                    'icons/document.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                    
                                SizedBox(width: 50),
                                // Calendar Icon
                                customIconButton(
                                  onPressed: (){
                    
                                  }, 
                                  icon: Image.asset(
                                    'icons/calendar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                    
                                SizedBox(width: 50),
                                // Search TextField
                                Expanded(
                                  child: searchTextField(),
                                ),
                    
                                SizedBox(width: 50),
                                // Logout Button
                                customIconButton(
                                  onPressed: (){
                    
                                  }, 
                                  icon: Image.asset(
                                    'icons/logout.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          // _buildLabel(context),
                          const SizedBox(height: 12),
                          Expanded(
                            child: DashContent(),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ); }),
    );
  }


  //listTile Widget
  Widget customListTile({required Widget icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap,
    );
  }

  // Custom Icon Button Widget
  Widget customIconButton({required VoidCallback onPressed, required Widget icon}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }

  //Textfield Search
  Widget searchTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

}
