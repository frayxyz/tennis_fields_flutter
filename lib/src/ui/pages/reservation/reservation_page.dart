import 'package:flutter/material.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/back_icon_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/buttons/custom_button.dart';
import 'package:tennis_booking/src/ui/pages/widgets/change_of_rain.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _imageUrls = [
    'assets/images/tennis_image.jpg',
    'assets/images/tennis_image.jpg',
    'assets/images/tennis_image.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarouselImageAndButtons(context),

            const SizedBox(height: 18),

            // Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Wrap(

                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Field Name",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$25",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            ),

            const SizedBox(height: 16),

            // Date and Time Section
            Container(
              width: double.infinity,
              color: Colors.lightBlue.shade50,
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Establecer fecha y hora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Text("Select Date"),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Text("MM/DD/YYYY"),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Start Time"),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Text("HH:MM"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("End Time"),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Text("HH:MM"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text("Add Comment"),
                  SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write a comment...",
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reserve Button
                  CustomButton("Reservar", onPressed: (){}),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Stack buildCarouselImageAndButtons(BuildContext context) {
    return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              // Indicator Dots
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_imageUrls.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 11 : 13,
                      height: _currentPage == index ? 11 : 13,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Theme.of(context).primaryColor : Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
              const Positioned(
                top: 16,
                left: 28,
                child: BackIconButton(),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
            ],
          );
  }
}
