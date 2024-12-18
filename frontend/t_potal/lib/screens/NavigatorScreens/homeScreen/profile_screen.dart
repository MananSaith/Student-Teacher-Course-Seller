import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_potal/screens/Registration/login_screen.dart';

import '../../../constant/colorclass.dart';
import '../../../constant/font_weight.dart';
import '../../../constant/string_constant.dart';
import '../../../controllers/techerDataFromNode/teacherInfo/teacher_crud.dart';
import '../../../widegts/custum_button.dart';
import '../../../widegts/textwidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    await teacherCrudController.getUserById(uid: currentUser!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final teacher = teacherCrudController.selectedTeacher.value;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        centerTitle: true,
        title: TextWidget(
          text: MyText.teacherProfile,
          fSize: 25,
          fWeight: MyFontWeight.medium,
          textColor: MyColors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Photo
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(currentUser!.photoURL.toString()),
                backgroundColor: MyColors.secondaryPallet,
              ),
              SizedBox(height: height * 0.025),

              // Profile Information
              ProfileInfoTile(
                title: "Name",
                value: teacher?.name ?? "N/A",
                icon: Icons.person,
              ),
              ProfileInfoTile(
                title: "MCID",
                value: teacher?.mcid ?? "N/A",
                icon: Icons.account_circle_outlined,
              ),
              ProfileInfoTile(
                title: "Email",
                value: teacher?.email ?? "N/A",
                icon: Icons.email_outlined,
              ),
              ProfileInfoTile(
                title: "Verified",
                value: teacher?.verify == true ? "Yes" : "No",
                icon: Icons.verified_outlined,
                valueColor: teacher?.verify == true ? Colors.green : Colors.red,
              ),

              SizedBox(height: height * 0.05),

              // Logout Button
              CustomElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() =>
                      const LoginScreen()); // Navigate to login screen after logout
                },
                text: "Logout",
                padding: const EdgeInsets.all(16),
                endIcon: Icons.logout,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Profile Info Tile for better UI
class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColors.bgPallet,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: MyColors.secondaryPallet, size: 30),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fSize: 14,
                  fWeight: MyFontWeight.bold,
                  textColor: Colors.grey,
                ),
                TextWidget(
                  text: value,
                  fSize: 16,
                  fWeight: MyFontWeight.medium,
                  textColor: valueColor ?? MyColors.primaryPallet,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
