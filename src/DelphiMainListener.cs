using System;
using System.IO;
using System.Linq;

namespace DelphiTranslator
{
	public class DelphiMainListener : DelphiBaseListener
	{
		readonly string OutputFilename;
		StreamWriter OutputWriter;

		public DelphiMainListener(string outputFilename)
		{
			OutputFilename = outputFilename;

			OutputWriter = new StreamWriter(File.Open(OutputFilename, FileMode.Create));
			OutputWriter.AutoFlush = true;
		}

		void Out(string s)
		{
			OutputWriter.Write(s);
		}

		void OutLine(string s)
		{
			OutputWriter.WriteLine(s);
		}

		void PrintErrorAndExit(int error_code, string message)
		{
			Console.WriteLine($"Error {error_code}: {message}");

			OutputWriter.Close();
			File.Delete(OutputFilename);

			Environment.Exit(1);
		}

		static string CSharpType(string delphiType)
		{
			switch(delphiType) {
				case "boolean": return "bool";
				case "double": return "double";
				default: return null; // Never happens
			}
		}

		static string PrintExpr(DelphiParser.ExpressionContext context)
		{
			return "{expression}";
		}

		static string PrintExpr(DelphiParser.OrExpressionContext context)
		{
			return "{or-expression}";
		}

		public override void EnterFile(DelphiParser.FileContext context)
		{
			OutLine("using System;");
			OutLine("");
			OutLine("class Program");
			OutLine("{");
		}

		public override void ExitFile(DelphiParser.FileContext context)
		{
			OutLine("}");
		}

		public override void EnterMainSection(DelphiParser.MainSectionContext context)
		{
			OutLine("public static void Main()");
			OutLine("{");
		}

		public override void ExitMainSection(DelphiParser.MainSectionContext context)
		{
			OutLine("}");
		}

		public override void EnterVariableDeclaration(DelphiParser.VariableDeclarationContext context)
		{
			Out($"static {CSharpType(context.TYPENAME().GetText())} ");

			Out(String.Join(
				", ",
				context.ID().Select(id => id.GetText())
			));

			OutLine(";");
		}

		public override void EnterAssignmentStatement(DelphiParser.AssignmentStatementContext context)
		{
			OutLine($"{context.ID().GetText()} = {PrintExpr(context.expression())};");
		}

		public override void EnterWhileStatement(DelphiParser.WhileStatementContext context)
		{
			OutLine($"while({PrintExpr(context.orExpression())}) {{");
		}

		public override void ExitWhileStatement(DelphiParser.WhileStatementContext context)
		{
			OutLine("}");
		}

		public override void EnterIfStatement(DelphiParser.IfStatementContext context)
		{
			OutLine($"if({PrintExpr(context.orExpression())}) {{");
		}

		public override void ExitIfStatement(DelphiParser.IfStatementContext context)
		{
            OutLine("}");
		}

		public override void EnterWritelnStatement(DelphiParser.WritelnStatementContext context)
		{
			string expressionToPrint;

			if(context.expression() != null) {
				expressionToPrint = PrintExpr(context.expression());
			}
			else {
				string s = context.STRING().GetText().Replace("\'", "'");

				expressionToPrint = '"' + s.Substring(1, s.Length - 2) + '"';
			}

			OutLine($"Console.WriteLine({expressionToPrint});");
		}
	}
}
