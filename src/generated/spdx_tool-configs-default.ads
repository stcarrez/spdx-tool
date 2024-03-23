--  Advanced Resource Embedder 1.5.0
--  SPDX-License-Identifier: Apache-2.0
package SPDX_Tool.Configs.Default is

   default : aliased constant String;

private

   default : aliased constant String := "# Default configuration" & ASCII.LF & "[d"
       & "efault]" & ASCII.LF & "color=""yes""" & ASCII.LF & "ignore=[" & ASCII.LF
       & """*.o""," & ASCII.LF & """*.a""," & ASCII.LF & """*.so""," & ASCII.LF & """"
       & "*.lib""," & ASCII.LF & """*.md""," & ASCII.LF & """*.log""," & ASCII.LF
       & """*.pem""," & ASCII.LF & """*.txt""," & ASCII.LF & """*~""" & ASCII.LF & "]"
       & ASCII.LF & ASCII.LF & "[license-files]" & ASCII.LF & "MIT=[ ""MIT.txt"""
       & ", ""MIT-LICENSE.txt"", ""LICENSE.txt"" ]" & ASCII.LF & "GPL-3=[ ""COPYIN"
       & "G3"", ""COPYING3.LIB"" ]" & ASCII.LF & "GPL-2=[ ""COPYING"", ""COPYING.L"
       & "IB"", ""GPL-LICENSE.txt"" ]" & ASCII.LF & "Apache-2= [ ""LICENSE"", ""LI"
       & "CENSE.txt"" ]" & ASCII.LF & ASCII.LF & "[languages]" & ASCII.LF & "Mark"
       & "down=[ ""*.md"" ]" & ASCII.LF & "Makefile=[ ""Makefile"", ""Imakefile"" "
       & "]" & ASCII.LF & ASCII.LF & "[comments]" & ASCII.LF & "Shell={ start=""#"
       & """ }" & ASCII.LF & "Ada={ start=""--"" }" & ASCII.LF & "C={ block-start="
       & """/*"", block-end=""*/"" }" & ASCII.LF & ASCII.LF & ASCII.LF;

end SPDX_Tool.Configs.Default;
