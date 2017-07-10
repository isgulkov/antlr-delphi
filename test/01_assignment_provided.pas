var
a,b:boolean;
begin
a:=True;
b:=False;
if a and not b then writeln('a & b = True');
while a or b do
begin
writeln('a or b == True');
if a then a:=not a;
end
end.
