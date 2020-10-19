library count_down_timer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/timer_bloc.dart';
import 'ticker.dart';

class CountDownTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                BlocProvider.of<TimerBloc>(context)
                    .add(TimerStarted(duration: state.duration));
                final String secondsStr =
                    (state.duration).floor().toString().padLeft(2, '0');
                return state.duration != 0
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '$secondsStr',
                            style: TextStyle(color: Colors.black, fontSize: 36),
                          )
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.replay,
                          color: Color(0xff00cccc),
                        ),
                        onPressed: () => BlocProvider.of<TimerBloc>(context)
                            .add(TimerReset()),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
