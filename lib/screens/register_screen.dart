import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = 'Job Seeker'; // default role

  void _selectRoleDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Role'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Job Seeker'),
                  leading: Radio(
                    value: 'Job Seeker',
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value.toString();
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Trainer'),
                  leading: Radio(
                    value: 'Trainer',
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value.toString();
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    var url = Uri.parse(
      'http://192.168.1.4/proyek2_mobile/portoline/register.php',
    ); // Ganti sesuai IP

    var response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "role": selectedRole,
      },
    );
    // ✅ Log respons ke terminal/debug console
    print('Response code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Register berhasil!')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal: ${data['message']}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/logo.png', height: 80),
                    const SizedBox(height: 16),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _selectRoleDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('SELECT ROLE'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('REGISTER'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'have an account? Login',
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
