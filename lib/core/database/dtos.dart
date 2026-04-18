library;

import 'dart:convert';
// Removed unused foundation.dart import
// Removed unused drift and app_database imports

/// Data Transfer Objects for the Specialty Coffee app.
/// Optimized for the v17 schema with full sensory and pricing support.

enum EncyclopediaSortOption {
  countryAsc,
  countryDesc,
  regionAsc,
  regionDesc,
  countryRegionAsc,
  priceRetailAsc,
  priceRetailDesc,
  priceWholesaleAsc,
  priceWholesaleDesc,
  processAsc,
  newestFirst,
}

class LocalizedBeanDto {
  final int id;
  final int? brandId;
  final String? countryEmoji;
  final int? altitudeMin;
  final int? altitudeMax;
  final String lotNumber;
  final String scaScore;
  final double cupsScore;
  final Map<String, dynamic> sensoryPoints;
  final Map<String, dynamic> pricing;
  final List<String> plantationPhotos;
  final bool isPremium;
  final String detailedProcess;
  final String? url;

  final int? farmerId;
  final bool isDecaf;
  final String? farm;
  final String? farmPhotosUrlCover;
  final String? washStation;
  final String? retailPrice;
  final String? wholesalePrice;

  final String? harvestSeason;
  final String? price;
  final String? weight;
  final String? roastDate;
  final String processingMethodsJson;

  // Localized fields
  final String country;
  final String region;
  final String varieties;
  final List<String> flavorNotes;
  final String description;
  final String farmDescription;
  final String roastLevel;
  final String processMethod;
  final bool isFavorite;
  final bool isArchived;
  final DateTime? createdAt;

  LocalizedBeanDto({
    required this.id,
    this.brandId,
    this.countryEmoji,
    this.altitudeMin,
    this.altitudeMax,
    required this.lotNumber,
    required this.scaScore,
    required this.cupsScore,
    required this.sensoryPoints,
    required this.pricing,
    required this.plantationPhotos,
    required this.isPremium,
    required this.detailedProcess,
    this.url,
    this.farmerId,
    this.isDecaf = false,
    this.farm,
    this.farmPhotosUrlCover,
    this.washStation,
    this.retailPrice,
    this.wholesalePrice,
    this.harvestSeason,
    this.price,
    this.weight,
    this.roastDate,
    required this.processingMethodsJson,
    required this.country,
    required this.region,
    required this.varieties,
    required this.flavorNotes,
    required this.description,
    required this.farmDescription,
    required this.roastLevel,
    required this.processMethod,
    required this.isFavorite,
    this.isArchived = false,
    this.createdAt,
  });

  // UI Compatibility Getters
  String get fullDisplayName => '$country $region';
  String get detailedProcessMarkdown => detailedProcess;
  String get sensoryJson => jsonEncode(sensoryPoints);
  String get priceJson => jsonEncode(pricing);
  String get imageUrl =>
      farmPhotosUrlCover ??
      (plantationPhotos.isNotEmpty ? plantationPhotos.first : '');

  String get altitude => altitudeMax != null ? altitudeMax.toString() : '';
  String get processing => processMethod;

  String get effectiveFlagUrl {
    // Corrected to use the specific 'Flags' bucket as per user feedback
    final fileName = '${country.toLowerCase().replaceAll(' ', '_')}.png';
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/Flags/$fileName';
  }
}

class LocalizedBrandDto {
  final int id;
  final String name;
  final String logoUrl;
  final String siteUrl;
  final String shortDesc;
  final String fullDesc;
  final String location;

  LocalizedBrandDto({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.siteUrl,
    required this.shortDesc,
    required this.fullDesc,
    required this.location,
  });
}

class LocalizedFarmerDto {
  final int id;
  final String imageUrl;
  final String flagUrl;
  final String name;
  final String region;
  final String country;
  final String descriptionHtml;
  final String story;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;

  LocalizedFarmerDto({
    required this.id,
    required this.imageUrl,
    required this.flagUrl,
    required this.name,
    required this.region,
    required this.country,
    required this.descriptionHtml,
    required this.story,
    this.latitude,
    this.longitude,
    this.createdAt,
  });

  String get effectiveImageUrl {
    if (imageUrl.isEmpty) return '';
    if (imageUrl.startsWith('http')) return imageUrl;
    if (imageUrl.startsWith('assets/')) return imageUrl;
    
    // Corrected to use the specific 'Farmers' bucket
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/Farmers/$imageUrl';
  }

  String get effectiveFlagUrl {
    if (flagUrl.isEmpty) return '';
    if (flagUrl.startsWith('http')) return flagUrl;
    if (flagUrl.startsWith('assets/')) return flagUrl;

    // Use Flags bucket
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/Flags/$flagUrl';
  }

  // UI Backwards Compatibility
  String get description => descriptionHtml;
}

class SpecialtyArticleDto {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String flagUrl;
  final String contentHtml;
  final int readTimeMin;

  SpecialtyArticleDto({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.flagUrl,
    required this.contentHtml,
    required this.readTimeMin,
  });

  String get effectiveImageUrl {
    if (imageUrl.isEmpty) return '';
    if (imageUrl.startsWith('http')) return imageUrl;
    if (imageUrl.startsWith('assets/')) return imageUrl;
    
    // Corrected to use 'specialty-articles' bucket directly
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/specialty-articles/$imageUrl';
  }

  String get effectiveFlagUrl {
    if (flagUrl.isEmpty) return '';
    if (flagUrl.startsWith('http')) return flagUrl;
    if (flagUrl.startsWith('assets/')) return flagUrl;

    // Use Flags bucket
    return 'https://lylnnqojnytndybhuicr.supabase.co/storage/v1/object/public/Flags/$flagUrl';
  }
}

class RecommendedRecipeDto {
  final int id;
  final int lotId;
  final String methodKey;
  final double coffeeGrams;
  final double waterGrams;
  final double tempC;
  final int timeSec;
  final double rating;
  final Map<String, dynamic> sensoryPoints;
  final String notes;

  RecommendedRecipeDto({
    required this.id,
    required this.lotId,
    required this.methodKey,
    required this.coffeeGrams,
    required this.waterGrams,
    required this.tempC,
    required this.timeSec,
    required this.rating,
    required this.sensoryPoints,
    required this.notes,
  });

  String get sensoryJson => jsonEncode(sensoryPoints);
}

class BrewingRecipeDto {
  final int id;
  final String methodKey;
  final String name;
  final String description;
  final String imageUrl;
  final double? ratioGramsPerMl;
  final double? tempC;
  final int? totalTimeSec;
  final String? difficulty;
  final String? stepsJson;
  final String? flavorProfile;
  final String? iconName;

  BrewingRecipeDto({
    required this.id,
    required this.methodKey,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.ratioGramsPerMl,
    this.tempC,
    this.totalTimeSec,
    this.difficulty,
    this.stepsJson,
    this.flavorProfile,
    this.iconName,
  });
}

class SphereRegionDto {
  final String id;
  final String key; // Identifier for map assets/regions
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final String markerColor;
  final bool isActive;

  SphereRegionDto({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.markerColor,
    this.isActive = true,
  });
}

class CoffeeLotDto {
  final String id;
  final String? userId;
  final String? roasteryName;
  final String? roasteryCountry;
  final String? coffeeName;
  final String? originCountry;
  final String? region;
  final String? altitude;
  final String? process;
  final String? roastLevel;
  final DateTime? roastDate;
  final DateTime? openedAt;
  final String? weight;
  final String? lotNumber;
  final bool isDecaf;
  final String? farm;
  final String? washStation;
  final String? farmer;
  final String? varieties;
  final String? flavorProfile;
  final String? scaScore;
  final bool isFavorite;
  final bool isArchived;
  final bool isOpen;
  final bool isGround;
  final DateTime? createdAt;
  final Map<String, dynamic> sensoryPoints;
  final Map<String, dynamic> pricing;
  final DateTime? updatedAt;
  final bool isDeletedLocal;
  final int? brandId;
  final bool isSynced;
  final String? imageUrl;

  CoffeeLotDto({
    required this.id,
    this.userId,
    this.roasteryName,
    this.roasteryCountry,
    this.coffeeName,
    this.originCountry,
    this.region,
    this.altitude,
    this.process,
    this.roastLevel,
    this.roastDate,
    this.openedAt,
    this.weight,
    this.lotNumber,
    required this.isDecaf,
    this.farm,
    this.washStation,
    this.farmer,
    this.varieties,
    this.flavorProfile,
    this.scaScore,
    required this.isFavorite,
    required this.isArchived,
    this.isOpen = false,
    this.isGround = false,
    this.createdAt,
    this.updatedAt,
    required this.sensoryPoints,
    required this.pricing,
    this.brandId,
    this.isDeletedLocal = false,
    this.isSynced = false,
    this.imageUrl,
  });

  String get sensoryJson => jsonEncode(sensoryPoints);
  String get priceJson => jsonEncode(pricing);
  String get processMethod => process ?? '';

  CoffeeLotDto copyWith({
    String? id,
    String? userId,
    String? roasteryName,
    String? roasteryCountry,
    String? coffeeName,
    String? originCountry,
    String? region,
    String? altitude,
    String? process,
    String? roastLevel,
    DateTime? roastDate,
    DateTime? openedAt,
    String? weight,
    String? lotNumber,
    bool? isDecaf,
    String? farm,
    String? washStation,
    String? farmer,
    String? varieties,
    String? flavorProfile,
    String? scaScore,
    bool? isFavorite,
    bool? isArchived,
    bool? isOpen,
    bool? isGround,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? sensoryPoints,
    Map<String, dynamic>? pricing,
    int? brandId,
    bool? isDeletedLocal,
    bool? isSynced,
    String? imageUrl,
  }) {
    return CoffeeLotDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roasteryName: roasteryName ?? this.roasteryName,
      roasteryCountry: roasteryCountry ?? this.roasteryCountry,
      coffeeName: coffeeName ?? this.coffeeName,
      originCountry: originCountry ?? this.originCountry,
      region: region ?? this.region,
      altitude: altitude ?? this.altitude,
      process: process ?? this.process,
      roastLevel: roastLevel ?? this.roastLevel,
      roastDate: roastDate ?? this.roastDate,
      openedAt: openedAt ?? this.openedAt,
      weight: weight ?? this.weight,
      lotNumber: lotNumber ?? this.lotNumber,
      isDecaf: isDecaf ?? this.isDecaf,
      farm: farm ?? this.farm,
      washStation: washStation ?? this.washStation,
      farmer: farmer ?? this.farmer,
      varieties: varieties ?? this.varieties,
      flavorProfile: flavorProfile ?? this.flavorProfile,
      scaScore: scaScore ?? this.scaScore,
      isFavorite: isFavorite ?? this.isFavorite,
      isArchived: isArchived ?? this.isArchived,
      isOpen: isOpen ?? this.isOpen,
      isGround: isGround ?? this.isGround,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sensoryPoints: sensoryPoints ?? this.sensoryPoints,
      pricing: pricing ?? this.pricing,
      brandId: brandId ?? this.brandId,
      isDeletedLocal: isDeletedLocal ?? this.isDeletedLocal,
      isSynced: isSynced ?? this.isSynced,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class CustomRecipeDto {
  final String id;
  final String? lotId;
  final String methodKey;
  final String name;
  final double coffeeGrams;
  final double totalWaterMl;
  final int grindNumber;
  final int comandanteClicks;
  final int ek43Division;
  final int totalPours;
  final List<dynamic> pours;
  final double brewTempC;
  final String notes;
  final int rating;
  final DateTime? updatedAt;
  final bool isSynced;

  CustomRecipeDto({
    required this.id,
    this.lotId,
    required this.methodKey,
    required this.name,
    required this.coffeeGrams,
    required this.totalWaterMl,
    required this.grindNumber,
    required this.comandanteClicks,
    required this.ek43Division,
    required this.totalPours,
    required this.pours,
    required this.brewTempC,
    required this.notes,
    required this.rating,
    this.updatedAt,
    this.isSynced = false,
  });

  String get pourScheduleJson => jsonEncode(pours);
}

extension LocalizedBeanDtoExtension on LocalizedBeanDto {
  /// Gets the maximum price between retail and wholesale for sorting purposes.
  /// Standardizes to numeric value for comparison.
  double get maxPrice {
    final r = _parsePrice(retailPrice);
    final w = _parsePrice(wholesalePrice);
    return r > w ? r : w;
  }

  double _parsePrice(String? priceStr) {
    if (priceStr == null || priceStr.isEmpty) return 0.0;
    // Extract first number-like sequence (e.g. "$15" -> 15.0, "1050 UAH" -> 1050.0)
    final regex = RegExp(r'(\d+([.,]\d+)?)');
    final match = regex.firstMatch(priceStr);
    if (match != null) {
      final val = match.group(1)?.replaceAll(',', '.') ?? '0';
      return double.tryParse(val) ?? 0.0;
    }
    return 0.0;
  }
}

// Aliases for compatibility with existing UI code
typedef EncyclopediaEntry = LocalizedBeanDto;
typedef Brand = LocalizedBrandDto;
typedef Farmer = LocalizedFarmerDto;
typedef SpecialtyArticle = SpecialtyArticleDto;
typedef RecommendedRecipe = RecommendedRecipeDto;
typedef FarmerDto = LocalizedFarmerDto;
