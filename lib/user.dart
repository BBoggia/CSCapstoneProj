import 'package:firebase_auth/firebase_auth.dart';
import 'package:horoscope/horoscope_flutter.dart';

class User {
  int monthOfbirth;
  int dayOfBirth;

  User() {}

  String GetZodiacSign() {
    switch (monthOfbirth) {
      case 1:
        if (dayOfBirth > 20) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 2:
        if (dayOfBirth > 19) {
          return ZodiacSigns.PISCES;
        } else {
          return ZodiacSigns.AQUARIUS;
        }
        break;
      case 3:
        if (dayOfBirth > 21) {
          return ZodiacSigns.ARIES;
        } else {
          return ZodiacSigns.PISCES;
        }
        break;
      case 4:
        if (dayOfBirth > 20) {
          return ZodiacSigns.TAURUS;
        } else {
          return ZodiacSigns.ARIES;
        }
        break;
      case 5:
        if (dayOfBirth > 21) {
          return ZodiacSigns.GEMINI;
        } else {
          return ZodiacSigns.TAURUS;
        }
        break;
      case 6:
        if (dayOfBirth > 21) {
          return ZodiacSigns.CANCER;
        } else {
          return ZodiacSigns.GEMINI;
        }
        break;
      case 7:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LEO;
        } else {
          return ZodiacSigns.CANCER;
        }
        break;
      case 8:
        if (dayOfBirth > 23) {
          return ZodiacSigns.VIRGO;
        } else {
          return ZodiacSigns.LEO;
        }
        break;
      case 9:
        if (dayOfBirth > 23) {
          return ZodiacSigns.LIBRA;
        } else {
          return ZodiacSigns.VIRGO;
        }
        break;
      case 10:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SCORPIO;
        } else {
          return ZodiacSigns.LIBRA;
        }
        break;
      case 11:
        if (dayOfBirth > 23) {
          return ZodiacSigns.SAGITTARIUS;
        } else {
          return ZodiacSigns.SCORPIO;
        }
        break;
      case 12:
        if (dayOfBirth > 22) {
          return ZodiacSigns.CAPRICORN;
        } else {
          return ZodiacSigns.SAGITTARIUS;
        }
        break;
      default:
        return "null";
        break;
    }
  }
}
