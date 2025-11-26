import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final VoidCallback onSendOTP;
  final VoidCallback onBack;
  final String email;

  const ForgotPasswordPage({
    super.key,

    required this.onSendOTP,
    required this.onBack,
    required this.email,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSendOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8FAFC), // slate-50
              Color(0xFFECFEFF), // cyan-50
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header with gradient
                _buildHeader(),

                // Form Card
                _buildFormCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 128),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6B6A), Color(0xFF359a99), Color(0xFF40E0D0)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -96,
            right: -96,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -64,
            left: -64,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              InkWell(
                onTap: widget.onBack,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Title
              Text(
                'Lupa Kata Sandi?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Jangan khawatir, kami akan mengirimkan kode verifikasi',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Transform.translate(
      offset: Offset(0, -80),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Main Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF40E0D0).withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF40E0D0).withOpacity(0.2),
                            Color(0xFF2F6B6A).withOpacity(0.2),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mail_outline,
                        size: 40,
                        color: Color(0xFF2F6B6A),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Description
                    Text(
                      'Masukkan email Anda dan kami akan mengirimkan kode OTP untuk mereset kata sandi',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 24),

                    // Email Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2F6B6A),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'nama@email.com',
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Color(0xFF40E0D0),
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF40E0D0).withOpacity(0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF40E0D0).withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFF2F6B6A),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2F6B6A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF2F6B6A), Color(0xFF40E0D0)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Kirim Kode OTP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF40E0D0).withOpacity(0.1),
                    Color(0xFF2F6B6A).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF40E0D0).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '💡 Kode OTP akan dikirimkan ke email Anda dan berlaku selama 10 menit',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2F6B6A).withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
