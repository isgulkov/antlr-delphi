var
a, b, c : boolean;
begin
	a := True;
	b := True;
	c := True;

	writeln('nesting levels:');

	if a then
	begin
		writeln('one');

		if b then
		begin
			writeln('two');

			if c then
			begin
				writeln('three');
			end
		end
	end

	writeln('(expected three)');
end.