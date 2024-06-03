import 'package:flutter/material.dart';
import 'package:ias322_project/models/tab_icon.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, this.tabIconsList, this.changeIndex});

  final Function(int index)? changeIndex;
  final List<TabIconData>? tabIconsList;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  bool botSelected = false;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 42,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[0],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[0]);
                                  widget.changeIndex!(0);
                                }),
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[1],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[1]);
                                  widget.changeIndex!(1);
                                }),
                          ),
                          SizedBox(
                            width: Tween<double>(begin: 0.0, end: 1.0)
                                    .animate(CurvedAnimation(
                                        parent: animationController!,
                                        curve: Curves.fastOutSlowIn))
                                    .value *
                                64.0,
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[2],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[2]);
                                  widget.changeIndex!(2);
                                }),
                          ),
                          Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList?[3],
                                removeAllSelect: () {
                                  setRemoveAllSelection(
                                      widget.tabIconsList?[3]);
                                  widget.changeIndex!(3);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 + 42.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController!,
                            curve: Curves.fastOutSlowIn)),
                    child: Container(
                      // alignment: Alignment.center,s
                      decoration: BoxDecoration(
                        color: const Color(0xFF3DC483),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xFF3DC483),
                              Color(0xFF6A88E5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: const Color(0xFF3DC483).withOpacity(0.4),
                              offset: const Offset(8.0, 16.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: selectBotPage,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      botSelected = false;
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }

  void selectBotPage() {
    if (!mounted) return;
    setState(() {
      widget.changeIndex!(4);
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
      });
      botSelected = true;
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons({super.key, this.tabIconData, this.removeAllSelect});

  final TabIconData? tabIconData;
  final Function()? removeAllSelect;
  @override
  State<TabIcons> createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData?.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect!();
          widget.tabIconData?.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData!.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData!.animationController!,
                            curve: const Interval(0.1, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: const Icon(Icons.chat)),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData!.animationController!,
                            curve: const Interval(0.2, 1.0,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3DC483),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData!.animationController!,
                            curve: const Interval(0.5, 0.8,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3DC483),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData!.animationController!,
                            curve: const Interval(0.5, 0.6,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3DC483),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
