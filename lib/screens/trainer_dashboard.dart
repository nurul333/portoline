import 'role_selection_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({super.key});

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const JobHomePage(),
    const TrainingPage(),
    const ProfilePage(),
    AddTrainingPage(trainerId: '1'),
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kelola'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: "Buat Pelatihan",
          ),
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
        'image': 'assets/medsos.png',
        'title': 'Pelatihan Kelola Media Sosial',
        'company': 'Starbucks',
        'description':
            'Pelajari strategi dan tools untuk mengelola media sosial secara profesional.',
        'price': 'Rp 300.000',
      },
      {
        'image': 'assets/keuangan.png',
        'title': 'Pelatihan Perencanaan Keuangan',
        'company': 'KopiKita',
        'description':
            'Belajar cara mengatur keuangan pribadi dan bisnis kecil dengan tepat.',
        'price': 'Rp 400.000',
      },
      {
        'image': 'assets/editing.png',
        'title': 'Pelatihan Editing Video',
        'company': 'Fore',
        'description':
            'Menguasai teknik dasar hingga mahir dalam editing video menggunakan software populer.',
        'price': 'Rp 350.000',
      },
      {
        'image': 'assets/speaking.png',
        'title': 'Pelatihan Public Speaking',
        'company': '224 Rooftop',
        'description':
            'Tingkatkan kepercayaan diri dan keterampilan berbicara di depan umum.',
        'price': 'Rp 450.000',
      },
      {
        'image': 'assets/medsos.png',
        'title': 'Pelatihan Kelola Media Sosial',
        'company': 'Starbucks',
        'description':
            'Pelajari strategi dan tools untuk mengelola media sosial secara profesional.',
        'price': 'Rp 300.000',
      },
      {
        'image': 'assets/keuangan.png',
        'title': 'Pelatihan Perencanaan Keuangan',
        'company': 'KopiKita',
        'description':
            'Belajar cara mengatur keuangan pribadi dan bisnis kecil dengan tepat.',
        'price': 'Rp 400.000',
      },
      {
        'image': 'assets/editing.png',
        'title': 'Pelatihan Editing Video',
        'company': 'Fore',
        'description':
            'Menguasai teknik dasar hingga mahir dalam editing video menggunakan software populer.',
        'price': 'Rp 350.000',
      },
      {
        'image': 'assets/speaking.png',
        'title': 'Pelatihan Public Speaking',
        'company': '224 Rooftop',
        'description':
            'Tingkatkan kepercayaan diri dan keterampilan berbicara di depan umum.',
        'price': 'Rp 450.000',
      },
      {
        'image': 'assets/keuangan.png',
        'title': 'Pelatihan Investasi Dasar',
        'company': 'Bank A',
        'description': 'Pelajari dasar-dasar investasi untuk pemula.',
        'price': 'Rp 500.000',
      },
    ];

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          "Let's Make People Level Up!!!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3 / 4,
            ),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return JobCard(
                image: job['image']!,
                title: job['title']!,
                company: job['company']!,
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
                            price: job['price']!,
                          ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Model untuk data pelatihan
class TrainingRegistration {
  final String image;
  final String title;
  final String company;
  final String buyerName;
  final String description;
  final String price;

  const TrainingRegistration({
    required this.image,
    required this.title,
    required this.company,
    required this.buyerName,
    required this.description,
    required this.price,
  });
}

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TrainingRegistration> trainingList = [
      const TrainingRegistration(
        image: 'assets/keuangan.png',
        title: 'Pelatihan Perencanaan Keuangan',
        company: 'Bank dimana aja ada',
        buyerName: 'Adit',
        description:
            'Belajar cara mengatur keuangan pribadi dan bisnis kecil dengan tepat.',
        price: 'Rp 400.000',
      ),
      const TrainingRegistration(
        image: 'assets/medsos.png',
        title: 'Pelatihan Kelola Media Sosial',
        company: 'KopiKita',
        buyerName: 'Siti',
        description:
            'Pelajari strategi dan tools untuk mengelola media sosial secara profesional.',
        price: 'Rp 300.000',
      ),
    ];

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'YOUR TRAINING',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2 / 3, // Lebih tinggi agar gambar bisa penuh
            ),
            itemCount: trainingList.length,
            itemBuilder: (context, index) {
              final training = trainingList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TrainingDetailPage(training: training),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            training.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              training.title,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              training.company,
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            Text(
                              'Buyer: ${training.buyerName}',
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TrainingDetailPage extends StatelessWidget {
  final TrainingRegistration training;

  const TrainingDetailPage({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Training Detail")),
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
              'Company: ${training.company}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            Text(
              'Buyer: ${training.buyerName}',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Deskripsi: ${training.description}',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              'Harga: ${training.price}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String image;
  final String title;
  final String company;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.image,
    required this.title,
    required this.company,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(company, style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailPage extends StatelessWidget {
  final String image;
  final String title;
  final String company;
  final String description;
  final String price;

  const JobDetailPage({
    super.key,
    required this.image,
    required this.title,
    required this.company,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pelatihan")),
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
            Text(
              'Deskripsi pelatihan:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(description),
            const SizedBox(height: 20),
            Text(
              'Harga: $price',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();

  String userId = "";

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchProfile();
  }

  Future<void> fetchProfile() async {
    final url = Uri.parse(
      'http://192.168.56.1/proyek2_mobile/portoline/get_profile_trainer.php?user_id=$userId',
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
        });
      }
    } else {
      // Tampilkan pesan kesalahan jika request gagal
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memuat profil. Kode: ${response.statusCode}"),
          ),
        );
      });
    }
  }

  Future<void> loadUserIdAndFetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id') ?? "";
    if (userId.isNotEmpty) {
      await fetchProfile();
    } else {
      // Menunda snackbar agar context valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User ID tidak ditemukan. Silakan login ulang."),
          ),
        );
      });
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

  Future<void> saveProfile() async {
    final url = Uri.parse(
      'http://192.168.56.1/proyek2_mobile/portoline/save_profile_trainer.php',
    );
    final response = await http.post(
      url,
      body: {
        'user_id': userId,
        'name': nameController.text,
        'email': emailController.text,
        'dob': dobController.text,
        'hobby': hobbyController.text,
        'profile_image_base64':
            profileImageBytes != null ? base64Encode(profileImageBytes!) : '',
      },
    );

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfileSavedPage()),
        );
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

// halaman_buat_pelatihan.dart
class AddTrainingPage extends StatefulWidget {
  final String trainerId;

  const AddTrainingPage({Key? key, required this.trainerId}) : super(key: key);

  @override
  _AddTrainingPageState createState() => _AddTrainingPageState();
}

class _AddTrainingPageState extends State<AddTrainingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Uint8List? _certificateBytes;
  String? _imageName;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _certificateBytes = bytes;
        _imageName = picked.name;
      });
    }
  }

  Future<void> _saveTraining() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _certificateBytes == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Semua kolom wajib diisi")));
      return;
    }

    try {
      final uri = Uri.parse(
        "http://192.168.56.1/proyek2_mobile/portoline/create_training.php",
      );

      var request = http.MultipartRequest('POST', uri);
      request.fields['judul'] = _titleController.text;
      request.fields['deskripsi'] = _descriptionController.text;
      request.fields['perusahaan'] = _companyController.text;
      request.fields['harga'] = _priceController.text;
      request.fields['trainer_id'] = widget.trainerId;

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _certificateBytes!,
          filename: 'training.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Pelatihan berhasil disimpan")));
        Navigator.pop(context, true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => TrainerDashboard()),
        );
        //<- ini untuk kembali ke halaman home dan trigger refresh
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal simpan. Status: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: Text("Tambah Pelatihan")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Judul Pelatihan"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Deskripsi"),
                maxLines: 3,
              ),
              TextField(
                controller: _companyController,
                decoration: InputDecoration(labelText: "Nama Perusahaan"),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text(
                "Upload Foto",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _certificateBytes != null
                  ? Image.memory(_certificateBytes!, height: 150)
                  : Text("Belum ada foto dipilih."),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.upload_file),
                label: Text("Tambah Foto Pelatihan"),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveTraining, child: Text("Simpan")),
            ],
          ),
        ),
      ),
    );
  }
}
