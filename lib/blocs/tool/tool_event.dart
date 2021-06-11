part of 'tool_bloc.dart';

abstract class ToolEvent {}

class SelectTool extends ToolEvent {
  final ToolType toolType;

  SelectTool({this.toolType});
}
