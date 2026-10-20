import 'package:flutter/material.dart';
import 'package:patientapp/Care/model/Booking.dart';


class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [
    Booking(
      date: '20',
      month: 'JUN',
      tag: 'HOME NURSE',
      title: 'Post-operative nursing care',
      info: 'Friday, 10:30 AM · 60 minutes',
      status: 'Confirmed',
    ),
    Booking(
      date: '24',
      month: 'JUN',
      tag: 'LAB TEST',
      title: 'Thyroid health package',
      info: 'Tuesday, 8:00 AM · Fasting required',
      status: 'Scheduled',
    ),
  ];

  List<Booking> get bookings => _bookings;
  List<Booking> get upcoming => _bookings;
  List<Booking> get past => [];
  List<Booking> get cancelled => [];


}