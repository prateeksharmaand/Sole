import 'package:flutter/material.dart';

class PerkModel {
  final String title;
  final String description;
  final String icon; // Asset path or url
  final bool isFeatured;
  final String promoCode;
  final String url;
  final Color bgColor;

  PerkModel({
    required this.title,
    required this.description,
    required this.icon,
    this.isFeatured = false,
    required this.promoCode,
    required this.url,
    this.bgColor = Colors.white,
  });
}
