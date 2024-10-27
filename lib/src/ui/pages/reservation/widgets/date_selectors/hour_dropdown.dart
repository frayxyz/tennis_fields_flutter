import 'package:flutter/material.dart';

class HourDropdown extends StatefulWidget {
  final String title;
  final List<String> availableHours;
  final ValueChanged<String?> onHourSelected;
  final String? defaultTime;

  const HourDropdown({
    super.key,
    required this.title,
    required this.availableHours,
    required this.onHourSelected,
    this.defaultTime,
  });

  @override
  _HourDropdownState createState() => _HourDropdownState();
}

class _HourDropdownState extends State<HourDropdown> {
  String? _selectedHour;
  bool _isDropdownOpen = false;
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedHour = widget.defaultTime;
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry.remove();
    setState(() {
      _isDropdownOpen = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: position.dx,
          top: position.dy + renderBox.size.height,
          width: renderBox.size.width,
          child: Material(
            color: Colors.transparent,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, 72),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.availableHours.map((hour) {
                    return ListTile(
                      title: Text(hour),
                      onTap: () {
                        setState(() {
                          _selectedHour = hour;
                        });
                        widget.onHourSelected(hour);
                        _closeDropdown();
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(
                    _selectedHour ?? "00:00",
                    style: TextStyle(
                        color: _selectedHour != null? Theme.of(context).colorScheme.primary : Colors.grey
                    ),
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}
