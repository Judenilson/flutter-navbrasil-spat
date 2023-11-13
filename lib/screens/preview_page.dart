import 'dart:io';

import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  final File file;

  const PreviewPage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [ Stack( children:[
                Positioned.fill(
                  child: Image.file(file, fit: BoxFit.cover),
                ),
                
                const Column(
                  children: [
                    SizedBox(
                      height: 210,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(200, 0, 0, 0),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 190,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(200, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.of(context).pop(file),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
