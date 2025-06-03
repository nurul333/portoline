import 'role_selection_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Tambahkan di atas
import 'training_checkout_page.dart';

class JobSeekerDashboard extends StatefulWidget {
  const JobSeekerDashboard({super.key});

  @override
  State<JobSeekerDashboard> createState() => _JobSeekerDashboardState();
}

class _JobSeekerDashboardState extends State<JobSeekerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const JobHomePage(),
    const TrainingPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        title: Image.asset('assets/logo.png', height: 60),
        centerTitle: true,
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(247, 243, 243, 1),
        selectedItemColor: const Color.fromARGB(179, 3, 3, 3),
        unselectedItemColor: const Color.fromARGB(179, 3, 3, 3),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Pelatihan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class JobHomePage extends StatelessWidget {
  const JobHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> jobs = [
      {
        'image': 'assets/barista.png',
        'title': 'Barista Training',
        'company': 'Kopi Dalan',
        'description':
            'Pelatihan barista profesional. Usia 18-25 tahun, min. SMA. Gaji 3-4jt/bulan.',
      },
      {
        'image': 'assets/steward.png',
        'title': 'Steward Training',
        'company': 'KopiKita',
        'description':
            'Pelatihan dapur. Usia 20-30 tahun, jujur dan disiplin. Gaji 2-3jt/bulan.',
      },
      {
        'image': 'assets/kasir-restoran.png',
        'title': 'Cashier Training',
        'company': 'Fore',
        'description':
            'Pelatihan kasir POS. Usia 19-27 tahun. Pengalaman lebih disukai.',
      },
      {
        'image': 'assets/memasaak2.png',
        'title': 'Kitchen Training',
        'company': '224 Cafe',
        'description':
            'Pelatihan dapur. Usia 18-28 tahun. Gaji 1,2-2,5jt/bulan.',
      },
      {
        'image': 'assets/barista1.png',
        'title': 'Junior Barista',
        'company': 'Warung Kopi',
        'description':
            'Belajar skill dasar barista. Cocok untuk pemula yang ingin bekerja di kafe.',
      },
      {
        'image': 'assets/steward.png',
        'title': 'Kitchen Helper',
        'company': 'Cafe Hijau',
        'description':
            'Membantu persiapan makanan. Tidak perlu pengalaman. Usia 18-30 tahun.',
      },
      {
        'image': 'assets/kasir-restoran.png',
        'title': 'Cashier',
        'company': 'Roti Bakar 88',
        'description':
            'Pelatihan kerja kasir malam hari. Cocok untuk mahasiswa.',
      },
      {
        'image': 'assets/memasak.png',
        'title': 'Commis 1',
        'company': 'Dapoer Kita',
        'description':
            'Pelatihan cook helper. Praktek langsung di dapur profesional.',
      },
      {
        'image': 'assets/barista.png',
        'title': 'Barista Part-time',
        'company': 'Kopi Seduh',
        'description':
            'Shift malam 4 jam. Untuk mahasiswa yang ingin kerja sambilan.',
      },
      {
        'image': 'assets/dishwasher.png',
        'title': 'Dishwasher',
        'company': 'Kantin Sehat',
        'description': 'Cuci alat dapur dan jaga kebersihan area kitchen.',
      },
      {
        'image': 'assets/kasir-restoran.png',
        'title': 'Admin Kasir',
        'company': 'Restoku',
        'description':
            'Mengelola laporan dan transaksi kasir. Diperlukan skill Excel.',
      },
      {
        'image': 'assets/memasak.png',
        'title': 'Cook Helper',
        'company': 'Cafe 88',
        'description':
            'Membantu koki dalam menyiapkan bahan masakan dan plating.',
      },
    ];

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'LOOKING FOR JOB?',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Barista, F&B.',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2 / 3,
            children:
                jobs.map((job) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => JobDetailPage(
                                image: job['image']!,
                                title: job['title']!,
                                company: job['company']!,
                                description: job['description']!,
                              ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.asset(
                                job['image']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job['title']!,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    job['company']!,
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    job['description']!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class TrainingItem {
  final String image;
  final String title;
  final String price;
  final String description;

  TrainingItem({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  });
}

final List<TrainingItem> trainingItems = [
  TrainingItem(
    image: 'assets/medsos.png',
    title: 'Pelatihan Kelola Media Sosial',
    price: 'Rp 300.000',
    description:
        'Pelajari strategi dan tools untuk mengelola media sosial secara profesional.',
  ),
  TrainingItem(
    image: 'assets/keuangan.png',
    title: 'Pelatihan Perencanaan Keuangan',
    price: 'Rp 400.000',
    description:
        'Belajar cara mengatur keuangan pribadi dan bisnis kecil dengan tepat.',
  ),
  TrainingItem(
    image: 'assets/editing.png',
    title: 'Pelatihan Editing Video',
    price: 'Rp 350.000',
    description:
        'Menguasai teknik dasar hingga mahir dalam editing video menggunakan software populer.',
  ),
  TrainingItem(
    image: 'assets/speaking.png',
    title: 'Pelatihan Public Speaking',
    price: 'Rp 450.000',
    description:
        'Tingkatkan kepercayaan diri dan keterampilan berbicara di depan umum.',
  ),
];

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'LOOKING FOR PELATIHAN',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: List.generate(trainingItems.length, (index) {
              final item = trainingItems[index];
              return JobCard(
                image: item.image,
                title: item.title,
                company: item.price,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrainingDetailPage(training: item),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

class JobCard extends StatelessWidget {
  final String image;
  final String title;
  final String company;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.image,
    required this.title,
    required this.company,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'by $company',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainingDetailPage extends StatelessWidget {
  final TrainingItem training;

  const TrainingDetailPage({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(training.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                training.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              training.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Harga: ${training.price}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi pelatihan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(training.description),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrainingCheckoutPage(training: training),
                  ),
                );
              },
              child: const Text('Beli Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}

// 🆕 Halaman Detail
class JobDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String company;
  final String description;

  const JobDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.company,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Job Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Company: $company', style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi pekerjaan:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? profileImageBytes;
  List<Uint8List> certificateBytes = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();

  String? userId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchProfile();
  }

  Future<void> loadUserIdAndFetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');

    if (userId != null) {
      fetchProfile();
    } else {
      // Opsional: tampilkan error atau redirect ke login
      print("User ID tidak ditemukan.");
    }
  }

  Future<void> fetchProfile() async {
    setState(() => _isLoading = true);

    final url = Uri.parse(
      'http://192.168.56.1/proyek2_mobile/portoline/get_profile.php?user_id=$userId',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        setState(() {
          nameController.text = result['data']['name'] ?? '';
          emailController.text = result['data']['email'] ?? '';
          dobController.text = result['data']['dob'] ?? '';
          hobbyController.text = result['data']['hobby'] ?? '';

          if (result['data']['profile_image_base64'] != null &&
              result['data']['profile_image_base64'].isNotEmpty) {
            profileImageBytes = base64Decode(
              result['data']['profile_image_base64'],
            );
          }

          if (result['data']['certificates_base64'] != null &&
              result['data']['certificates_base64'].isNotEmpty) {
            List certs = jsonDecode(result['data']['certificates_base64']);
            certificateBytes =
                certs.map<Uint8List>((e) => base64Decode(e)).toList();
          }
        });
      }
    }

    setState(() => _isLoading = false);
  }

  Future<void> saveProfile() async {
    final url = Uri.parse(
      'http://192.168.56.1/proyek2_mobile/portoline/save_profile.php',
    );
    final response = await http.post(
      url,
      body: {
        'user_id': userId ?? '',
        'name': nameController.text,
        'email': emailController.text,
        'dob': dobController.text,
        'hobby': hobbyController.text,
        'profile_image_base64':
            profileImageBytes != null ? base64Encode(profileImageBytes!) : '',
        'certificates_base64': jsonEncode(
          certificateBytes.map((e) => base64Encode(e)).toList(),
        ),
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileSavedPage()),
        );
        fetchProfile();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan: ${result['error']}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("HTTP Error: ${response.statusCode}")),
      );
    }
  }

  Future<void> pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      setState(() {
        profileImageBytes = result.files.first.bytes!;
      });
    }
  }

  Future<void> pickCertificateImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      setState(() {
        certificateBytes.add(result.files.first.bytes!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: pickProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        profileImageBytes != null
                            ? MemoryImage(profileImageBytes!)
                            : null,
                    child:
                        profileImageBytes == null
                            ? const Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: hobbyController,
                decoration: const InputDecoration(labelText: 'Hobby'),
              ),
              const SizedBox(height: 24),
              Text(
                'Certificates',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ...certificateBytes.map(
                    (bytes) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        bytes,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: pickCertificateImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, size: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: saveProfile,
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        );
  }
}

class ProfileSavedPage extends StatelessWidget {
  const ProfileSavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Tersimpan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              "Profil berhasil disimpan!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Kembali ke Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}

void _logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
    (Route<dynamic> route) => false,
  );
}
