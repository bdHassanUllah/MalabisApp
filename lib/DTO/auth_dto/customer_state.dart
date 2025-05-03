abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerCreating extends CustomerState {}

class CustomerCreated extends CustomerState {
  final dynamic data;
  CustomerCreated(this.data);
}

class CustomerError extends CustomerState {
  final String message;
  CustomerError(this.message);
}
