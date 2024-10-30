import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../generated/l10n.dart';
import '../../../service/tts.dart';
import '../book_player/epub_player.dart';
import 'reading_page/more_settings/more_settings.dart';
import 'reading_page/widget_title.dart';

class TtsWidget extends StatefulWidget {
  const TtsWidget({super.key, required this.epubPlayerKey});

  final GlobalKey<EpubPlayerState> epubPlayerKey;

  @override
  State<TtsWidget> createState() => _TtsWidgetState();
}

class _TtsWidgetState extends State<TtsWidget> {
  double volume = Tts.volume;
  double pitch = Tts.pitch;
  double rate = Tts.rate;

  late bool isPlaying;

  @override
  void initState() {
    isPlaying = Tts.isPlaying;
    if (!isPlaying) {
      Tts.init(
          widget.epubPlayerKey.currentState!.initTts,
          widget.epubPlayerKey.currentState!.ttsNext,
          widget.epubPlayerKey.currentState!.ttsPrev);
      Tts.speak();
      isPlaying = true;
    }

    super.initState();
  }

  Widget _volume() {
    return Row(
      children: [
        Text(S.of(context).tts_volume),
        Expanded(
          child: Slider(
              value: Tts.volume,
              onChanged: (newVolume) {
                setState(() {
                  isPlaying = true;
                  Tts.volume = newVolume;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: Tts.volume.toStringAsFixed(1)),
        ),
      ],
    );
  }

  Widget _pitch() {
    return Row(
      children: [
        Text(S.of(context).tts_pitch),
        Expanded(
          child: Slider(
            value: Tts.pitch,
            onChanged: (newPitch) {
              setState(() {
                isPlaying = true;
                Tts.pitch = newPitch;
              });
            },
            min: 0.5,
            max: 2.0,
            divisions: 15,
            label: Tts.pitch.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }

  Widget _rate() {
    return Row(
      children: [
        Text(S.of(context).tts_rate),
        Expanded(
          child: Slider(
            value: Tts.rate,
            onChanged: (newRate) {
              setState(() {
                isPlaying = true;
                Tts.rate = newRate;
              });
            },
            min: 0.0,
            max: 2.0,
            divisions: 10,
            label: Tts.rate.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }

  Widget sliders() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: Column(
        children: [
          _volume(),
          _pitch(),
          _rate(),
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () async {
              Tts.stop();
              Tts.speak(
                  content: await widget.epubPlayerKey.currentState!.ttsPrevSection());
              setState(() {
                isPlaying = true;
              });
            },
            icon: const Icon(EvaIcons.arrowhead_left)),
        IconButton(
            onPressed: () {
              setState(() {
                isPlaying = true;
                Tts.prev();
              });
            },
            icon: const Icon(EvaIcons.chevron_left)),
        IconButton(
            onPressed: () async {
              Tts.toggle();
              setState(() {
                isPlaying = !isPlaying;
              });
            },
            icon: isPlaying
                ? const Icon(EvaIcons.pause_circle_outline)
                : const Icon(EvaIcons.play_circle_outline)),
        IconButton(
            onPressed: () {
              Tts.dispose();
              widget.epubPlayerKey.currentState!.ttsStop();
              setState(() {
                isPlaying = false;
              });
            },
            icon: const Icon(EvaIcons.stop_circle_outline)),
        IconButton(
            onPressed: () {
              setState(() {
                isPlaying = true;
                Tts.next();
              });
            },
            icon: const Icon(EvaIcons.chevron_right)),
        IconButton(
            onPressed: () async {
              Tts.stop();
              Tts.speak(
                  content: await widget.epubPlayerKey.currentState!.ttsNextSection());
              setState(() {
                isPlaying = true;
              });
            },
            icon: const Icon(EvaIcons.arrowhead_right)),
      ],
    );
  }

  // Widget

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          widgetTitle(S.of(context).tts_narrator, ReadingSettings.style),
          buttons(),
          const Divider(),
          sliders(),
        ],
      ),
    );
  }
}
