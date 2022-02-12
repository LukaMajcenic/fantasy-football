abstract class AdminActionsCubitState
{
  String message;

  AdminActionsCubitState([String? message]) : message = message ?? "Executing...";
}

class AdminActionsNotExecuting extends AdminActionsCubitState
{

}

class AdminActionsExecuting extends AdminActionsCubitState
{
  AdminActionsExecuting([String? message]) : super(message);
}