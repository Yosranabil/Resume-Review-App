import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:resume_viewer/config/constants.dart';
import '../customWidgets/info_card_widget.dart';
import '../models/resume.dart';
import '../services/resume_load.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  Resume? resume;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }
    const githubUrl = Constants.githubUrl;
    try {
      final loaded = await ResumeLoad.loadResume(githubUrl);
      if (!mounted) return;
      setState(() {
        resume = loaded;
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if (resume == null) {
      return Scaffold(
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.black,)
              : ElevatedButton(
                  onPressed: loadData,
                  child: const Text("Load Resume"),
                ),
        ),
      );
    }

    final resumeData = resume!;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          final isMobile = maxWidth < 600;
          final isTablet = maxWidth >= 600 && maxWidth < 1000;

          final shortestSide = MediaQuery.of(context).size.shortestSide;

          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: _downloadJsonFile,
                      ),
                      IconButton(
                        icon: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                              )
                            : const Icon(Icons.refresh_outlined),
                        onPressed: _isLoading ? null : () async => loadData(),
                      ),
                    ],
                  ),
                ),
                Stack(                              // Personal Info Card
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: maxWidth * 0.9,
                      margin: EdgeInsets.only(top: maxHeight * 0.09),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(     //To handle different screen sizes
                            height: isMobile? shortestSide * 0.20
                                : isTablet? shortestSide * 0.35  
                                    : shortestSide * 0.25,
                          ),
                          Text(resumeData.basics.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(resumeData.basics.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                          Text(resumeData.basics.phone, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
                        ],
                      )
                    ),
                    Positioned(
                      top: 0,
                      child: CircleAvatar(
                        radius: isMobile ? maxWidth * 0.18 : maxWidth * 0.10,
                        backgroundImage: AssetImage('assets/profile_photo.jpg'),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ],
                ),
                ResumeInfoCard(                            //Email Card
                  width: maxWidth * 0.9, 
                  backColor: Colors.blueAccent,
                  headerIcon: const Icon(Icons.email_outlined, size: 50, color: Colors.white,),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.launch_rounded, color: Colors.white,),
                  ),
                  title: Text(
                    "Email",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      resumeData.basics.email,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: [
                    ResumeInfoCard(                           //LinkedIn Card
                      width: isMobile ? maxWidth * 0.42 : maxWidth * 0.44,
                      backColor: Colors.blueGrey,
                      headerIcon: const Icon(Icons.link_rounded, size: 40, color: Colors.white,),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.launch_rounded, color: Colors.white,),
                      ),
                      title: Text('LinkedIn', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
                      children: [
                        const SizedBox(height: 8),
                        Text('@yosranabil', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                    ResumeInfoCard(                           //Github Card
                      width: isMobile ? maxWidth * 0.42 : maxWidth * 0.44,
                      backColor: Colors.black87,
                      headerIcon: const Icon(Icons.code_rounded, size: 40, color: Colors.white,),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.launch_rounded, color: Colors.white,),
                      ),
                      title: Text('GitHub', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
                      children: [
                        const SizedBox(height: 8),
                        Text('@Yosranabil', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                ResumeInfoCard(              // Extracurricular Activities Card
                  width: maxWidth * 0.9, 
                  headerIcon: const Icon(Icons.event_available_outlined, size: 40),
                  title: Text('Extracurricular Activities', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
                  children: [
                    const SizedBox(height: 16,),
                    ..._buildVolunteerItems(resumeData),
                  ],
                ),
                ResumeInfoCard(                       //Projects Card
                  width: maxWidth * 0.9, 
                  headerIcon: const Icon(Icons.dashboard_customize_outlined, size: 40),
                  title: Text('Projects', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
                  children: [
                    const SizedBox(height: 16,),
                    ..._buildProjectItems(resumeData),
                  ],
                ),
                ResumeInfoCard(                           //Skills Card
                  width: maxWidth * 0.9,
                  headerIcon: const Icon(Icons.psychology_outlined, size: 40),
                  title: Text('Skills', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
                  children: [
                    const SizedBox(height: 16,),
                    ..._buildSkillItems(resumeData),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        );
      }
    ),
  ),
);
}

  List<Widget> _buildVolunteerItems(Resume resumeData) {

    return resumeData.volunteer
        .map((vol) => _buildBulletItem(vol.organization, vol.summary))
        .toList();
  }

  List<Widget> _buildProjectItems(Resume resumeData) {

    return resumeData.projects
        .map((project) => _buildBulletItem(project.name, project.summary))
        .toList();
  }

  List<Widget> _buildSkillItems(Resume resumeData) {

    return resumeData.skills
        .map(
          (skill) => _buildBulletItem(
            skill.name,
            skill.keywords.join(', '),
          ),
        )
        .toList();
  }

  Widget _buildBulletItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


Future<void> _downloadJsonFile() async {
  try {
    final response = await http.get(Uri.parse(Constants.githubUrl));
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
      
      final directory = await getDownloadsDirectory();
      if (directory == null) return;
      
      final file = File('${directory.path}/resume_data.txt');
      await file.writeAsString(jsonString);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloaded as text file to: ${file.path}')),
        );
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Download failed')),
      );
    }
  }
}
}