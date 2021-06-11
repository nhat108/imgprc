part of 'tool_bloc.dart';

class ToolState extends Equatable {
  final ToolType currentToolType;

  ToolState({this.currentToolType});
  factory ToolState.empty() {
    return ToolState(
      currentToolType: ToolType.None,
    );
  }
  ToolState copyWith({
    final ToolType currentToolType,
  }) {
    return ToolState(
      currentToolType: currentToolType,
    );
  }

  @override
  List<Object> get props => [this.currentToolType];
}
