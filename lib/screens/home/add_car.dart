import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added Firebase Auth import
import 'package:car_rent_app/blocs/car_info_bloc/car_info_event.dart';
import 'package:car_rent_app/blocs/car_info_bloc/car_info_bloc.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _modelNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void dispose() {
    _modelNameController.dispose();
    _phoneController.dispose();
    _fuelTypeController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // FIX 1: Fetch the real logged-in user's ID
      final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

      context.read<CarBloc>().add(
        AddCarEvent(
          modelName: _modelNameController.text.trim(),
          phone: int.parse(_phoneController.text.trim()),
          fuelType: _fuelTypeController.text.trim(),
          price: _priceController.text.trim(),
          imageUrl: _imageUrlController.text.trim(),
          info: _infoController.text.trim(),
          userId: currentUserId, // Using the real ID here
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving car...'),
          backgroundColor: Color.fromARGB(255, 7, 77, 10),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 77, 10),
        foregroundColor: Colors.white,
        title: const Text('Add New Car'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildTextField(
              controller: _modelNameController,
              label: 'Car Model Name',
              icon: Icons.directions_car,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _fuelTypeController,
              label: 'Fuel Type (e.g., Petrol, Electric)',
              icon: Icons.local_gas_station,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _priceController,
              label: 'Price Per Day (\$)',
              icon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _imageUrlController,
              label: 'Image URL',
              icon: Icons.image,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _infoController,
              label: 'Information / Description',
              icon: Icons.info_outline,
              maxLines: 4,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 7, 77, 10),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Save Car',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF8E99AF)),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 7, 77, 10),
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
