import 'package:twilio_flutter/twilio_flutter.dart';

class TwilioWhatsappSMSService {
  TwilioFlutter? twilioFlutter;

  TwilioWhatsappSMSService() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC577b22809a268ae40674c7ec92946c9e',
        authToken: 'eaffc68cb8ce2a75367ac1cd491bc261',
        twilioNumber: '+16084203635');
  }

  void sendSms(String phone, String msg) =>
      twilioFlutter?.sendSMS(toNumber: phone, messageBody: msg);

  void sendWhatsapp(String phone, String msg) =>
      twilioFlutter?.sendWhatsApp(toNumber: phone, messageBody: msg);
}
