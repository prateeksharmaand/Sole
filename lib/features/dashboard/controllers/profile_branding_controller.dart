import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/branding_repository.dart';
import '../../../data/models/branding_model.dart';

class ProfileAndBrandingController extends GetxController {
  final BrandingRepository _brandingRepository = BrandingRepository();

  // Logo
  Rx<File?> selectedLogo = Rx<File?>(null);

  // Brand Colors
  Rx<Color> brandColor = Rx<Color>(Color(0xFF4D4DFF));
  Rx<Color> contentColor = Rx<Color>(Color(0xFF000000));

  // Invoice Settings - Customer Info
  RxBool invCustomerName = true.obs;
  RxBool invCustomerBusinessName = true.obs;
  RxBool invCustomerAddress = true.obs;
  RxBool invCustomerAbn = true.obs;

  // Invoice Settings - Sole/Business Info
  RxBool invSoleUserName = true.obs;
  RxBool invSoleBusinessName = true.obs;
  RxBool invSoleBusinessAddress = true.obs;
  RxBool invSoleBusinessAbn = true.obs;
  RxBool invDisplayDesc = true.obs;

  // Quote Settings - Customer Info
  RxBool quoCustomerName = true.obs;
  RxBool quoCustomerBusinessName = true.obs;
  RxBool quoCustomerAddress = true.obs;
  RxBool quoCustomerAbn = true.obs;

  // Quote Settings - Sole/Business Info
  RxBool quoSoleUserName = true.obs;
  RxBool quoSoleBusinessName = true.obs;
  RxBool quoSoleBusinessAddress = true.obs;
  RxBool quoSoleBusinessAbn = true.obs;

  // Social Media Toggles
  RxBool phoneEnabled = false.obs;
  RxBool websiteEnabled = false.obs;
  RxBool facebookUrlEnabled = false.obs;
  RxBool instagramUrlEnabled = false.obs;
  RxBool linkedinUrlEnabled = false.obs;
  RxBool tiktokUrlEnabled = false.obs;

  // Template Selections
  RxString invoiceTemplate = '1'.obs;
  RxString quoteTemplate = '13'.obs;
  RxString ndisTemplate = '2'.obs;

  // Notes
  final invoiceNoteController = TextEditingController();
  final quoteNoteController = TextEditingController();

  // Receipt Toggle
  RxBool sendPaidInvoiceReceipt = false.obs;

  // Loading state
  RxBool isSaving = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBranding();
  }

  @override
  void onClose() {
    invoiceNoteController.dispose();
    quoteNoteController.dispose();
    super.onClose();
  }

  /// Pick logo from gallery
  Future<void> pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      selectedLogo.value = File(file.path);
    }
  }

  /// Clear selected logo
  void clearLogo() {
    selectedLogo.value = null;
  }

  /// Convert bool to "1" or "0" string for API
  String _boolToString(bool value) {
    return value ? '1' : '0';
  }

  /// Convert Color to hex string
  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Save branding settings
  Future<void> saveBranding() async {
    if (isSaving.value) return;

    // Validation: Check if there's any meaningful data to save
    bool hasChanges =
        selectedLogo.value != null ||
        invoiceNoteController.text.isNotEmpty ||
        quoteNoteController.text.isNotEmpty;

    if (!hasChanges) {
      Get.snackbar(
        'No Changes',
        'Please make some changes before saving',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return;
    }

    isSaving.value = true;

    try {
      final brandingModel = BrandingModel(
        brandColor: _colorToHex(brandColor.value),
        contentColor: _colorToHex(contentColor.value),
        invCustomerName: _boolToString(invCustomerName.value),
        invCustomerBusinessName: _boolToString(invCustomerBusinessName.value),
        invCustomerAddress: _boolToString(invCustomerAddress.value),
        invCustomerAbn: _boolToString(invCustomerAbn.value),
        invSoleUserName: _boolToString(invSoleUserName.value),
        invSoleBusinessName: _boolToString(invSoleBusinessName.value),
        invSoleBusinessAddress: _boolToString(invSoleBusinessAddress.value),
        invSoleBusinessAbn: _boolToString(invSoleBusinessAbn.value),
        invDisplayDesc: _boolToString(invDisplayDesc.value),
        quoCustomerName: _boolToString(quoCustomerName.value),
        quoCustomerBusinessName: _boolToString(quoCustomerBusinessName.value),
        quoCustomerAddress: _boolToString(quoCustomerAddress.value),
        quoCustomerAbn: _boolToString(quoCustomerAbn.value),
        quoSoleUserName: _boolToString(quoSoleUserName.value),
        quoSoleBusinessName: _boolToString(quoSoleBusinessName.value),
        quoSoleBusinessAddress: _boolToString(quoSoleBusinessAddress.value),
        quoSoleBusinessAbn: _boolToString(quoSoleBusinessAbn.value),
        phoneEnabled: _boolToString(phoneEnabled.value),
        websiteEnabled: _boolToString(websiteEnabled.value),
        facebookUrlEnabled: _boolToString(facebookUrlEnabled.value),
        instagramUrlEnabled: _boolToString(instagramUrlEnabled.value),
        linkedinUrlEnabled: _boolToString(tiktokUrlEnabled.value),
        tiktokUrlEnabled: _boolToString(tiktokUrlEnabled.value),
        invoiceTemplate: invoiceTemplate.value,
        quoteTemplate: quoteTemplate.value,
        ndisTemplate: ndisTemplate.value,
        invoiceNote: invoiceNoteController.text,
        quoteNote: quoteNoteController.text,
        sendPaidInvoiceReceipt: _boolToString(sendPaidInvoiceReceipt.value),
      );

      final response = await _brandingRepository.saveBranding(brandingModel);

      if (response.success) {
        print('✅ Branding saved successfully');
        // Optionally navigate back
        Get.back();
      } else {
        print('❌ Failed to save branding: ${response.message}');
      }
    } catch (e) {
      print('⚠️ Error saving branding: $e');
    } finally {
      isSaving.value = false;
    }
  }

  /// Load existing branding settings
  Future<void> loadBranding() async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final response = await _brandingRepository.getBranding();

      if (response.success && response.data != null) {
        final data = response.data!;

        // Parse and set colors
        brandColor.value = _hexToColor(data.brandColor);
        contentColor.value = _hexToColor(data.contentColor);

        // Set invoice settings
        invCustomerName.value = data.invCustomerName == '1';
        invCustomerBusinessName.value = data.invCustomerBusinessName == '1';
        invCustomerAddress.value = data.invCustomerAddress == '1';
        invCustomerAbn.value = data.invCustomerAbn == '1';
        invSoleUserName.value = data.invSoleUserName == '1';
        invSoleBusinessName.value = data.invSoleBusinessName == '1';
        invSoleBusinessAddress.value = data.invSoleBusinessAddress == '1';
        invSoleBusinessAbn.value = data.invSoleBusinessAbn == '1';
        invDisplayDesc.value = data.invDisplayDesc == '1';

        // Set quote settings
        quoCustomerName.value = data.quoCustomerName == '1';
        quoCustomerBusinessName.value = data.quoCustomerBusinessName == '1';
        quoCustomerAddress.value = data.quoCustomerAddress == '1';
        quoCustomerAbn.value = data.quoCustomerAbn == '1';
        quoSoleUserName.value = data.quoSoleUserName == '1';
        quoSoleBusinessName.value = data.quoSoleBusinessName == '1';
        quoSoleBusinessAddress.value = data.quoSoleBusinessAddress == '1';
        quoSoleBusinessAbn.value = data.quoSoleBusinessAbn == '1';

        // Set social media toggles
        phoneEnabled.value = data.phoneEnabled == '1';
        websiteEnabled.value = data.websiteEnabled == '1';
        facebookUrlEnabled.value = data.facebookUrlEnabled == '1';
        instagramUrlEnabled.value = data.instagramUrlEnabled == '1';
        linkedinUrlEnabled.value = data.linkedinUrlEnabled == '1';
        tiktokUrlEnabled.value = data.tiktokUrlEnabled == '1';

        // Set templates
        invoiceTemplate.value = data.invoiceTemplate;
        quoteTemplate.value = data.quoteTemplate;
        ndisTemplate.value = data.ndisTemplate;

        // Set notes
        invoiceNoteController.text = data.invoiceNote;
        quoteNoteController.text = data.quoteNote;

        // Set receipt toggle
        sendPaidInvoiceReceipt.value = data.sendPaidInvoiceReceipt == '1';

        print('✅ Loaded branding settings');
      } else {
        print('ℹ️ No branding settings found, using defaults');
      }
    } catch (e) {
      print('⚠️ Error loading branding: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Convert hex string to Color
  Color _hexToColor(String hex) {
    try {
      hex = hex.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return Color(0xFF4D4DFF); // Default color
    }
  }
}
