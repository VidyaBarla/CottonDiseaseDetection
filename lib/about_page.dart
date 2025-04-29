import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF0), // Changed to pure white
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "About Us!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 300.w,
                            child: Text(
                              "CottonShield is an innovative mobile application to assist farmers and agricultural experts in detecting diseases in cotton crops. "
                              "To ensure accessibility, CottonShield supports multiple languages and operates efficiently even in areas with limited internet connectivity.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: 300.w,
                            child: Text(
                              "This project, undertaken by Vidya Barla, Arshiya Gedam, Somya Singh, and Navya Supriyan, is our final-year research effort aimed at addressing the impact of cotton diseases on crop yield and farmers' livelihoods. "
                              "Leveraging AI in agriculture, we developed this app to bridge the gap between traditional farming practices and modern AI solutions, providing an efficient, cost-effective, and user-friendly tool for cotton disease detection.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri feedbackUrl = Uri.parse("https://forms.gle/reTV5T2TsbNMSazJ9");
                  if (await canLaunchUrl(feedbackUrl)) {
                    await launchUrl(feedbackUrl, mode: LaunchMode.externalApplication);
                  } else {
                    throw "Could not launch $feedbackUrl";
                  }
                },
                icon: const Icon(Icons.feedback, color: Colors.white),
                label: Text(
                  "Give Feedback",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}