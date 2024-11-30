import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Controllers/weather_controller.dart';
import '../../Models/weathers_model.dart';

TextEditingController searchController = TextEditingController();

launchurl() async {
  String url = 'https://www.youtube.com/channel/UCS3brcF49FE3japE2xM-8gg';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw "cannot launch $url";
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF005C97),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Consumer<WeatherController>(builder: (context, provider, _) {
            return FutureBuilder(
              future: provider.fetchWeatherData(),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Text("Error : ${snapShot.error}"),
                  );
                } else if (snapShot.hasData) {
                  Weather? weather = snapShot.data;
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  controller: searchController,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        )),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(14),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        )),
                                    hintText: "Enter City Name",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        // city = searchController.text;
                                        // setState(() {});
                                        // fetchProducts(city: city);
                                        // log("$city");
                                        provider.getsearchData(
                                            searchController.text);
                                      },
                                      icon: const Icon(Icons.search),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  "${weather!.current.tempC}°C",
                                  style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "${weather!.location.localtime}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      //  fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              launchurl();
                                            },
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "${weather!.location.name}",
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${weather!.current.condition.text}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: 270.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Today",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 187.h,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            itemCount: weather.forecast
                                                .forecastday[0].hour.length,
                                            itemBuilder: (context, Hindex) {
                                              int time = int.parse(weather
                                                  .forecast
                                                  .forecastday[0]
                                                  .hour[Hindex]
                                                  .time
                                                  .split(' ')[1]
                                                  .split(':')[0]);
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                    border: Border.all(
                                                      color:
                                                          Colors.blue.shade600,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        weather
                                                            .forecast
                                                            .forecastday[0]
                                                            .hour[Hindex]
                                                            .time
                                                            .toString()
                                                            .split(' ')[1],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25.sp),
                                                      ),
                                                      Image.network(
                                                        "https:${weather.forecast.forecastday[0].hour[Hindex].condition.icon}",
                                                        height: 50.h,
                                                      ),
                                                      Text(
                                                        "${weather.forecast.forecastday[0].hour[Hindex].tempC}°C",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25.sp),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 100.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Today's Temprerature ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "Temprerature a little lower than yesterday",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.sunny,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "UV",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${weather.current.uv}  of 10",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.device_thermostat,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Fell like",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${weather.current.feelslike_c}°C",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.air,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "ENE wind",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${weather.current.wind_mph} mph",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${weather.current.humidity}%",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.compress,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Air presure",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${weather.current.pressure_mb} mb",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        const Text(
                                          "Visibility",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${weather.current.vis_km} km",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
