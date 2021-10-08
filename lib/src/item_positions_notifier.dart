// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'item_positions_listener.dart';

/// Internal implementation of [ItemPositionsListener].
class ItemPositionsNotifier implements ItemPositionsListener {
  @override
  final ValueNotifier<Iterable<ItemPosition>> itemPositions = ValueNotifier([]);

  final ValueNotifier<double> viewportDimension = ValueNotifier(0);
  final ValueNotifier<bool> transitioningNotifier = ValueNotifier(false);

  List<ItemPosition> get sortedItemPositions =>
      itemPositions.value.toList()..sort((a, b) => a.index - b.index);

  Iterable<ItemPosition> get fullyVisibleItemPositions => sortedItemPositions
      .where((v) => v.itemLeadingEdge >= 0 && v.itemTrailingEdge <= 1);

  ItemPosition get trailingFullyVisibleItemPosition =>
      fullyVisibleItemPositions.first;

  ItemPosition get leadingFullyVisibleItemPosition =>
      fullyVisibleItemPositions.last;

  ItemPosition get trailingItemPosition =>
      sortedItemPositions.isNotEmpty ? sortedItemPositions.first : null;

  ItemPosition get leadingItemPosition =>
      sortedItemPositions.isNotEmpty ? sortedItemPositions.last : null;

  bool get isTransitioning => transitioningNotifier.value;
}
