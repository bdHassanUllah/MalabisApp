class CreateCustomerRequestDto {
  final String email;
  final String firstName;
  final String lastName;
  final String username;

  CreateCustomerRequestDto({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
    };
  }
}
