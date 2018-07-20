

import 'package:flutter/material.dart';
import 'package:hangtimer/wall_data.dart';

class Wall extends StatelessWidget{

  final WallViewModel viewModel;
  final double parallaxPercent;

  Wall({
    this.viewModel,
    this.parallaxPercent = 0.0,
});



  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new ClipRRect(
          borderRadius: new BorderRadius.circular(10.0),
          child: FractionalTranslation(
            translation: new Offset(parallaxPercent*2.0, 0.0),
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Image.asset(viewModel.backdropAssetPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

      // content
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: new Text(
                viewModel.location.toUpperCase(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'petita',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),

            new Expanded(child: new Container()),
            
            Center(
              child: new Text(
                  '${viewModel.minGrade} - ${viewModel.maxGrade}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 85.0,
                    fontFamily: 'petita',
                    letterSpacing: -5.0,
                  ),
              ),
            ),

            new Expanded(child: new Container()),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0,
                  bottom: 50.0,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(30.0),
                  border: new Border.all(
                    color: Colors.white,
                    width:  1.5,
                  ),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        '${viewModel.numBoulders} boulders',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'petita',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                          ),
                        child: new Icon(
                          Icons.filter_b_and_w,
                          color: Colors.white,
                        ),
                      ),
                      new Text(
                        '${viewModel.numNewBoulders} new',
                        style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'petita',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )

      ],
    );
  }

}