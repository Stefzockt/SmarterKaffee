# Smarter Kaffee

Dieses Projekt entstand um Kaffemaschienen über App sowie Web zu steuern. Somit würde jede Kaffeemaschien zu einer Smarten gemacht werden.

## Aufbau
# Server aka. Raspi:
Du ziehst die Komplette GitRepo auf den Raspi. Dort rufst du nun GitBash auf bzw. öffnest die Konsole und gehst in die Repo rein. Nun tippst du "git checkout server". In diesem Branch findest du alle wichtigen Datein für den Raspi. In der "myserver.py" musst du nur noch den PORT angeben den du nutzen willst sowie die lokale addresse des Raspi.
Vergiss nicht die fehlenden packeges mit pip install zu installieren.

# App installieren:
Auf deinem Rechner clonst du dir nun das Projekt.
Nun setzt du dir Flutter richtig auf so dass es funktioniert.(Hier ein Guid dazu https://docs.flutter.dev/get-started/install).
Nach der installation öffnen wir den SmartenKaffe Ordner in der IDE. Dort rufen wir das Terminal jetzt auf und schreiben diese Commands hin.
"flutter clean" -> Unsere restlichen Flutter Datein werden damit gelöscht und schaffen somit Platz für deine
"flutter pub get" -> Flutter wird nun für dein Projekt neu konfiguriert.

# Android:
Mit "flutter build apk" baust du nun deine APK für Android.
Dies wir unter app/outputs/apk/release/ zu finden sein. Hier suchst du nach der app-realeas.apk und schiebst diese auf dein Handy.

# IOS:
HINWEIS: DU KANNST DIE IOS APP NUR AUF EINEM MAC GERÄTEN IM XCODE EDITOR BAUEN!
Leider ist eine IOS App nicht so einfach zu bauen. Da wir es nur mit Android getestet haben schau dir einfach diesen Guid an: https://docs.flutter.dev/deployment/ios



