import 'package:esas/components/btn_action.dart';
import 'package:esas/components/date_picker.dart';
import 'package:esas/components/globat_appbar.dart';
import 'package:esas/components/select_input.dart';
import 'package:esas/components/text_input.dart';
import 'package:esas/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/info_personal_controller.dart';

class InfoPersonalView extends GetView<InfoPersonalController> {
  const InfoPersonalView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Info Personal',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () {
              if (controller.isloading.isFalse) {
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildTextInput(
                          controller: controller.name,
                          hintText: 'Nama...',
                          icon: Icons.person,
                          inputType: TextInputType.name,
                        ),
                        _buildTextInput(
                          controller: controller.nik,
                          hintText: 'NIP...',
                          icon: Icons.person_pin_sharp,
                          inputType: TextInputType.number,
                        ),
                        _buildTextInput(
                          controller: controller.email,
                          hintText: 'Email...',
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                        ),
                        _buildTextInput(
                          controller: controller.phone,
                          hintText: 'Telpon/HP...',
                          icon: Icons.phone_android,
                          inputType: TextInputType.phone,
                        ),
                        _buildTextInput(
                          controller: controller.placebirth,
                          hintText: 'Tempat Lahir...',
                          icon: Icons.person_pin,
                          inputType: TextInputType.name,
                        ),
                        _buildDatePicker(
                          controller: controller.datebirth,
                          hintText: 'Select Date',
                          icon: Icons.calendar_today,
                          onTap: () => controller.selectDate(context),
                        ),
                        _buildSelectInput(
                          controller: controller.gender,
                          hintText: 'Pilih Jenis Kelamin',
                          icon: Icons.wc,
                          items: const [
                            DropdownMenuItem(
                                value: 'm', child: Text('Laki-laki')),
                            DropdownMenuItem(
                                value: 'w', child: Text('Perempuan')),
                          ],
                        ),
                        _buildSelectInput(
                          controller: controller.blood,
                          hintText: 'Pilih Golongan Darah',
                          icon: Icons.bloodtype,
                          items: const [
                            DropdownMenuItem(
                                value: 'a', child: Text('Gol. darah A')),
                            DropdownMenuItem(
                                value: 'b', child: Text('Gol. darah B')),
                            DropdownMenuItem(
                                value: 'o', child: Text('Gol. darah O')),
                            DropdownMenuItem(
                                value: 'ab', child: Text('Gol. darah AB')),
                          ],
                        ),
                        _buildSelectInput(
                          controller: controller.maritalStatus,
                          hintText: 'Pilih Status Pernikahan',
                          icon: Icons.remove_circle_outline,
                          items: const [
                            DropdownMenuItem(
                                value: 'single', child: Text('Belum Menikah')),
                            DropdownMenuItem(
                                value: 'marriade', child: Text('Menikah')),
                            DropdownMenuItem(
                                value: 'widow', child: Text('Janda')),
                            DropdownMenuItem(
                                value: 'widower', child: Text('Duda')),
                          ],
                        ),
                        _buildSelectInput(
                          controller: controller.religion,
                          hintText: 'Pilih Agama/Kepercayaan',
                          icon: Icons.public,
                          items: const [
                            DropdownMenuItem(
                                value: 'islam', child: Text('Islam')),
                            DropdownMenuItem(
                                value: 'protestant', child: Text('Protestan')),
                            DropdownMenuItem(
                                value: 'catholic', child: Text('Katolik')),
                            DropdownMenuItem(
                                value: 'hindu', child: Text('Hindu')),
                            DropdownMenuItem(
                                value: 'buddha', child: Text('Buddha')),
                            DropdownMenuItem(
                                value: 'khonghucu', child: Text('Khonghucu')),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 50.0),
                      alignment: Alignment.bottomCenter,
                      child: BtnAction(
                        act: () => controller.submitForm(
                            controller.name.text,
                            controller.nik.text,
                            controller.email.text,
                            controller.phone.text,
                            controller.placebirth.text,
                            controller.datebirth.text,
                            controller.gender.text,
                            controller.blood.text,
                            controller.maritalStatus.text,
                            controller.religion.text),
                        color: primaryColor,
                        icon: Icons.save,
                        isLoading: controller.isloading,
                        title: 'Simpan data',
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextInput(
        controller: controller,
        hintText: hintText,
        icon: icon,
        obscureText: false,
        inputType: inputType,
      ),
    );
  }

  Widget _buildDatePicker({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required VoidCallback onTap, // Mengubah Function menjadi VoidCallback
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DatePicker(
        controller: controller,
        hintText: hintText,
        icon: icon,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSelectInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SelectInput(
        hintText: hintText,
        icon: icon,
        items: items,
        onChanged: (value) {
          if (value != null) {
            controller.text = value;
          }
        },
        value: controller.text,
      ),
    );
  }
}
