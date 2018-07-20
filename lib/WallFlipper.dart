import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hangtimer/Wall.dart';
import 'package:hangtimer/wall_data.dart';

class WallFlipper extends StatefulWidget {

  final List<WallViewModel> walls;
  final Function(double scrollPercent) onScroll;

  WallFlipper({
    this.walls,
    this.onScroll,
});


  @override
  _WallFlipperState createState() => _WallFlipperState();
}

class _WallFlipperState extends State<WallFlipper> with TickerProviderStateMixin{
  double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double finishScrollStart;
  double finishScrollEnd;
  AnimationController finishScrollController;


  @override
  void initState() {
    super.initState();

    finishScrollController = new AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
    )
    ..addListener((){
      setState(() {
       scrollPercent = lerpDouble(finishScrollStart, finishScrollEnd, finishScrollController.value);

       if (widget.onScroll != null) {
         widget.onScroll(scrollPercent);
       }
      });
    });
  }


  @override
  void dispose() {
    finishScrollController.dispose();
    super.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }


  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currentDrag = details.globalPosition;
    final dragDistance = currentDrag.dx - startDrag.dx;
    final singleWallDragPercent = dragDistance / context.size.width;

    setState(() {
      scrollPercent = ( startDragPercentScroll + ( -singleWallDragPercent / widget.walls.length))
          .clamp(0.0, 1 - (1/widget.walls.length));

      if (widget.onScroll != null) {
        widget.onScroll(scrollPercent);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {

    finishScrollStart = scrollPercent;
    finishScrollEnd = (scrollPercent * widget.walls.length).round() / widget.walls.length;
    finishScrollController.forward(from: 0.0);

    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }

  Matrix4 _buildWallProjection(double scrollPercent){

    final perspective = 0.002;
    final radius = 1.0;
    final angle = scrollPercent * pi /8;
    final horizontalTranslation = 0.0;
    Matrix4 projection = new Matrix4.identity()
      ..setEntry(0,0, 1/radius)
      ..setEntry(1, 1, 1/radius)
      ..setEntry(3, 2, -perspective)
      ..setEntry(2, 3, -radius)
      ..setEntry(3, 3, perspective * radius + 1.0)
      ..setEntry(1, 2, -radius)
      ..setEntry(2, 1, -perspective);


    final rotationPointMultiplier = angle > 0.0 ? angle / angle.abs() : 1.0;

    projection *= new Matrix4.translationValues(
      horizontalTranslation + ( rotationPointMultiplier * 300), 0.0, 0.0) *
    new Matrix4.rotationY(angle) *
    new Matrix4.translationValues(0.0, 0.0, radius) *
    new Matrix4.translationValues(-rotationPointMultiplier * 300, 0.0, 0.0);

    return projection;

  }


  Widget _buildWall(WallViewModel viewModel, int wallIndex, wallCount, double scrollPercent) {

    final wallScrollPercent =  scrollPercent / (1 / wallCount);
    final parallax = scrollPercent - (wallIndex / wallCount);

    return FractionalTranslation(
      translation: new Offset(wallIndex - wallScrollPercent, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Transform(
          transform: _buildWallProjection(wallScrollPercent - wallIndex),
          child: Wall(
              viewModel: viewModel,
              parallaxPercent: parallax,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWalls(){
    final wallCount = widget.walls.length;
    int index = -1;
    return widget.walls.map((WallViewModel viewModel) {
      index++;
      return _buildWall(viewModel, index, wallCount, scrollPercent);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: _buildWalls(),
      ),
    );
  }


}
