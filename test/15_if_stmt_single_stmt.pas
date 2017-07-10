var
a, b : boolean;
begin
	a := True;

	if a then writeln('expected');

	b := False;

	if b then writeln('unexpected');
end.