import 'package:flutter/material.dart';

/// 🦠 Disease Information Model
class DiseaseInfo {
  final String name;
  final String causes;
  final String symptoms;
  final String impact;

  DiseaseInfo({
    required this.name,
    required this.causes,
    required this.symptoms,
    required this.impact,
  });
}

/// 📝 Disease Data
final Map<String, DiseaseInfo> diseaseData = {
  "Bacterial Blight": DiseaseInfo(
    name: "Bacterial Blight",
    causes: '''
- 🦠 Caused by Xanthomonas citri pv. malvacearum bacteria.
- 🌧 Spreads through infected seeds, rain splashes, irrigation water, and farm tools.
- ☀ Hot & humid conditions (25-30°C) favor its growth.
    ''',
    symptoms: '''
- 🍂 Water-soaked leaf spots turning brown and angular.
- 🌿 Black streaks on stems, weakening the plant.
- 🌾 Bolls crack open before maturity, reducing fiber quality.
    ''',
    impact: '''
- 📉 30-35% yield loss in India, up to 80% in severe cases.
- 💸 Reduces fiber quality, lowering market value.
- 🚜 Farmers face high costs due to increased pesticide use.
    ''',
  ),
  "Fusarium Wilt": DiseaseInfo(
    name: "Fusarium Wilt",
    causes: '''
- 🍄 Caused by Fusarium oxysporum fungus, a soil-borne pathogen.
- 🌱 Enters plants through roots, spreading via infected soil.
- 🔥 Warm temperatures (28-32°C) & poor drainage worsen infection.
    ''',
    symptoms: '''
- 🌿 Yellowing and wilting of lower leaves.
- 🏺 Brown discoloration in vascular tissues when stem is cut.
- 🥀 Stunted growth & premature leaf drop.
    ''',
    impact: '''
- 📉 25-50% yield loss in affected fields.
- 🌍 Stays in soil for years, making future crops vulnerable.
- 💰 Increased cost for fungicides and soil treatment.
    ''',
  ),
  "Curl Virus": DiseaseInfo(
    name: "Cotton Curl Virus (CLCuD)",
    causes: '''
- 🦠 Caused by Begomoviruses, spread by whiteflies (Bemisia tabaci).
- ☀ High temperatures (30-35°C) & dense planting attract whiteflies.
    ''',
    symptoms: '''
- 🍃 Upward curling of leaves, giving a wrinkled appearance.
- 🌿 Dark green, swollen veins & thickening of leaf edges.
- 🌾 Poor flowering & underdeveloped bolls.
    ''',
    impact: '''
- 📉 30-40% yield loss in severe outbreaks.
- 💵 Increased pesticide use raises production costs.
- 🚜 Stunted plant growth & fewer harvestable bolls.
    ''',
  ),
};

/// 📝 Disease Information Display Screen
class DiseaseInfoScreen extends StatelessWidget {
  final String diseaseName;

  const DiseaseInfoScreen({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    final DiseaseInfo? info = diseaseData[diseaseName];

    if (info == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Disease Information")),
        body: const Center(child: Text("No information available for this disease.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(info.name),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🏷 Disease Name Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        info.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      const Divider(color: Colors.green),
                      const SizedBox(height: 10),
                      const Icon(Icons.local_florist, color: Colors.green, size: 50),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 📑 Detailed Sections
              _buildSection("🌱 Causes", info.causes),
              _buildSection("🔍 Symptoms", info.symptoms),
              _buildSection("📉 Impact on Crop & Farmers", info.impact),
            ],
          ),
        ),
      ),
    );
  }

  /// 📑 Section Builder Widget
  Widget _buildSection(String title, String content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green.shade700),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}