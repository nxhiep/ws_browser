import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/helper/ex_value_builder.dart';
import 'package:worksheet_browser/helper/safe_state.dart';
import 'package:worksheet_browser/helper/set_value_notifier.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class ElementItem extends StatefulWidget {
  const ElementItem({
    Key? key,
    required this.item,
    required this.child,
    required this.constraints,
    this.tools,
    this.tapToEdit = false,
    this.operatState = OperatState.idle,
    this.canEdit = false,
    this.onDel,
    this.onSizeChanged,
    this.onOperatStateChanged,
    this.onOffsetChanged,
    this.onAngleChanged,
    this.onTap,
    this.caseStyle
  }) : super(key: key);

  @override
  ElementItemState createState() => ElementItemState();

  final Widget child;
  final CaseStyle? caseStyle;
  final BoxConstraints constraints;
  final ResourceItem item;
  final Widget? tools;
  final bool canEdit;
  final bool tapToEdit;
  final OperatState? operatState;
  final void Function()? onDel;
  final void Function()? onTap;
  final bool? Function(Size size)? onSizeChanged;
  final bool? Function(Offset offset)? onOffsetChanged;
  final bool? Function(double offset)? onAngleChanged;
  final bool? Function(OperatState)? onOperatStateChanged;
}

class ElementItemState extends State<ElementItem> with SafeState<ElementItem> {
  
  ResourceItem get item => widget.item;
  late SafeValueNotifier<ResourceItem> _config;
  late OperatState _operatState;
  CaseStyle get _caseStyle => widget.caseStyle ?? const CaseStyle();
  BoxConstraints get constraints => widget.constraints;

  @override
  void initState() {
    super.initState();
    _operatState = widget.operatState ?? OperatState.idle;
    _config = SafeValueNotifier<ResourceItem>(item);
  }

  @override
  void didUpdateWidget(covariant ElementItem oldWidget) {
    if (widget.operatState != null &&
        widget.operatState != oldWidget.operatState) {
      _operatState = widget.operatState!;
      safeSetState(() {});
      widget.onOperatStateChanged?.call(_operatState);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _config.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.tapToEdit) {
      if (_operatState != OperatState.editing) {
        _operatState = OperatState.editing;
        safeSetState(() {});
      }
    } else if (_operatState == OperatState.complate) {
      safeSetState(() => _operatState = OperatState.idle);
    }

    widget.onTap?.call();
    widget.onOperatStateChanged?.call(_operatState);
  }

  void _changeToIdle() {
    if (_operatState != OperatState.idle) {
      _operatState = OperatState.idle;
      widget.onOperatStateChanged?.call(_operatState);

      safeSetState(() {});
    }
  }

  void _moveHandle(DragUpdateDetails dud) {
    if (_operatState != OperatState.moving) {
      if (_operatState == OperatState.scaling ||
          _operatState == OperatState.roating) {
        _operatState = OperatState.moving;
      } else {
        _operatState = OperatState.moving;
        safeSetState(() {});
      }

      widget.onOperatStateChanged?.call(_operatState);
    }
    final double angle = _config.value.rotation;
    final double sinA = math.sin(-angle);
    final double cosA = math.cos(-angle);
    Offset d = dud.delta;
    final Offset changeTo = Offset(_config.value.x, _config.value.y).translate(d.dx, d.dy);
    d = Offset(sinA * d.dy + cosA * d.dx, cosA * d.dy - sinA * d.dx);
    final Offset realOffset = Offset(_config.value.x, _config.value.y).translate(d.dx, d.dy);
    if(realOffset.dx >= 0 && realOffset.dx <= (constraints.maxWidth - _config.value.width) 
      && realOffset.dy >= 0 && realOffset.dy <= (constraints.maxHeight - _config.value.height)) {
      _config.value.x = realOffset.dx;
      _config.value.y = realOffset.dy;
      _config.value = ResourceItem.copyWith(_config.value);
      widget.onOffsetChanged?.call(changeTo);
    }
  }

  void _scaleHandle(DragUpdateDetails dud) {
    if (_operatState != OperatState.scaling) {
      if (_operatState == OperatState.moving ||
          _operatState == OperatState.roating) {
        _operatState = OperatState.scaling;
      } else {
        _operatState = OperatState.scaling;
        safeSetState(() {});
      }

      widget.onOperatStateChanged?.call(_operatState);
    }

    final double angle = _config.value.rotation;
    final double fsina = math.sin(-angle);
    final double fcosa = math.cos(-angle);
    // final double sina = math.sin(angle);
    // final double cosa = math.cos(angle);

    // final Offset d = dud.delta;
    final Offset d = dud.globalPosition;
    // d = Offset(fsina * d.dy + fcosa * d.dx, fcosa * d.dy - fsina * d.dx);

    // print('delta:$d');

    // final Size size = _config.value.size!;
    // double w = size.width + d.dx;
    // double h = size.height + d.dy;

    final double min = _caseStyle.iconSize * 3;

    Offset start = Offset(_config.value.x, _config.value.y) +
        Offset(-_caseStyle.iconSize / 2, _caseStyle.iconSize * 2);
    start = Offset(fsina * start.dy + fcosa * start.dx,
        fcosa * start.dy - fsina * start.dx);

    double w = d.dx - start.dx;
    double h = d.dy - start.dy;

    if (w < min) w = min;
    if (h < min) h = min;

    Size s = Size(w, h);

    if (d.dx < 0 && s.width < min) s = Size(min, h);
    if (d.dy < 0 && s.height < min) s = Size(w, min);

    if (!(widget.onSizeChanged?.call(s) ?? true)) return;

    if (widget.caseStyle?.boxAspectRatio != null) {
      if (s.width < s.height) {
        _config.value.width = s.width;
        _config.value.height = s.width / widget.caseStyle!.boxAspectRatio!;
      } else {
        _config.value.width = s.height * widget.caseStyle!.boxAspectRatio!;
        _config.value.height = s.height;
      }
    } else {
      _config.value.width = s.width;
      _config.value.height = s.height;
    }

    _config.value = ResourceItem.copyWith(_config.value);
  }

  void _roateHandle(DragUpdateDetails dud) {
    if (_operatState != OperatState.roating) {
      if (_operatState == OperatState.moving ||
          _operatState == OperatState.scaling) {
        _operatState = OperatState.roating;
      } else {
        _operatState = OperatState.roating;
        safeSetState(() {});
      }

      widget.onOperatStateChanged?.call(_operatState);
    }

    final Offset start = Offset(_config.value.x, _config.value.y);
    final Offset global = dud.globalPosition.translate(
      _caseStyle.iconSize / 2,
      -_caseStyle.iconSize * 2.5,
    );
    final Size size = Size(_config.value.width, _config.value.height);
    final Offset center =
        Offset(start.dx + size.width / 2, start.dy + size.height / 2);
    final double l = (global - center).distance;
    final double s = (global.dy - center.dy).abs();

    double angle = math.asin(s / l);

    if (global.dx < center.dx) {
      if (global.dy < center.dy) {
        angle = math.pi + angle;
      } else {
        angle = math.pi - angle;
      }
    } else {
      if (global.dy < center.dy) {
        angle = 2 * math.pi - angle;
      }
    }

    if (!(widget.onAngleChanged?.call(angle) ?? true)) return;
    _config.value.rotation = angle;
    _config.value = ResourceItem.copyWith(_config.value);
  }

  void _turnBack() {
    if (_config.value.rotation != 0) {
      _config.value.rotation = 0;
      _config.value = ResourceItem.copyWith(_config.value);
    }
  }

  MouseCursor get _cursor {
    if (_operatState == OperatState.moving) {
      return SystemMouseCursors.grabbing;
    } else if (_operatState == OperatState.editing) {
      return SystemMouseCursors.click;
    }

    return SystemMouseCursors.grab;
  }

  @override
  Widget build(BuildContext context) {
    return ExValueBuilder<ResourceItem>(
      shouldRebuild: (ResourceItem p, ResourceItem n) {
        return Offset(p.x, p.y) != Offset(n.x, n.y) || p.rotation != n.rotation;
      },
      valueListenable: _config,
      child: MouseRegion(
        cursor: _cursor,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: _moveHandle,
          onPanEnd: (_) => _changeToIdle(),
          onTap: _onTap,
          child: Stack(children: <Widget>[
            _border,
            _child,
            if (widget.tools != null) _tools,
            if (widget.canEdit && _operatState != OperatState.complate) _edit,
            if (_operatState != OperatState.complate) _roate,
            if (_operatState != OperatState.complate) _check,
            if (widget.onDel != null && _operatState != OperatState.complate)
              _del,
            if (_operatState != OperatState.complate) _scale,
          ]),
        ),
      ),
      builder: (_, ResourceItem c, Widget? child) {
        return Positioned(
          top: c.y,
          left: c.x,
          child: Transform.rotate(
            angle: c.rotation,
            child: child,
          ),
        );
      },
    );
  }

  final List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.amber, Colors.indigo, Colors.cyanAccent];

  Widget get _child {
    Widget content = widget.child;
    return ExValueBuilder<ResourceItem>(
      shouldRebuild: (ResourceItem p, ResourceItem n) => Size(p.width, p.height) != Size(n.width, n.height),
      valueListenable: _config,
      child: Padding(
        padding: EdgeInsets.all(_caseStyle.iconSize / 2),
        child: content,
      ),
      builder: (_, ResourceItem c, Widget? child) {
        return SizedBox.fromSize(
          size: Size(c.width, c.height),
          child: child,
        );
      },
    );
  }

  Widget get _border {
    return Positioned(
      top: _caseStyle.iconSize / 2,
      bottom: _caseStyle.iconSize / 2,
      left: _caseStyle.iconSize / 2,
      right: _caseStyle.iconSize / 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _operatState == OperatState.complate
                ? Colors.transparent
                : _caseStyle.borderColor,
            width: _caseStyle.borderWidth,
          ),
        ),
      ),
    );
  }

  Widget get _edit {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (_operatState == OperatState.editing) {
            _operatState = OperatState.idle;
          } else {
            _operatState = OperatState.editing;
          }
          safeSetState(() {});
          widget.onOperatStateChanged?.call(_operatState);
        },
        child: _toolCase(
          Icon(_operatState == OperatState.editing
              ? Icons.border_color
              : Icons.edit),
        ),
      ),
    );
  }

  Widget get _del {
    return Positioned(
      top: 0,
      right: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onDel?.call(),
          child: _toolCase(const Icon(Icons.clear)),
        ),
      ),
    );
  }

  Widget get _scale {
    return Positioned(
      bottom: 0,
      right: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.resizeUpLeftDownRight,
        child: GestureDetector(
          onPanUpdate: _scaleHandle,
          onPanEnd: (_) => _changeToIdle(),
          child: _toolCase(
            const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.open_in_full_outlined),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _roate {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onPanUpdate: _roateHandle,
          onPanEnd: (_) => _changeToIdle(),
          onDoubleTap: _turnBack,
          child: _toolCase(
            const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.refresh),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _check {
    return Positioned(
      bottom: 0,
      left: 0,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (_operatState != OperatState.complate) {
              _operatState = OperatState.complate;
              safeSetState(() {});
              widget.onOperatStateChanged?.call(_operatState);
            }
          },
          child: _toolCase(const Icon(Icons.check)),
        ),
      ),
    );
  }

  Widget _toolCase(Widget child) {
    return Container(
      width: _caseStyle.iconSize,
      height: _caseStyle.iconSize,
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
          color: _caseStyle.iconColor,
          size: _caseStyle.iconSize * 0.6,
        ),
        child: child,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _caseStyle.borderColor,
      ),
    );
  }

  Widget get _tools {
    return Positioned(
      left: _caseStyle.iconSize / 2,
      top: _caseStyle.iconSize / 2,
      right: _caseStyle.iconSize / 2,
      bottom: _caseStyle.iconSize / 2,
      child: widget.tools!,
    );
  }
}
