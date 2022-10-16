import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'transitions.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_photo_view_model.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';
// import 'package:vector_math/vector_math.dart';

mixin ReorderableMixin {
  @protected
  Widget makeAppearingWidget(
    Widget child,
    AnimationController entranceController,
    Size? draggingFeedbackSize,
    double scaleFactor,
    Offset postion,
    double rotation,
    Axis direction,
  ) {
    if ((null == draggingFeedbackSize)) {
      return SizeTransitionWithIntrinsicSize(
        sizeFactor: entranceController,
        axis: direction,
        child: FadeTransition(
          opacity: entranceController,
          child: child,
        ),
      );
      
      // return Container(
      //   
      //     child: Transform(
      //       transform: new Matrix4.rotationZ(photoViewModel.r),
      //       alignment: Alignment.center,
      //       origin: postion,
      //       child: Material(
      //         child:
      //         Card(child: ConstrainedBox(constraints: contentSizeConstraints, child: transition)),
      //         elevation: 6.0,
      //         color: Colors.transparent,
      //         borderRadius: BorderRadius.zero,
      //       ),
      //     )
      // );
    } else {
      var transition = SizeTransition(
        sizeFactor: entranceController,
        axis: direction,
        child: FadeTransition(opacity: entranceController, child: child),
      );


      BoxConstraints contentSizeConstraints = BoxConstraints.loose(draggingFeedbackSize);
     
      // return ConstrainedBox(constraints: contentSizeConstraints, child: transition);
      Vector3 vec3 = Vector3(contentSizeConstraints.widthConstraints().maxWidth*1.2, contentSizeConstraints.maxHeight*0.6, 0);
      return Container(
        child: Transform(
          transform: new Matrix4.rotationZ(50),
          //transform: new Matrix4.compose(vec3,Quaternion.axisAngle(vec3, 50.0),Vector3(contentSizeConstraints.widthConstraints().maxWidth*scaleFactor, contentSizeConstraints.maxHeight*scaleFactor, 0)),
          //transform: new Matrix4.translationValues(contentSizeConstraints.widthConstraints().maxWidth*scaleFactor, contentSizeConstraints.maxHeight*scaleFactor, 0),
         // transform: new Matrix4.rotationZ(150),
          child:Transform.scale(
            //transform: new Matrix4.translationValues(postion.dx, postion.dy,0),
            scale: 0.1,
            alignment: Alignment.center,
            child:Material(
              child: Card(child: ConstrainedBox(constraints: contentSizeConstraints, child: transition)),
              elevation: 6.0,
              color: Color(0x0A000000),
              borderRadius: BorderRadius.zero,
            ),
          ),
        )
      );
    }
  }

  @protected
  Widget makeDisappearingWidget(
      Widget child,
      AnimationController ghostController,
      Size? draggingFeedbackSize,
      Axis direction,
      ) {
    if (null == draggingFeedbackSize) {
      return SizeTransitionWithIntrinsicSize(
        sizeFactor: ghostController,
        axis: direction,
        child: FadeTransition(
          opacity: ghostController,
          child: child,
        ),
      );
    } else {
      var transition = SizeTransition(
        sizeFactor: ghostController,
        axis: direction,
        child: FadeTransition(opacity: ghostController, child: child),
      );

      BoxConstraints contentSizeConstraints =
      BoxConstraints.loose(draggingFeedbackSize);
      return ConstrainedBox(
          constraints: contentSizeConstraints, child: transition);
    }
  }
}
