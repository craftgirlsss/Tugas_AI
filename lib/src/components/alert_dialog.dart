import 'package:flutter/cupertino.dart';

void showAlertDialog(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Gagal'),
        content: const Text('Tulung isien kabeh rek form e iki'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Paham'),
          ),
        ],
      ),
    );
}

void showAlertDialogLogin(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Gagal'),
        content: const Text('NIM utawi kata sandi salah, delok en maning'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Nggeh'),
          ),
        ],
      ),
    );
  }

void showAlertDialogFiturStillDevelopment(context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Gagal'),
        content: const Text('Fitur sek dikembangno'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Nggeh'),
          ),
        ],
      ),
    );
  }