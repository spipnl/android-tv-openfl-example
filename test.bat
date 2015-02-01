adb connect 192.168.1.50:4321
adb -s 192.168.1.50:4321 shell pm uninstall nl.spip.AndroidTVOpenFLExample
adb -s 192.168.1.50:4321 install -r bin/android/bin/bin/AndroidTVOpenFLExample-debug.apk
adb -s 192.168.1.50:4321 shell am start -n nl.spip.AndroidTVOpenFLExample/nl.spip.AndroidTVOpenFLExample.MainActivity
