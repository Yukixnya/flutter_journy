import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widget/weather_main_info.dart';
import 'package:weather_app/widget/weather_details.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _cityEditingController = TextEditingController();

  @override
  void dispose() {
    _cityEditingController.dispose();
    super.dispose();
  }

  void _fetchWeather() {
    final city = _cityEditingController.text.trim();
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    ref.read(weatherProvider.notifier).getWeather(city);
  }

  Future<void> _currentLocationWeather() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return;
    } 

    // We have permission! Get the live location
    Position position = await Geolocator.getCurrentPosition();
    
    // Send coordinates to provider
    ref.read(weatherProvider.notifier).getCurrentLocationWeather(
      position.latitude, 
      position.longitude
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Matching the dark teal gradient from the picture
            colors: [Color(0xFF0D1D2B), Color(0xFF00897B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Top Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: TextField(
                    controller: _cityEditingController,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'eg. New York, Shanghai, Delhi ...',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        ),
                        onPressed: _currentLocationWeather,
                      ),
                      suffixIcon: weatherState.isLoading
                          ? const SizedBox(
                              width: 48,
                              height: 48,
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: _fetchWeather,
                            ),
                    ),
                    onSubmitted: (_) => _fetchWeather(),
                  ),
                ),

                // Inline Warning Message
                if (weatherState.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            weatherState.errorMessage,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Weather Results
                if (weatherState.weather != null) ...[
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          WeatherMainInfo(weather: weatherState.weather!),
                          const SizedBox(height: 40), // Space between sections
                          WeatherDetails(weather: weatherState.weather!),
                          const SizedBox(
                            height: 30,
                          ), // Padding at bottom for future timeline
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  const Spacer(),
                  Icon(
                    Icons.cloud_off,
                    size: 80,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Search a city to see the weather",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
