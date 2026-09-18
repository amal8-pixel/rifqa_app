import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/prayer_model.dart';

class PrayerService {
  static final Dio dio = Dio();
  static Future<PrayerModel> getPrayerTimes() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await dio.get(
        'https://api.aladhan.com/v1/timingsByCity?city=Makkah&country=Saudi%20Arabia&method=4',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load prayer times');
      }

      final timings = Map<String, dynamic>.from(
        response.data['data']['timings'],
      );

      final prayers = {
        'الفجر': timings['Fajr'],
        'الظهر': timings['Dhuhr'],
        'العصر': timings['Asr'],
        'المغرب': timings['Maghrib'],
        'العشاء': timings['Isha'],
      };

      final now = DateTime.now();

      String nextPrayer = 'الفجر';
      DateTime? nextPrayerTime;

      for (final entry in prayers.entries) {
        final parts = entry.value.toString().split(':');

        final prayerTime = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );

        if (prayerTime.isAfter(now)) {
          nextPrayer = entry.key;
          nextPrayerTime = prayerTime;
          break;
        }
      }

      if (nextPrayerTime == null) {
        final parts = prayers['الفجر'].toString().split(':');

        nextPrayerTime = DateTime(
          now.year,
          now.month,
          now.day + 1,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      }

      final prayerModel = PrayerModel(
        name: nextPrayer,
        time: prayers[nextPrayer].toString(),
        dateTime: nextPrayerTime,
      );

      // حفظ البيانات في الجهاز
      await prefs.setString(
        'prayer_cache',
        jsonEncode(prayerModel.toJson()),
      );

      return prayerModel;
    } catch (e) {
      // إذا فشل API نستخدم البيانات المخزنة
      final cachedData = prefs.getString('prayer_cache');

      if (cachedData != null) {
        return PrayerModel.fromJson(
          jsonDecode(cachedData),
        );
      }

      // إذا ما فيه API ولا Cache
      throw Exception('لا يمكن تحميل مواقيت الصلاة');
    }
  }
}
