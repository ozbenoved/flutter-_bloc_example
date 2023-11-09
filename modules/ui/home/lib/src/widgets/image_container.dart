import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:state_management/state_management.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({super.key});

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      var eventToEmit;
      if (t.tick % 3 == 0) {
        eventToEmit = LisaImageEvent();
      } else if (t.tick % 2 == 0) {
        eventToEmit = OctopusImageEvent();
      } else {
        eventToEmit = PinkPantherImageEvent();
      }
      context.read<ImageBloc>().add(eventToEmit);
    });
    context.read<ImagesPlayerCubit>().stream.listen((event) {
      if (event) {
        timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
          var eventToEmit;
          if (t.tick % 3 == 0) {
            eventToEmit = LisaImageEvent();
          } else if (t.tick % 2 == 0) {
            eventToEmit = OctopusImageEvent();
          } else {
            eventToEmit = PinkPantherImageEvent();
          }
          context.read<ImageBloc>().add(eventToEmit);
        });
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, String>(
      builder: (context, url) {
        print('ImageBloc child built');
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CachedNetworkImage(
                useOldImageOnUrlChange: true,
                cacheKey: url,
                imageUrl: url,
                fit: BoxFit.scaleDown,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "${timer?.tick}",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: url == OctopusImageEvent().url
                          ? context.read<ThemeCubit>().state.colorScheme.primary
                          : context.read<ThemeCubit>().state.colorScheme.error),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
