program juego_epico;
uses Crt;
const
	fin = 'q';
	ancho = 100;
	alto = 50;
	radio = 6;
var
  c: Char;
  x1, y1, vx1, vy1, x2, y2, vx2, vy2, tx1, ty1, tx2, ty2:integer;

function graficar1(x, y, px, py:integer):boolean;
begin
	graficar1 := sqr(px - x) + sqr(py - y) <= sqr(radio);
end;

function graficar2(x, y, px, py:integer):boolean;
begin
	graficar2 := sqr(px - x) + sqr(py - y) <= sqr(radio);
end;

procedure imprimir(x1,y1, x2, y2:integer);
var px, py:integer;
begin
	ClrScr;
	for py:=0 to ancho do write('-');
                writeln;
                for py := 0 to alto do
                begin
                        write('-');
                        for px:=0 to ancho do
                        begin
                                if graficar1(x1, y1, px, py) then write('O')
                                else if graficar2(x2, y2, px, py) then write('3')
                                else write(' ');
                        end;
                        write('-');
                        writeln;
                end;
	for py:=0 to ancho do write('-');
	delay(50);
end;

procedure darUnPaso(var x, y: integer; vx, vy: integer);
begin
	x := x + vx;
	y := y + vy;
end;

procedure pasos(var x1, y1, x2, y2:integer; vx1, vy1, vx2, vy2:integer);
begin
	darunpaso(x1,y1,vx1,vy1);
	darunpaso(x2, y2, vx2,vy2);
	imprimir(x1, y1, x2, y2);
end;
function chocan(x1, y1, x2, y2:integer):boolean;
begin
	chocan := sqrt(sqr(x1 - x2) + sqr(y1 - y2)) < 2 * radio;
end;

function esPosicionValida(x1, y1: integer): boolean;
begin
	if (RADIO <= x1) and (x1 <= ANCHO - RADIO) and (RADIO <= y1) and (y1 <= ALTO - RADIO) then
		esPosicionValida := true
	else esPosicionValida := false;
end;

procedure simular(var x1, y1, x2, y2:integer; vx1, vy1, vx2, vy2:integer);
begin
	while (esposicionvalida(x1, y2) and esposicionvalida(x2, y2)) and not chocan(x1, y1, x2, y2) do
	begin
		pasos(x1, y1, x2, y2, vx1, vy1, vx2, vy2);
	end;
end;
procedure reiniciar(tx1, ty1, tx2, ty2:integer);
begin
	x1:=tx1; y1:=ty1;x2:= tx2;y2:= ty2;
	imprimir(x1, y1, x2, y2);
end;


begin
	write('Coordenadas y vectores de cada esfera: ');
	readln(tx1, ty1, vx1, vy1, tx2, ty2, vx2, vy2);
	reiniciar(tx1, ty1, tx2, ty2);
	{vx1:=1;vy1:=1;vx2:=-3;vy2:=-1;}
	repeat
                c := readkey;
                case c of
                        'i': simular(x1, y1, x2, y2, vx1, vy1, vx2, vy2);
                        'r': reiniciar(tx1, ty1, tx2, ty2);
                        'd': pasos(x1, y1, x2, y2, vx1, vy1, vx2, vy2);
                end;
	until c = fin;
end.
