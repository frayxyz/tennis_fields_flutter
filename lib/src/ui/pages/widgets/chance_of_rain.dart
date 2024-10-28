import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/rain_probability/rain_probability_bloc.dart';

class ChanceOfRainWidget extends StatelessWidget {
  const ChanceOfRainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Icon(CupertinoIcons.cloud_drizzle, color: Colors.blueAccent, size: 18),
        BlocBuilder<RainProbabilityBloc, RainProbabilityState>(
          builder: (context, state) {
            if(state is RainProbabilityLoaded){
              return Text(" ${state.probability} %");

            }else if(state is RainProbabilityLoading){
              return const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.camera, size:16),
              );
            }else{
              return const SizedBox();
            }

          },
        )
      ],
    );
  }
}