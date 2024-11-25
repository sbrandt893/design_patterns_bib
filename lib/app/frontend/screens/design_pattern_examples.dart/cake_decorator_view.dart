import 'package:flutter/material.dart';
import 'package:design_patterns_bib/02_design_patterns/structural_patterns/decorator/dart_example_cake_decorator/models_extended.dart';

class CakeDecoratorView extends StatefulWidget {
  const CakeDecoratorView({super.key});

  @override
  CakeDecoratorViewState createState() => CakeDecoratorViewState();
}

class CakeDecoratorViewState extends State<CakeDecoratorView> with SingleTickerProviderStateMixin {
  Cake cake = BaseCake();
  final List<DecorationItem> _decorationItems = [];
  final GlobalKey _cakeContainerKey = GlobalKey();
  Size _containerSize = Size.zero;
  late AnimationController _animationController;
  late Animation<double> _fallAnimation;
  DecorationItem? _lastAddedDecoration;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fallAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateContainerSize();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateContainerSize() {
    final RenderBox? renderBox = _cakeContainerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _containerSize = renderBox.size;
      });
    }
  }

  bool _isWithinCakeArea(Offset position) {
    return position.dx >= 0 && position.dx <= _containerSize.width - 40 && position.dy >= 0 && position.dy <= _containerSize.height - 40;
  }

  void _addDecoration(String type, Offset position) {
    if (_isWithinCakeArea(position)) {
      setState(() {
        if (type == 'chocolate') {
          cake = ChocolateGlazeDecorator(cake);
        } else if (type == 'fruit') {
          cake = FruitDecorator(cake);
        }

        final decorationItem = DecorationItem(
          type: type,
          position: position,
          zIndex: _decorationItems.length,
        );

        _decorationItems.add(decorationItem);
        _lastAddedDecoration = decorationItem;

        // Trigger fall animation only for the newly added item
        _animationController.forward(from: 0);
      });
    }
  }

  void _handleDecorationDragEnd(DecorationItem decoration, DraggableDetails details) {
    final RenderBox renderBox = _cakeContainerKey.currentContext?.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.offset);

    setState(() {
      if (_isWithinCakeArea(localPosition)) {
        decoration.position = localPosition;
        _lastAddedDecoration = decoration;
        _animationController.forward(from: 0);
      } else {
        // Reset to original position if outside cake area
        _animationController.forward(from: 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cake Decorator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: DragTarget<DecorationItem>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    color: Colors.grey[300],
                    key: _cakeContainerKey,
                    width: 500,
                    height: 500,
                    child: Stack(
                      children: [
                        Image.asset('assets/cake.png', width: 500, height: 500),
                        for (final decoration in _decorationItems)
                          AnimatedBuilder(
                            animation: _fallAnimation,
                            builder: (context, child) {
                              return Positioned(
                                left: decoration.position.dx,
                                top: decoration.position.dy + (decoration == _lastAddedDecoration ? _fallAnimation.value : 10),
                                child: Draggable(
                                  feedback: Image.asset(decoration.type == 'chocolate' ? 'assets/chocolate.png' : 'assets/fruit.png', width: 50, height: 50),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: Image.asset(decoration.type == 'chocolate' ? 'assets/chocolate.png' : 'assets/fruit.png', width: 50, height: 50),
                                  ),
                                  onDragEnd: (details) => _handleDecorationDragEnd(decoration, details),
                                  child: Image.asset(decoration.type == 'chocolate' ? 'assets/chocolate.png' : 'assets/fruit.png', width: 50, height: 50),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
                onAcceptWithDetails: (details) {},
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Draggable<String>(
                data: 'chocolate',
                feedback: Image.asset('assets/chocolate.png', width: 50, height: 50),
                childWhenDragging: Image.asset('assets/chocolate.png', width: 100, height: 100, color: Colors.grey),
                onDragEnd: (details) {
                  final RenderBox renderBox = _cakeContainerKey.currentContext?.findRenderObject() as RenderBox;
                  final localPosition = renderBox.globalToLocal(details.offset);
                  _addDecoration('chocolate', localPosition);
                },
                child: Image.asset('assets/chocolate.png', width: 100, height: 100),
              ),
              Draggable<String>(
                data: 'fruit',
                feedback: Image.asset('assets/fruit.png', width: 50, height: 50),
                childWhenDragging: Image.asset('assets/fruit.png', width: 100, height: 100, color: Colors.grey),
                onDragEnd: (details) {
                  final RenderBox renderBox = _cakeContainerKey.currentContext?.findRenderObject() as RenderBox;
                  final localPosition = renderBox.globalToLocal(details.offset);
                  _addDecoration('fruit', localPosition);
                },
                child: Image.asset('assets/fruit.png', width: 100, height: 100),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Preis: ${cake.getPrice().toStringAsFixed(2)} €\n${formatDescription(cake)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DecorationItem {
  final String type;
  Offset position;
  final int zIndex;

  DecorationItem({
    required this.type,
    required this.position,
    required this.zIndex,
  });
}
