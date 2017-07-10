using System;
using System.IO;

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
	}
}
