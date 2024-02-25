--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
package SPDX_Tool.Configs.Default is

   default : aliased constant String;

private

   default : aliased constant String := "# Default configuration" & ASCII.LF & "[d"
       & "efault]" & ASCII.LF & "color=""yes""" & ASCII.LF & "ignore=[" & ASCII.LF
       & """*.o""," & ASCII.LF & """*.a""," & ASCII.LF & """*.so""," & ASCII.LF & """"
       & "*.lib""," & ASCII.LF & """*.md""," & ASCII.LF & """*.log""," & ASCII.LF
       & """*.pem""," & ASCII.LF & """*.txt""" & ASCII.LF & "]" & ASCII.LF & ASCII.LF
       & "[license-files]" & ASCII.LF & "MIT=[ ""MIT.txt"", ""MIT-LICENSE.txt"", """
       & "LICENSE.txt"" ]" & ASCII.LF & "GPL-3=[ ""COPYING3"", ""COPYING3.LIB"" ]" & ASCII.LF
       & "GPL-2=[ ""COPYING"", ""COPYING.LIB"", ""GPL-LICENSE.txt"" ]" & ASCII.LF
       & "Apache-2= [ ""LICENSE"", ""LICENSE.txt"" ]" & ASCII.LF & ASCII.LF & "[l"
       & "anguages]" & ASCII.LF & "Markdown=[ ""*.md"" ]" & ASCII.LF & "Makefile=["
       & " ""Makefile"", ""Imakefile"" ]" & ASCII.LF & ASCII.LF & "[comments]" & ASCII.LF
       & "Makefile=""shell""" & ASCII.LF & "Markdown=""none""" & ASCII.LF & ASCII.LF;

end SPDX_Tool.Configs.Default;
