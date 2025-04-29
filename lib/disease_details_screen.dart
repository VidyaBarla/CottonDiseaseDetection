// 📁 disease_details_screen.dart
import 'package:flutter/material.dart';

/// 🦠 Disease Details Data including Remedies & Preventions
final Map<String, Map<String, Map<String, String>>> diseaseDetails = {
  "Bacterial Blight": {
    "English": {
      "symptoms": "- Caused by Xanthomonas citri pv. malvacearum bacteria.\n- Spreads through infected seeds, rain splashes, irrigation water, and farm tools.\n- Hot & humid conditions (25-30°C) favor its growth.",
      "remedy": "- Apply copper-based bactericides during early infection stages.\n- Use disease-free certified seeds.\n- Avoid overhead irrigation to reduce leaf wetness.",
      "prevention": "- Rotate crops with non-host plants (e.g., cereals, legumes).\n- Maintain proper field hygiene and remove infected plant debris.\n- Ensure balanced fertilization to strengthen plant immunity.",
    },
    "Hindi": {
      "symptoms": "- यह रोग Xanthomonas citri pv. malvacearum बैक्टीरिया से होता है।\n- संक्रमित बीज, वर्षा की बूंदें, सिंचाई का पानी और उपकरणों से फैलता है।\n- गर्म और आर्द्र वातावरण (25-30°C) इसके लिए अनुकूल होता है।",
      "remedy": "- प्रारंभिक अवस्था में कॉपर-आधारित बैक्टीरिसाइड का छिड़काव करें।\n- रोग-मुक्त प्रमाणित बीजों का उपयोग करें।\n- पत्तों को गीला करने से बचने के लिए ऊपर से सिंचाई न करें।",
      "prevention": "- गैर-पोषक फसलों (जैसे अनाज, दलहन) के साथ फसल चक्र अपनाएं।\n- खेत की स्वच्छता बनाए रखें और संक्रमित पौधों को हटा दें।\n- संतुलित उर्वरक का उपयोग करें।",
    },
    "Telugu": {
      "symptoms": "- Xanthomonas citri pv. malvacearum అనే బ్యాక్టీరియావల్ల కలుగుతుంది.\n- విత్తనాలు, వర్షపు నీరు, పరికరాల ద్వారా వ్యాపిస్తుంది.\n- వేడిగా, తేమగా (25-30°C) వాతావరణం వ్యాధి పెరుగుదలకు అనుకూలం.",
      "remedy": "- ప్రారంభ దశలో కాపర్ ఆధారిత బ్యాక్టీరీసైడ్‌ను వాడండి.\n- వ్యాధి రహిత ధృవీకరించిన విత్తనాలను ఉపయోగించండి.\n- ఆకులను తడిపే రకమైన నీటిపారుదల నివారించండి.",
      "prevention": "- ధాన్యం, పప్పుధాన్యాలు వంటి నాన్-హోస్ట్ పంటలతో పంటల మార్పిడి చేయండి.\n- పొలాలను శుభ్రంగా ఉంచండి మరియు దెబ్బతిన్న మొక్కలను తొలగించండి.\n- మొక్కల రోగ నిరోధకత కోసం సమతుల్య ఎరువులు వాడండి.",
    },
    "Marathi": {
      "symptoms": "- Xanthomonas citri pv. malvacearum जीवाणूमुळे होते.\n- संक्रमित बियाणे, पावसाचे थेंब, पाणी व शेती साधनांद्वारे पसरते.\n- उष्ण व दमट हवामान (25-30°C) रोगास पोषक असते.",
      "remedy": "- सुरुवातीच्या अवस्थेत तांबेयुक्त जीवाणुनाशक फवारणी करा.\n- रोगमुक्त प्रमाणित बियाण्यांचा वापर करा.\n- पानं ओलसर होणार नाही याची काळजी घ्या (उदकसिंचन टाळा).",
      "prevention": "- धान्य, कडधान्ये अशा नॉन-होस्ट पिकांशी पीक फेरपालट करा.\n- शेतात स्वच्छता ठेवा आणि संक्रमित झाडे काढा.\n- संतुलित खतांचा वापर करा.",
    },
  },

  "Fusarium Wilt": {
    "English": {
      "symptoms": "- Caused by Fusarium oxysporum fungus, a soil-borne pathogen.\n- Enters plants through roots, spreading via infected soil.\n- Warm temperatures (28-32°C) & poor drainage worsen infection.",
      "remedy": "- Apply fungicides like Carbendazim or Thiophanate-methyl to affected areas.\n- Use soil solarization techniques to reduce fungal spores.\n- Improve soil drainage and avoid overwatering.",
      "prevention": "- Use resistant cotton varieties when available.\n- Rotate with non-host crops to reduce pathogen buildup.\n- Avoid planting in poorly drained soils.",
    },
    "Hindi": {
      "symptoms": "- Fusarium oxysporum नामक कवक से होता है जो मिट्टी में पाया जाता है।\n- जड़ों के माध्यम से पौधों में प्रवेश करता है और संक्रमित मिट्टी से फैलता है।\n- गर्म तापमान (28-32°C) और खराब जल निकासी से स्थिति खराब होती है।",
      "remedy": "- प्रभावित क्षेत्रों में Carbendazim या Thiophanate-methyl जैसे फफूंदनाशकों का प्रयोग करें।\n- फंगल बीजाणुओं को कम करने के लिए सोलराइजेशन तकनीक अपनाएं।\n- मिट्टी की जल निकासी में सुधार करें और अधिक पानी देने से बचें।",
      "prevention": "- जब भी संभव हो रोग-प्रतिरोधी कपास किस्मों का उपयोग करें।\n- रोगाणु संचय को कम करने के लिए फसल चक्र अपनाएं।\n- जल जमाव वाली भूमि पर रोपण न करें।",
    },
    "Telugu": {
      "symptoms": "- Fusarium oxysporum అనే ముప్పు కారక శిలీంధ్రం వల్ల కలుగుతుంది.\n- మొక్కల రూట్ల ద్వారా ప్రవేశించి, పాడైన మట్టిలో వ్యాప్తి చెందుతుంది.\n- వేడి వాతావరణం (28-32°C), చెడు నీటి పారుదల వ్యాధిని పెంచుతుంది.",
      "remedy": "- Carbendazim లేదా Thiophanate-methyl వంటి ఫంగిసైడ్‌లను ఉపయోగించండి.\n- సాలరైజేషన్ ద్వారా మన్నెంలో ఫంగస్‌ను తగ్గించండి.\n- నీటి పారుదల మెరుగుపరచండి, ఎక్కువ నీరు పోయడం నివారించండి.",
      "prevention": "- సహనశీలమైన కాటన్ వేరైటీలను వాడండి.\n- ఫంగస్ వ్యాప్తి తగ్గించేందుకు పంటల మార్పిడి చేయండి.\n- నీరు నిలిచే భూముల్లో నాటడం మానండి.",
    },
    "Marathi": {
      "symptoms": "- Fusarium oxysporum या बुरशीमुळे होते.\n- मुळांद्वारे झाडात प्रवेश करते आणि संक्रमित मातीने पसरते.\n- उष्ण हवामान (28-32°C) व कमी निचरा संसर्ग वाढवतो.",
      "remedy": "- Carbendazim किंवा Thiophanate-methyl फवारणी करा.\n- जमिनीची सोलरायझेशन पद्धती वापरा.\n- निचरा सुधारवा व जास्त पाणी देणे टाळा.",
      "prevention": "- रोगप्रतिकारक कपाशी वाण वापरा.\n- रोगकारकाचा साठा कमी करण्यासाठी पीक फेरपालट करा.\n- निचरा नसलेल्या जमिनीत कपाशी पेरा टाळा.",
    },
  },

  "Curl Virus": {
    "English": {
      "symptoms": "- Upward curling of leaves, giving a wrinkled appearance.\n- Dark green, swollen veins & thickening of leaf edges.\n- Poor flowering & underdeveloped bolls.",
      "remedy": "- Apply insecticides to control whitefly populations.\n- Remove and destroy infected plants to prevent the spread.\n- Use virus-free seeds and resistant varieties.",
      "prevention": "- Maintain proper plant spacing to reduce whitefly habitat.\n- Implement integrated pest management (IPM) strategies.\n- Avoid planting during peak whitefly season.",
    },
    "Hindi": {
      "symptoms": "- पत्तों का ऊपर की ओर मुड़ना जिससे झुर्रीदार रूप दिखाई देता है।\n- गहरे हरे रंग की नसें और पत्तों के किनारों का मोटा होना।\n- फूल कम लगते हैं और बॉल्स पूरी तरह विकसित नहीं होते।",
      "remedy": "- सफेद मक्खियों को नियंत्रित करने के लिए कीटनाशकों का प्रयोग करें।\n- संक्रमित पौधों को हटाकर नष्ट करें।\n- वायरस-रहित बीज और रोग-प्रतिरोधी किस्मों का उपयोग करें।",
      "prevention": "- पौधों के बीच उचित दूरी बनाए रखें।\n- समन्वित कीट प्रबंधन (IPM) रणनीति अपनाएं।\n- सफेद मक्खियों के प्रकोप के समय बुवाई से बचें।",
    },
    "Telugu": {
      "symptoms": "- ఆకులు పైకి ముడుచుకొని నామమాత్రంగా ముడతలు వస్తాయి.\n- ఆకుల మీద నలుపు పచ్చటి ఊబైన నరాలు, దప్పికతో కూడిన అంచులు కనిపిస్తాయి.\n- పుష్పీకరణ బాగా జరగదు, బోల్స్ చిన్నగా ఉంటాయి.",
      "remedy": "- తెల్లదద్దుర్ల నియంత్రణకు కీటకనాశకాలు వాడండి.\n- వైరస్ సోకిన మొక్కలను తొలగించి నాశనం చేయండి.\n- వైరస్-రహిత విత్తనాలు, సహనశీల రకాలు వాడండి.",
      "prevention": "- మొక్కలకు సరిపడా దూరం పెట్టండి.\n- సమగ్ర పురుగుల నిర్వహణ (IPM) చర్యలు తీసుకోండి.\n- తెల్లదద్దుర్ల ఉధృత కాలంలో సాగు నివారించండి.",
    },
    "Marathi": {
      "symptoms": "- पानं वर वळतात आणि त्यांना सुरकुतलेले स्वरूप येते.\n- गडद हिरव्या शिरा व पानाच्या कडा जाडसर होतात.\n- फुलं कमी येतात व बोंडं नीट विकसित होत नाहीत.",
      "remedy": "- पांढऱ्या माशांचा नाश करण्यासाठी कीटकनाशक वापरा.\n- संक्रमित झाडं काढून नष्ट करा.\n- रोगमुक्त बियाणे व प्रतिकारक वाण वापरा.",
      "prevention": "- झाडांमध्ये योग्य अंतर ठेवा.\n- समन्वित कीटक व्यवस्थापन (IPM) वापरा.\n- पांढऱ्या माशांचा हंगाम टाळून लागवड करा.",
    },
  },
};


/// 📋 Detailed Disease Information Screen
class DiseaseDetailsScreen extends StatelessWidget {
  final String diseaseName;
  final String languageCode;

  const DiseaseDetailsScreen({super.key, required this.diseaseName, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    // Ensure that 'languages' and the selected language are handled properly.
    final diseaseInfo = diseaseDetails[diseaseName];
    final languageInfo = diseaseInfo?[languageCode];

    if (diseaseInfo == null || languageInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Disease Details"),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text("No information available for this disease."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(diseaseName),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🌿 Disease Name Header
              Text(
                diseaseName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              _buildSection("Symptoms", languageInfo['symptoms'] ?? "No symptoms available."),
              _buildSection("Remedies", languageInfo['remedy'] ?? "No remedy available."),
              _buildSection("Preventions", languageInfo['prevention'] ?? "No prevention available."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
