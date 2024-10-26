import 'package:flutter/material.dart';

import '../../widgets/change_of_rain.dart';

class FieldDetailsInfo extends StatelessWidget {
  const FieldDetailsInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Field Name",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$25",
                style: TextStyle(fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Type: Tennis"),
              Text("Por hora"),
            ],
          ),
          const SizedBox(height: 25),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Available: Yes"),
              ChanceOfRainWidget()
            ],
          ),
          const SizedBox(height: 28),

          const Text("Location: Main Street 123"),
          Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.4),
            child: DropdownButton<String>(
              items: const [
                DropdownMenuItem(
                  value: "Option 1",
                  child: Text("Option 1"),
                ),
                DropdownMenuItem(
                  value: "Option 2",
                  child: Text("Option 2"),
                ),
              ],
              onChanged: (value) {},
              hint: const Text("Agregar instructor"),
            ),
          ),
        ],
      ),
    );
  }
}