import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:imgprc/utils/enums.dart';
import 'package:imgprc/utils/progress_image.dart';
import 'package:meta/meta.dart';
import 'dart:io';
part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.empty());
  ProgressImage progressImage = ProgressImage();
  File input = File("");
  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is ResetFilter) {
      yield FilterState.empty();
    }
    if (event is SetFilter) {
      print(event.filterType);
      switch (event.filterType) {
        case FilterType.Normal:
          return;
        case FilterType.Grey:
          try {
            yield state.copyWith(filterLoading: true);
            final output = await progressImage.convertToGreyImage(input);
            yield state.copyWith(
                imageEncode: output,
                currentFilter: event.filterType,
                filterLoading: false);
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Negative:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertToNavigateImage(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.RedGreenBlue:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertImageToRGB(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Sepia:
          try {
            yield state.copyWith(
              filterLoading: true,
            );

            final output = await progressImage.convertImageSepia(input);
            yield state.copyWith(
              imageEncode: output,
              filterLoading: false,
              currentFilter: event.filterType,
            );
          } catch (e) {
            print(e);
            yield state.copyWith(
              currentFilter: event.filterType,
              filterError: e.toString(),
            );
          }
          break;
        case FilterType.Mirror:
          // TODO: Handle this case.
          break;
      }
    }
  }
}
