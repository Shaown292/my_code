import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding = EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

typedef _OnMenuStateChangeFn = void Function(bool isOpen);

typedef _SearchMatchFn = bool Function(
  DropdownMenuItem item,
  String searchValue,
);

_SearchMatchFn _defaultSearchMatchFn =
    (item, searchValue) => item.value.toString().toLowerCase().contains(searchValue.toLowerCase());

class _DropdownMenuItemButton<T> extends StatefulWidget {
  const _DropdownMenuItemButton({
    super.key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.itemIndex,
    required this.enableFeedback,
    this.customItemsHeights,
    this.customItemsHeight,
    this.isFocused,
  });

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final int itemIndex;
  final bool enableFeedback;
  final List<double>? customItemsHeights;
  final double? customItemsHeight;
  final bool? Function(bool?)? isFocused;

  @override
  _DropdownMenuItemButtonState<T> createState() => _DropdownMenuItemButtonState<T>();
}

class _DropdownMenuItemButtonState<T> extends State<_DropdownMenuItemButton<T>> {
  void _handleFocusChange(bool focused) {
    widget.isFocused?.call(focused);
    final bool inTraditionalMode;
    // print('hhhhhhhhh $focused');
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
        widget.buttonRect,
        widget.constraints.maxHeight,
        widget.itemIndex,
      );
      widget.route.scrollController!.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownMenuItem<T> dropdownMenuItem = widget.route.items[widget.itemIndex].item!;

    dropdownMenuItem.onTap?.call();

    Navigator.pop(
      context,
      _DropdownRouteResult<T>(dropdownMenuItem.value),
    );
  }

  static const Map<ShortcutActivator, Intent> _webShortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowDown): DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp): DirectionalFocusIntent(TraversalDirection.up),
  };

  @override
  Widget build(BuildContext context) {
    final DropdownMenuItem<T> dropdownMenuItem = widget.route.items[widget.itemIndex].item!;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    final double start = clampDouble(0.5 + (widget.itemIndex + 1) * unit, 0.0, 1.0);
    final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
    final CurvedAnimation opacity =
        CurvedAnimation(parent: widget.route.animation!, curve: Interval(start, end));

    Widget child = Container(
      padding: widget.padding,
      height: widget.customItemsHeights == null
          ? widget.route.itemHeight
          : widget.customItemsHeights![widget.itemIndex],
      child: widget.route.items[widget.itemIndex],
    );
    if (dropdownMenuItem.enabled) {
      final _isSelectedItem =
          !widget.route.isNoSelectedItem && widget.itemIndex == widget.route.selectedIndex;
      child = InkWell(
        autofocus: _isSelectedItem,
        enableFeedback: widget.enableFeedback,
        onTap: _handleOnTap,
        onFocusChange: _handleFocusChange,
        child: Container(
          color: _isSelectedItem ? widget.route.selectedItemHighlightColor : null,
          child: child,
        ),
      );
    }
    child = FadeTransition(opacity: opacity, child: child);
    if (kIsWeb && dropdownMenuItem.enabled) {
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({ //checked
    super.key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.enableFeedback,
    required this.itemHeight,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    this.customItemsHeights,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
  });

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final bool enableFeedback;
  final double itemHeight;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final List<double>? customItemsHeights;
  final TextEditingController? searchController;
  final Widget? searchInnerWidget;
  final _SearchMatchFn? searchMatchFn;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> { ///checked [Constrained-Box]
  late CurvedAnimation _fadeOpacity;
  late CurvedAnimation _resize;
  late List<Widget> _children;
  late _SearchMatchFn _searchMatchFn;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
    if (widget.searchController == null) {
      _children = <Widget>[
        for (int index = 0; index < widget.route.items.length; ++index)
          _DropdownMenuItemButton<T>(
            route: widget.route,
            padding: widget.padding,
            buttonRect: widget.buttonRect,
            constraints: widget.constraints,
            itemIndex: index,
            enableFeedback: widget.enableFeedback,
            customItemsHeights: widget.customItemsHeights,
          ),
      ];
    } else {
      _searchMatchFn = widget.searchMatchFn ?? _defaultSearchMatchFn;
      _children = _getSearchItems();
      widget.searchController?.addListener(_updateSearchItems);
    }
  }

  void _updateSearchItems() {
    _children = _getSearchItems();
    setState(() {});
  }

  List<Widget> _getSearchItems() {
    return <Widget>[
      for (int index = 0; index < widget.route.items.length; ++index)
        if (_searchMatchFn(widget.route.items[index].item!, widget.searchController!.text))
          _DropdownMenuItemButton<T>(
            route: widget.route,
            padding: widget.padding,
            buttonRect: widget.buttonRect,
            constraints: widget.constraints,
            itemIndex: index,
            enableFeedback: widget.enableFeedback,
            customItemsHeights: widget.customItemsHeights,
          ),
    ];
  }

  @override
  void dispose() {
    _fadeOpacity.dispose();
    _resize.dispose();
    widget.searchController?.removeListener(_updateSearchItems);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final _DropdownRoute<T> route = widget.route;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 14),
        FadeTransition(
          opacity: _fadeOpacity,
          child: ConstrainedBox( /// main
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: Get.height/1.35,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                type: MaterialType.transparency,
                textStyle: route.style,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.searchInnerWidget != null) widget.searchInnerWidget!,
                    Flexible(
                      child: PrimaryScrollController(
                        controller: widget.route.scrollController!,
                        child: Scrollbar(
                          radius: widget.scrollbarRadius,
                          thickness: widget.scrollbarThickness,
                          thumbVisibility: widget.scrollbarAlwaysShow,
                          child: ListView(
                            primary: true,
                            padding: widget.dropdownPadding ?? kMaterialListPadding,
                            shrinkWrap: true,
                            children: _children,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    required this.buttonRect,
    required this.route,
    required this.textDirection,
    required this.itemHeight,
    this.itemWidth,
    required this.offset,
  });

  final Rect buttonRect;
  final _DropdownRoute<T> route;
  final TextDirection? textDirection;
  final double itemHeight;
  final double? itemWidth;
  final Offset offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = math.max(0.0, constraints.maxHeight - 2 * itemHeight);
    if (route.menuMaxHeight != null && route.menuMaxHeight! <= maxHeight) {
      maxHeight = route.menuMaxHeight!;
    }
    final double width = itemWidth ?? math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits =
        route.getMenuLimits(buttonRect, size.height, route.selectedIndex);

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    final double left;
    switch (textDirection!) {
      case TextDirection.rtl:
        left = clampDouble(buttonRect.right + offset.dx, 0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = clampDouble(buttonRect.left + offset.dx, 0.0, size.width - childSize.width);
        break;
    }

    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect || textDirection != oldDelegate.textDirection;
  }
}


@immutable
class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T? result;

  @override
  bool operator ==(Object other) {
    return other is _DropdownRouteResult<T> && other.result == result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    required this.items,
    required this.padding,
    required this.buttonRect,
    required this.selectedIndex,
    required this.isNoSelectedItem,
    this.selectedItemHighlightColor,
    this.elevation = 8,
    required this.capturedThemes,
    required this.style,
    required this.barrierDismissible,
    this.barrierColor,
    this.barrierLabel,
    required this.enableFeedback,
    required this.itemHeight,
    this.itemWidth,
    this.menuMaxHeight,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    required this.showAboveButton,
    this.customItemsHeights,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
  }) : itemHeights = customItemsHeights ?? List<double>.filled(items.length, itemHeight);

  final List<_MenuItem<T>> items;
  final EdgeInsetsGeometry padding;
  final ValueNotifier<Rect?> buttonRect;
  final int selectedIndex;
  final bool isNoSelectedItem;
  final Color? selectedItemHighlightColor;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle style;
  final bool enableFeedback;
  final double itemHeight;
  final double? itemWidth;
  final double? menuMaxHeight;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool showAboveButton;
  final List<double>? customItemsHeights;
  final TextEditingController? searchController;
  final Widget? searchInnerWidget;
  final _SearchMatchFn? searchMatchFn;

  final List<double> itemHeights;
  ScrollController? scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ValueListenableBuilder<Rect?>(
          valueListenable: buttonRect,
          builder: (context, rect, _) {
            return _DropdownRoutePage<T>(
              route: this,
              constraints: constraints,
              items: items,
              padding: padding,
              buttonRect: rect!,
              selectedIndex: selectedIndex,
              elevation: elevation,
              capturedThemes: capturedThemes,
              style: style,
              enableFeedback: enableFeedback,
              dropdownDecoration: dropdownDecoration,
              dropdownPadding: dropdownPadding,
              menuMaxHeight: menuMaxHeight,
              itemHeight: itemHeight,
              itemWidth: itemWidth,
              scrollbarRadius: scrollbarRadius,
              scrollbarThickness: scrollbarThickness,
              scrollbarAlwaysShow: scrollbarAlwaysShow,
              offset: offset,
              customItemsHeights: customItemsHeights,
              searchController: searchController,
              searchInnerWidget: searchInnerWidget,
              searchMatchFn: searchMatchFn,
            );
          },
        );
      },
    );
  }

  void _dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }

  double getItemOffset(int index, double paddingTop) {
    double offset = paddingTop;
    if (items.isNotEmpty && index > 0) {
      assert(items.length == itemHeights.length);
      offset +=
          itemHeights.sublist(0, index).reduce((double total, double height) => total + height);
    }
    return offset;
  }

  _MenuLimits getMenuLimits(Rect buttonRect, double availableHeight, int index) {
    double computedMaxHeight = availableHeight - 2.0 * itemHeight;
    if (menuMaxHeight != null) {
      computedMaxHeight = math.min(computedMaxHeight, menuMaxHeight!);
    }
    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);
    final double selectedItemOffset = getItemOffset(
      index,
      dropdownPadding != null ? dropdownPadding!.resolve(null).top : kMaterialListPadding.top,
    );

    final double topLimit = math.min(itemHeight, buttonTop);
    final double bottomLimit = math.max(availableHeight, buttonBottom);
    double menuTop = showAboveButton ? buttonTop - offset.dy : buttonBottom - offset.dy;
    double preferredMenuHeight = dropdownPadding?.vertical ?? kMaterialListPadding.vertical;
    if (items.isNotEmpty) {
      preferredMenuHeight += itemHeights.reduce((double total, double height) => total + height);
    }

    final double menuHeight = math.min(computedMaxHeight, preferredMenuHeight);
    double menuBottom = menuTop + menuHeight;

    if (menuTop < topLimit) {
      menuTop = math.min(buttonTop, topLimit);
      menuBottom = menuTop + menuHeight;
    }

    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    if (menuBottom - itemHeights[selectedIndex] / 2.0 < buttonBottom - buttonRect.height / 2.0) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    double scrollOffset = 0;
    if (preferredMenuHeight > computedMaxHeight) {
      scrollOffset =
          math.max(0.0, selectedItemOffset - (menuHeight / 2) + (itemHeights[selectedIndex] / 2));
      scrollOffset = math.min(scrollOffset, preferredMenuHeight - menuHeight);
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }
}

class _DropdownRoutePage<T> extends StatelessWidget {
  const _DropdownRoutePage({
    super.key,
    required this.route,
    required this.constraints,
    this.items,
    required this.padding,
    required this.buttonRect,
    required this.selectedIndex,
    this.elevation = 8,
    required this.capturedThemes,
    this.style,
    required this.enableFeedback,
    this.dropdownDecoration,
    this.dropdownPadding,
    this.menuMaxHeight,
    required this.itemHeight,
    this.itemWidth,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    required this.offset,
    this.customItemsHeights,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
  });

  final _DropdownRoute<T> route;
  final BoxConstraints constraints;
  final List<_MenuItem<T>>? items;
  final EdgeInsetsGeometry padding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final bool enableFeedback;
  final BoxDecoration? dropdownDecoration;
  final EdgeInsetsGeometry? dropdownPadding;
  final double? menuMaxHeight;
  final double itemHeight;
  final double? itemWidth;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final List<double>? customItemsHeights;
  final TextEditingController? searchController;
  final Widget? searchInnerWidget;
  final _SearchMatchFn? searchMatchFn;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    if (route.scrollController == null) {
      final _MenuLimits menuLimits =
          route.getMenuLimits(buttonRect, constraints.maxHeight, selectedIndex);
      route.scrollController = ScrollController(initialScrollOffset: menuLimits.scrollOffset);
    }

    final TextDirection? textDirection = Directionality.maybeOf(context);
    final Widget menu = _DropdownMenu<T>(
      route: route,
      padding: padding.resolve(textDirection),
      buttonRect: buttonRect,
      constraints: constraints,
      enableFeedback: enableFeedback,
      itemHeight: itemHeight,
      dropdownDecoration: dropdownDecoration,
      dropdownPadding: dropdownPadding,
      scrollbarRadius: scrollbarRadius,
      scrollbarThickness: scrollbarThickness,
      scrollbarAlwaysShow: scrollbarAlwaysShow,
      offset: offset,
      customItemsHeights: customItemsHeights,
      searchController: searchController,
      searchInnerWidget: searchInnerWidget,
      searchMatchFn: searchMatchFn,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              buttonRect: buttonRect,
              route: route,
              textDirection: textDirection,
              itemHeight: itemHeight,
              itemWidth: itemWidth,
              offset: offset,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _MenuItem<T> extends SingleChildRenderObjectWidget {
  const _MenuItem({
    super.key,
    required this.onLayout,
    required this.item,
  }) : super(child: item);

  final ValueChanged<Size> onLayout;
  final DropdownMenuItem<T>? item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child]) : super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}


class _DropdownMenuItemContainer extends StatelessWidget {
  const _DropdownMenuItemContainer({
    Key? key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: _kMenuItemHeight),
      alignment: alignment,
      child: child,
    );
  }
}

class DropdownButtonNew<T> extends StatefulWidget {

  DropdownButtonNew({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onMenuStateChange,
    this.dropdownElevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconOnClick,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.itemPadding,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.selectedItemHighlightColor,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.customButton,
    this.customItemsHeights,
    this.openWithLongPress = false,
    this.dropdownOverButton = false,
    this.dropdownFullScreen = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownMenuItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        assert(
          customItemsHeights == null ||
              items == null ||
              items.isEmpty ||
              customItemsHeights.length == items.length,
          "customItemsHeights list should have the same length of items list",
        ),
        formFieldCallBack = null;

  DropdownButtonNew._formField({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    required this.onChanged,
    this.onMenuStateChange,
    this.dropdownElevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconOnClick,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.itemPadding,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.selectedItemHighlightColor,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset,
    this.customButton,
    this.customItemsHeights,
    this.openWithLongPress = false,
    this.dropdownOverButton = false,
    this.dropdownFullScreen = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.searchController,
    this.searchInnerWidget,
    this.searchMatchFn,
    this.formFieldCallBack,
  }) : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownMenuItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButtonFormField]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        );

  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final Color? selectedItemHighlightColor;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset? offset;
  final Widget? customButton;
  final List<double>? customItemsHeights;
  final bool openWithLongPress;
  final bool dropdownOverButton;
  final bool dropdownFullScreen;
  final Widget? iconOnClick;
  final _OnMenuStateChangeFn? onMenuStateChange;
  final bool barrierDismissible;
  final Color? barrierColor;
  final String? barrierLabel;
  final TextEditingController? searchController;
  final Widget? searchInnerWidget;
  final _SearchMatchFn? searchMatchFn;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final int dropdownElevation;
  final TextStyle? style;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final double? dropdownMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final _OnMenuStateChangeFn? formFieldCallBack;

  @override
  State<DropdownButtonNew<T>> createState() => DropdownButtonNewState<T>();
}

class DropdownButtonNewState<T> extends State<DropdownButtonNew<T>> with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;

  FocusNode? get focusNode => widget.focusNode ?? _internalNode;
  bool _hasPrimaryFocus = false;
  late Map<Type, Action<Intent>> _actionMap;
  bool _isMenuOpen = false;
  final _rect = ValueNotifier<Rect?>(null);
  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
    focusNode!.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeDropdownRoute();
    focusNode!.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode!.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      });
    }
  }

  @override
  void didUpdateWidget(DropdownButtonNew<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      focusNode!.addListener(_handleFocusChanged);
    }
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (widget.items == null ||
        widget.items!.isEmpty ||
        (widget.value == null &&
            widget.items!
                .where((DropdownMenuItem<T> item) => item.enabled && item.value == widget.value)
                .isEmpty)) {
      _selectedIndex = null;
      return;
    }

    assert(
        widget.items!.where((DropdownMenuItem<T> item) => item.value == widget.value).length == 1);
    for (int itemIndex = 0; itemIndex < widget.items!.length; itemIndex++) {
      if (widget.items![itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  @override
  void didChangeMetrics() {
    if (_rect.value == null) return;
    final _newRect = _getRect();
    if (_rect.value!.top == _newRect.top) return;
    _rect.value = _newRect;
  }

  TextStyle? get _textStyle => widget.style ?? Theme.of(context).textTheme.titleMedium;

  Rect _getRect() {
    final TextDirection? textDirection = Directionality.maybeOf(context);
    const EdgeInsetsGeometry menuMargin = EdgeInsets.zero;
    final NavigatorState navigator =
        Navigator.of(context, rootNavigator: widget.dropdownFullScreen);

    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect =
        itemBox.localToGlobal(Offset.zero, ancestor: navigator.context.findRenderObject()) &
            itemBox.size;

    return menuMargin.resolve(textDirection).inflateRect(itemRect);
  }

  void _handleTap() {
    final TextDirection? textDirection = Directionality.maybeOf(context);

    final List<_MenuItem<T>> menuItems = <_MenuItem<T>>[
      for (int index = 0; index < widget.items!.length; index += 1)
        _MenuItem<T>(
          item: widget.items![index],
          onLayout: (Size size) {
            if (_dropdownRoute == null) return;

            _dropdownRoute!.itemHeights[index] = size.height;
          },
        ),
    ];

    final NavigatorState navigator =
        Navigator.of(context, rootNavigator: widget.dropdownFullScreen);
    assert(_dropdownRoute == null);
    _rect.value = _getRect();
    _dropdownRoute = _DropdownRoute<T>(
      items: menuItems,
      buttonRect: _rect,
      padding: widget.itemPadding ?? _kMenuItemPadding.resolve(textDirection),
      selectedIndex: _selectedIndex ?? 0,
      isNoSelectedItem: _selectedIndex == null,
      selectedItemHighlightColor: widget.selectedItemHighlightColor,
      elevation: widget.dropdownElevation,
      capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
      style: _textStyle!,
      barrierDismissible: widget.barrierDismissible,
      barrierColor: widget.barrierColor,
      barrierLabel:
          widget.barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel,
      enableFeedback: widget.enableFeedback ?? true,
      itemHeight: widget.itemHeight,
      itemWidth: widget.dropdownWidth,
      menuMaxHeight: widget.dropdownMaxHeight,
      dropdownDecoration: widget.dropdownDecoration,
      dropdownPadding: widget.dropdownPadding,
      scrollbarRadius: widget.scrollbarRadius,
      scrollbarThickness: widget.scrollbarThickness,
      scrollbarAlwaysShow: widget.scrollbarAlwaysShow,
      offset: widget.offset ?? const Offset(0, 0),
      showAboveButton: widget.dropdownOverButton,
      customItemsHeights: widget.customItemsHeights,
      searchController: widget.searchController,
      searchInnerWidget: widget.searchInnerWidget,
      searchMatchFn: widget.searchMatchFn,
    );

    _isMenuOpen = true;
    focusNode?.requestFocus();
    navigator.push(_dropdownRoute!).then<void>((_DropdownRouteResult<T>? newValue) {
      _removeDropdownRoute();
      _isMenuOpen = false;
      widget.onMenuStateChange?.call(false);
      widget.formFieldCallBack?.call(false);
      if (!mounted || newValue == null) return;
      widget.onChanged?.call(newValue.result);
    });

    widget.onMenuStateChange?.call(true);
    widget.formFieldCallBack?.call(true);
  }

  void callTap() => _handleTap();

  double get _denseButtonHeight {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double fontSize =
        _textStyle!.fontSize ?? Theme.of(context).textTheme.titleMedium!.fontSize!;
    final double scaledFontSize = textScaleFactor * fontSize;
    return math.max(scaledFontSize, math.max(widget.iconSize, _kDenseButtonHeight));
  }

  Color get _iconColor {
    if (_enabled) {
      if (widget.iconEnabledColor != null) return widget.iconEnabledColor!;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (widget.iconDisabledColor != null) return widget.iconDisabledColor!;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }
  }

  bool get _enabled => widget.items != null && widget.items!.isNotEmpty && widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation? result = MediaQuery.maybeOf(context)?.orientation;
    if (result == null) {
      final Size size = WidgetsBinding.instance.window.physicalSize;
      result = size.width > size.height ? Orientation.landscape : Orientation.portrait;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }


    final List<Widget> items = widget.selectedItemBuilder == null
        ? (widget.items != null ? List<Widget>.of(widget.items!) : <Widget>[])
        : List<Widget>.of(widget.selectedItemBuilder!(context));

    int? hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      final Widget displayedHint = _enabled ? widget.hint! : widget.disabledHint ?? widget.hint!;

      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle!.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          ignoringSemantics: false,
          child: _DropdownMenuItemContainer(
            alignment: widget.alignment,
            child: displayedHint,
          ),
        ),
      ));
    }

    final EdgeInsetsGeometry padding =
        ButtonTheme.of(context).alignedDropdown ? _kAlignedButtonPadding : _kUnalignedButtonPadding;

    final Widget innerItemsWidget;
    if (items.isEmpty) {
      innerItemsWidget = const SizedBox.shrink();
    } else {
      innerItemsWidget = IndexedStack(
        index: _selectedIndex ?? hintIndex,
        alignment: widget.alignment,
        children: widget.isDense
            ? items
            : items.map((Widget item) {
                return SizedBox(height: widget.itemHeight, child: item);
              }).toList(),
      );
    }

    const Icon defaultIcon = Icon(Icons.arrow_drop_down);

    Widget result = DefaultTextStyle(
      style: _enabled ? _textStyle! : _textStyle!.copyWith(color: Theme.of(context).disabledColor),
      child: widget.customButton ??
          Container(
            decoration: widget.buttonDecoration?.copyWith(
              boxShadow: widget.buttonDecoration!.boxShadow ??
                  kElevationToShadow[widget.buttonElevation ?? 0],
            ),
            padding: widget.buttonPadding ?? padding.resolve(Directionality.of(context)),
            height: widget.buttonHeight ?? (widget.isDense ? _denseButtonHeight : null),
            width: widget.buttonWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.isExpanded) Expanded(child: innerItemsWidget) else innerItemsWidget,
                IconTheme(
                  data: IconThemeData(
                    color: _iconColor,
                    size: widget.iconSize,
                  ),
                  child: widget.iconOnClick != null
                      ? _isMenuOpen
                          ? widget.iconOnClick!
                          : widget.icon!
                      : widget.icon ?? defaultIcon,
                ),
              ],
            ),
          ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom = widget.isDense ? 0.0 : 8.0;
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: widget.underline ??
                Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFBDBDBD),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      );
    }

    final MouseCursor effectiveMouseCursor = MaterialStateProperty.resolveAs<MouseCursor>(
      MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!_enabled) MaterialState.disabled,
      },
    );

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: InkWell(
          mouseCursor: effectiveMouseCursor,
          onTap: _enabled && !widget.openWithLongPress ? _handleTap : null,
          onLongPress: _enabled && widget.openWithLongPress ? _handleTap : null,
          canRequestFocus: _enabled,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          focusColor:
              widget.buttonDecoration?.color ?? widget.focusColor ?? Theme.of(context).focusColor,
          enableFeedback: false,
          borderRadius: widget.buttonDecoration?.borderRadius?.resolve(Directionality.of(context)),
          child: result,
        ),
      ),
    );
  }
}

class DropdownButtonFormFieldNew<T> extends FormField<T> {

  DropdownButtonFormFieldNew({
    super.key,
    required List<DropdownMenuItem<T>>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    T? value,
    Widget? hint,
    Widget? disabledHint,
    this.onChanged,
    int dropdownElevation = 8,
    TextStyle? style,
    Widget? icon,
    Widget? iconOnClick,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight = kMinInteractiveDimension,
    Color? focusColor,
    FocusNode? focusNode,
    bool autofocus = false,
    InputDecoration? decoration,
    super.onSaved,
    super.validator,
    AutovalidateMode? autovalidateMode,
    double? dropdownMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    double? buttonHeight,
    double? buttonWidth,
    EdgeInsetsGeometry? buttonPadding,
    BoxDecoration? buttonDecoration,
    int? buttonElevation,
    EdgeInsetsGeometry? itemPadding,
    double? dropdownWidth,
    EdgeInsetsGeometry? dropdownPadding,
    BoxDecoration? dropdownDecoration,
    Color? selectedItemHighlightColor,
    Radius? scrollbarRadius,
    double? scrollbarThickness,
    bool? scrollbarAlwaysShow,
    Offset? offset,
    Widget? customButton,
    List<double>? customItemsHeights,
    bool openWithLongPress = false,
    bool dropdownOverButton = false,
    bool dropdownFullScreen = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    TextEditingController? searchController,
    Widget? searchInnerWidget,
    _SearchMatchFn? searchMatchFn,
    _OnMenuStateChangeFn? onMenuStateChange,
  })  : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((DropdownMenuItem<T> item) {
                    return item.value == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value: "
          '$value. \n'
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        decoration = decoration ?? InputDecoration(focusColor: focusColor),
        super(
          initialValue: value,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            final _DropdownButtonFormFieldState<T> state =
                field as _DropdownButtonFormFieldState<T>;
            final InputDecoration decorationArg =
                decoration ?? InputDecoration(focusColor: focusColor);
            final InputDecoration effectiveDecoration = decorationArg.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            final bool showSelectedItem = items != null &&
                items.where((DropdownMenuItem<T> item) => item.value == state.value).isNotEmpty;
            bool isHintOrDisabledHintAvailable() {
              final bool isDropdownDisabled = onChanged == null || (items == null || items.isEmpty);
              if (isDropdownDisabled) {
                return hint != null || disabledHint != null;
              } else {
                return hint != null;
              }
            }

            final bool isEmpty = !showSelectedItem && !isHintOrDisabledHintAvailable();

            bool hasFocus = false;

            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return InputDecorator(
                    decoration: effectiveDecoration.copyWith(errorText: field.errorText),
                    isEmpty: isEmpty,
                    isFocused: hasFocus,
                    textAlignVertical: TextAlignVertical.bottom,
                    child: SizedBox(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonNew._formField(
                          items: items,
                          selectedItemBuilder: selectedItemBuilder,
                          value: state.value,
                          hint: hint,
                          disabledHint: disabledHint,
                          onChanged: onChanged == null ? null : state.didChange,
                          dropdownElevation: dropdownElevation,
                          style: style,
                          icon: icon,
                          iconOnClick: iconOnClick,
                          iconDisabledColor: iconDisabledColor,
                          iconEnabledColor: iconEnabledColor,
                          iconSize: iconSize,
                          isDense: isDense,
                          isExpanded: isExpanded,
                          itemHeight: itemHeight,
                          focusColor: focusColor,
                          focusNode: focusNode,
                          autofocus: autofocus,
                          dropdownMaxHeight: dropdownMaxHeight,
                          enableFeedback: enableFeedback,
                          alignment: alignment,
                          buttonHeight: buttonHeight,
                          buttonWidth: buttonWidth,
                          buttonPadding: buttonPadding,
                          buttonDecoration: buttonDecoration,
                          buttonElevation: buttonElevation,
                          itemPadding: itemPadding,
                          dropdownWidth: dropdownWidth,
                          dropdownPadding: dropdownPadding,
                          dropdownDecoration: dropdownDecoration,
                          selectedItemHighlightColor: selectedItemHighlightColor,
                          scrollbarRadius: scrollbarRadius,
                          scrollbarThickness: scrollbarThickness,
                          scrollbarAlwaysShow: scrollbarAlwaysShow,
                          offset: offset,
                          customButton: customButton,
                          customItemsHeights: customItemsHeights,
                          openWithLongPress: openWithLongPress,
                          dropdownOverButton: dropdownOverButton,
                          dropdownFullScreen: dropdownFullScreen,
                          onMenuStateChange: onMenuStateChange,
                          barrierDismissible: barrierDismissible,
                          barrierColor: barrierColor,
                          barrierLabel: barrierLabel,
                          searchController: searchController,
                          searchInnerWidget: searchInnerWidget,
                          searchMatchFn: searchMatchFn,
                          formFieldCallBack: (isOpen) {
                            hasFocus = isOpen;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  final ValueChanged<T?>? onChanged;
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  void didChange(T? value) {
    super.didChange(value);
    final DropdownButtonFormFieldNew<T> dropdownButtonFormField =
        widget as DropdownButtonFormFieldNew<T>;
    assert(dropdownButtonFormField.onChanged != null);
    dropdownButtonFormField.onChanged!(value);
  }

  @override
  void didUpdateWidget(DropdownButtonFormFieldNew<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
