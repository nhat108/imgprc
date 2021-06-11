import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.empty());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetAlbum) {
      try {
        yield state.copyWith(
          getAlbumLoading: true,
        );

        /// init emoji
        final manifestContent = await DefaultAssetBundle.of(event.context)
            .loadString('AssetManifest.json');
        final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
        // >> To get paths you need these 2 lines

        final emoijPaths = manifestMap.keys
            .where((String key) => key.contains('assets/images/emoijs/'))
            .where((String key) => key.contains('.svg'))
            .toList();

        final List<Album> imageAlbums = await PhotoGallery.listAlbums(
          mediumType: MediumType.image,
        );
        List<MediaPage> mediums = [];
        for (int i = 0; i < imageAlbums.length; i++) {
          var data = await imageAlbums[i].listMedia();
          mediums.add(data);
        }

        if (event.getDefaultImage) {
          File file = await mediums.first.items.first.getFile();
          yield state.copyWith(
            imageSelected: file.path,
          );
        }
        yield state.copyWith(
            getAlbumLoading: false, albums: mediums, listEmoijPath: emoijPaths);
      } catch (e) {
        yield state.copyWith(
          getAlbumLoading: false,
          getAlbumError: e.toString(),
        );
      }
    }
    if (event is SelectMainImage) {
      var file = await event.medium.getFile();
      yield state.copyWith(imageSelected: file.path);
    }
  }
}
