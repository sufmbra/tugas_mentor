class ApiConfig {
  static const String baseUrl =
      'http://127.0.0.1:8000/api'; // Use your Laravel backend URL

  // Auth endpoints
  static const String registerUrl = '$baseUrl/register';
  static const String loginUrl = '$baseUrl/login';
  static const String logoutUrl = '$baseUrl/logout';

  // Todo endpoints
  static const String todosUrl = '$baseUrl/todos';
  static const String searchTodosUrl = '$baseUrl/todos/search';
  static const String sortTodosByPriorityUrl = '$baseUrl/todos/sort/prioritas';
  static const String checkDeadlinesUrl = '$baseUrl/todos/check-deadlines';

  // Category endpoints
  static const String categoriesUrl = '$baseUrl/categories';

  // Label endpoints
  static const String labelsUrl = '$baseUrl/labels';
}
