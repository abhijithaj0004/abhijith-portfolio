/// Result of a contact form submission attempt.
class ContactResult {
  final bool success;
  final String message;

  const ContactResult({required this.success, required this.message});
}

/// Abstraction over "send a contact message somewhere." Swap the body of
/// [send] for a real integration (Formspree, EmailJS, Firebase Functions,
/// or a custom backend) without touching any UI code.
///
/// Deliberately does NOT hold API keys — those belong in a backend/service
/// endpoint config, never in Flutter Web client source.
abstract class ContactService {
  Future<ContactResult> send({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}

/// Default implementation used until a real backend is wired up. Simulates
/// network latency so the UI's loading/success states can be exercised end
/// to end. Replace with a real HTTP call (e.g. to a Formspree endpoint or
/// Firebase Cloud Function) when ready — see README "Configure contact
/// service".
class MockContactService implements ContactService {
  @override
  Future<ContactResult> send({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    await Future.delayed(const Duration(milliseconds: 900));

    // Example of where a real implementation would POST to an endpoint:
    //
    // final response = await http.post(
    //   Uri.parse('https://formspree.io/f/your-form-id'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'name': name,
    //     'email': email,
    //     'subject': subject,
    //     'message': message,
    //   }),
    // );
    // if (response.statusCode == 200) {
    //   return const ContactResult(success: true, message: 'Message sent!');
    // }
    // return const ContactResult(success: false, message: 'Something went wrong.');

    return const ContactResult(
      success: true,
      message:
          "Thanks for reaching out! This form isn't wired to a live "
          "backend yet — see the README to connect one.",
    );
  }
}
