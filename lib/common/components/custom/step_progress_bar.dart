import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unitaapp/common/index.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double spacing;
  final Color completedColor;
  final Color defaultColor;
  final EdgeInsetsGeometry sidePadding;
  final double borderRadius;

  StepProgressBar({
    required this.currentStep, // The current step, required parameter
    this.totalSteps = 12, // Total number of steps, default is 12
    this.spacing = 4.0, // Spacing between completed steps, default is 4
    this.completedColor = AppColors.color_65AF7C, // Color for completed steps
    this.defaultColor = AppColors.color_E6DCD6, // Default color for uncompleted steps
    this.sidePadding = const EdgeInsets.only(bottom: 5), // Padding on the sides, default is 5px bottom
    this.borderRadius = 3.0, // Border radius for each step, default is 3px
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sidePadding, // Apply side padding
      child: Row(
        children: [
          // Completed steps
          for (int index = 0; index < currentStep; index++)
            Expanded(
              child: Container(
                height: 4.0, // Set the height of the progress bar
                decoration: BoxDecoration(
                  color: completedColor, // Set color for completed steps
                  borderRadius: BorderRadius.circular(borderRadius), // Apply border radius
                ),
                margin: EdgeInsets.only(
                  right: (index < currentStep - 1) ? spacing : 4, // Apply spacing only between completed steps
                ),
              ),
            ),
          // Uncompleted steps as a continuous line
          if (currentStep < totalSteps)
            Expanded(
              flex: totalSteps - currentStep, // Flex to fill remaining space
              child: Container(
                height: 4.0, // Set the height of the progress bar
                decoration: BoxDecoration(
                  color: defaultColor, // Set color for uncompleted steps
                  borderRadius: BorderRadius.circular(borderRadius), // Apply border radius
                ),
              ),
            ),
        ],
      ),
    );
  }
}
