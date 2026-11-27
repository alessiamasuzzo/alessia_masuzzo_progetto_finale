import 'package:alessia_masuzzo_progetto_finale/controllers/wardrobe_controller.dart';
import 'package:alessia_masuzzo_progetto_finale/screens/profile_screen.dart';
import 'package:alessia_masuzzo_progetto_finale/services/weather_service.dart';
import 'package:alessia_masuzzo_progetto_finale/models/blob_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService();

  WeatherData? _weather;      
  bool _loading = false;      
  String? _error;             
  bool _cityNotFound = false; 

  Future<void> _searchCity(String city) async {
    if (city.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _weather = null;
      _cityNotFound = false;
    });

    try {
      final result = await _weatherService.getWeatherByCity(city.trim());
      if (!mounted) return;
      setState(() {
        _weather = result;
        _loading = false;
      });
    } on CityNotFoundException {
      if (!mounted) return;
      setState(() {
        _error = "Città non trovata";
        _cityNotFound = true;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = "Controlla la connessione dati";
        _loading = false;
      });
    }
  }

  IconData _iconFor(int code) {
    if (code == 0) return Icons.wb_sunny_outlined;
    if (code <= 48) return Icons.cloud_outlined;
    if (code <= 67) return Icons.umbrella_outlined;
    if (code <= 77) return Icons.ac_unit;
    if (code <= 82) return Icons.umbrella_outlined;
    if (code <= 86) return Icons.ac_unit;
    return Icons.thunderstorm_outlined;
  }

  Widget _buildResult(BuildContext context) {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (_error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _cityNotFound ? Icons.search_off : Icons.cloud_off,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(_error!),
            ],
          ),
        ),
      );
    } else if (_weather != null) {
      final weather = _weather!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.city,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        Text(
                          "${weather.temperature.round()}°",
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      _iconFor(weather.code),
                      size: 64,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              "Capi consigliati",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          if (context.watch<WardrobeController>().clothes.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Il tuo armadio è vuoto: carica il tuo primo capo"),
            )
          else if (context
              .watch<WardrobeController>()
              .forTemperature(weather.temperature)
              .isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Nessun capo adatto a questa temperatura"),
            )
          else
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: context
                    .watch<WardrobeController>()
                    .forTemperature(weather.temperature)
                    .map((c) => SizedBox(
                          width: 110,
                          height: 150,
                          child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.memory(
                                    c.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    c.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 60),
        child: Center(child: Text("Inserisci la città")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlobBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(
            "Consiglio",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                onSubmitted: _searchCity,
                decoration: InputDecoration(
                  hintText: "Inserisci la città",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            _buildResult(context),
          ],
        ),
      ),
    );
  }
}