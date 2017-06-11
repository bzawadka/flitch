// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services.dart' as services;
import 'package:twitch/twitch.dart';

class TopGameList extends StatelessWidget {
  const TopGameList();

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new FutureBuilder<Response<TopGame>>(
      future: services.twitch.getTopGames(),
      builder: (context, snapshot) {
        return new GridView.count(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
            childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
            children: snapshot != null && snapshot.data != null
                ? snapshot.data
                    .map((topGame) => new _GameItem(topGame))
                    .toList()
                : []);
      },
    );
  }
}

class _GameItem extends StatelessWidget {
  final TopGame _topGame;

  const _GameItem(this._topGame);

  @override
  Widget build(_) {
    return new GridTile(
      child: new Hero(
        tag: _topGame.game.name,
        child: new Image.network(
          _topGame.game.box.large,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
