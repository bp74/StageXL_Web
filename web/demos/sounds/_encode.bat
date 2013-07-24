FOR /R %1 %%G IN (*.wav) DO tools\lame.exe -q 0 --tt "StageXL Demo" "%%G"
FOR /R %1 %%G IN (*.wav) DO tools\oggenc2.exe -q 6 "%%G"
