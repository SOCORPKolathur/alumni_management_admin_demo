import 'package:flutter/material.dart';

class CustomPaginator extends StatefulWidget {
  final int pageCount;
  final ValueChanged<int> onPageChange;

  CustomPaginator({required this.pageCount, required this.onPageChange});

  @override
  _CustomPaginatorState createState() => _CustomPaginatorState();
}

class _CustomPaginatorState extends State<CustomPaginator> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.pageCount,
            (index) => GestureDetector(
          onTap: () {
            if (currentPage != index + 1) {
              setState(() {
                currentPage = index + 1;
              });
              widget.onPageChange(currentPage);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: currentPage == index + 1 ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
