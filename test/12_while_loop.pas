var
a, b, c, d, e : boolean;
begin
	a := True;
	b := True;
	c := True;
	d := True;
	e := False;

	while a do
	begin
		writeln('priv');
		a := a and b;
		b := b and c;
		c := c and d;
		d := d and e;
	end

	writeln('(expected 4 privs)');

end.

