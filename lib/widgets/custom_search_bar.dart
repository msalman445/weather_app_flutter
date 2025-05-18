import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.textEditingController,
    required this.onSearchButtonTapped,
  });

  final TextEditingController textEditingController;
  final void Function() onSearchButtonTapped;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  double? width = 50;
  double? height;

  bool isSearchIcon = true;

  late FocusNode _textFieldFocusNode;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = FocusNode();
    _searchFocusNode = FocusNode();
  }

  void onSearchBarButtonTap() {
    setState(() {
      isSearchIcon = true;
      width = 50;
      widget.onSearchButtonTapped();
      widget.textEditingController.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocusNode.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size(width: screenWidth, height: screenHeight) = MediaQuery.sizeOf(
      context,
    );

    void onSearchButtonTap() {
      setState(() {
        width = screenWidth * 0.8;
        isSearchIcon = false;
      });
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child:
            isSearchIcon
                ? IconButton(
                  onPressed: onSearchButtonTap,
                  icon: Icon(Icons.search),
                )
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: TextField(
                    controller: widget.textEditingController,
                    focusNode: _textFieldFocusNode,
                    onSubmitted: (value) {
                      _searchFocusNode.requestFocus();
                      onSearchBarButtonTap();
                    },

                    autofocus: true,
                    keyboardType: TextInputType.text,

                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Enter your Location...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,

                      suffixIcon: IconButton(
                        onPressed: onSearchBarButtonTap,
                        focusNode: _searchFocusNode,
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}
