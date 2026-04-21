import 'package:flutter/material.dart';

class ProcessingMethod {
  final String id;
  final String nameKey;
  final String howItWorksKey;
  final String inTheCupKey;
  final Map<String, double> sensoryProfile;

  const ProcessingMethod({
    required this.id,
    required this.nameKey,
    required this.howItWorksKey,
    required this.inTheCupKey,
    required this.sensoryProfile,
  });

  static const List<ProcessingMethod> all = [
    ProcessingMethod(
      id: 'natural',
      nameKey: 'process_natural',
      howItWorksKey: 'process_natural_how',
      inTheCupKey: 'process_natural_cup',
      sensoryProfile: {
        'bitterness': 2,
        'acidity': 3,
        'sweetness': 5,
        'body': 4,
        'intensity': 4,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'washed',
      nameKey: 'process_washed',
      howItWorksKey: 'process_washed_how',
      inTheCupKey: 'process_washed_cup',
      sensoryProfile: {
        'bitterness': 2,
        'acidity': 5,
        'sweetness': 3,
        'body': 2,
        'intensity': 3,
        'aftertaste': 3,
      },
    ),
    ProcessingMethod(
      id: 'honey',
      nameKey: 'process_honey',
      howItWorksKey: 'process_honey_how',
      inTheCupKey: 'process_honey_cup',
      sensoryProfile: {
        'bitterness': 2,
        'acidity': 3,
        'sweetness': 4,
        'body': 3,
        'intensity': 4,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'wet_hulled',
      nameKey: 'process_wet_hulled',
      howItWorksKey: 'process_wet_hulled_how',
      inTheCupKey: 'process_wet_hulled_cup',
      sensoryProfile: {
        'bitterness': 4,
        'acidity': 1,
        'sweetness': 2,
        'body': 5,
        'intensity': 5,
        'aftertaste': 5,
      },
    ),
    ProcessingMethod(
      id: 'anaerobic',
      nameKey: 'process_anaerobic',
      howItWorksKey: 'process_anaerobic_how',
      inTheCupKey: 'process_anaerobic_cup',
      sensoryProfile: {
        'bitterness': 2,
        'acidity': 4,
        'sweetness': 4,
        'body': 4,
        'intensity': 5,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'carbonic_maceration',
      nameKey: 'process_carbonic',
      howItWorksKey: 'process_carbonic_how',
      inTheCupKey: 'process_carbonic_cup',
      sensoryProfile: {
        'bitterness': 1,
        'acidity': 5,
        'sweetness': 4,
        'body': 3,
        'intensity': 5,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'lactic_acetic',
      nameKey: 'process_lactic',
      howItWorksKey: 'process_lactic_how',
      inTheCupKey: 'process_lactic_cup',
      sensoryProfile: {
        'bitterness': 1,
        'acidity': 5,
        'sweetness': 3,
        'body': 4,
        'intensity': 4,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'thermal_shock',
      nameKey: 'process_thermal',
      howItWorksKey: 'process_thermal_how',
      inTheCupKey: 'process_thermal_cup',
      sensoryProfile: {
        'bitterness': 1,
        'acidity': 4,
        'sweetness': 5,
        'body': 3,
        'intensity': 5,
        'aftertaste': 5,
      },
    ),
    ProcessingMethod(
      id: 'co_fermentation',
      nameKey: 'process_cofermentation',
      howItWorksKey: 'process_cofermentation_how',
      inTheCupKey: 'process_cofermentation_cup',
      sensoryProfile: {
        'bitterness': 2,
        'acidity': 4,
        'sweetness': 5,
        'body': 3,
        'intensity': 5,
        'aftertaste': 4,
      },
    ),
    ProcessingMethod(
      id: 'koji_yeast',
      nameKey: 'process_koji',
      howItWorksKey: 'process_koji_how',
      inTheCupKey: 'process_koji_cup',
      sensoryProfile: {
        'bitterness': 1,
        'acidity': 3,
        'sweetness': 5,
        'body': 4,
        'intensity': 4,
        'aftertaste': 5,
      },
    ),
  ];
}
