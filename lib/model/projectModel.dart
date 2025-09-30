import 'package:portfolio_web/ViewModel/ProjectViewModel.dart';

List<Project> projects = [
  Project(
    title: "Expense Tracker",
    description: "Track daily expenses with Supabase backend & charts. ",
    link: "https://github.com/sahilmurti07/ExpenseTrackerApp",
    image: "assets/images/expense.png",
    techstack: ["Flutter", "Supabase", "Bloc", "FL Chart"],
  ),
  Project(
    title: "E-commerce App",
    description: "Full cart functionality with BLoC state management.",
    image: "assets/images/ecommerce.png",
    techstack: ["Flutter", "BLoC", "REST API"],
    link: "https://github.com/sahilmurti07/EcommerceApp",
  ),
];
