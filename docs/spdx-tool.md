
## NAME

spdx-tool \- SPDX license management tool

## SYNOPSIS

*spdx-tool* [\-c|\-\-config
*config] [\-\-help] [\-\-no-color]*  [--no-builtin-licenses] [\-t
*count* ]
 [\-V|\-\-version] [\-v|\-\-verbose] [\-vv] [\-vvv|\-\-debug]
 [\-f|\-\-files] [\-i|\-\-identify] [\-L|\-\-languages]  [\-l|\-\-licenses]
 [-m|--mimes] [\-n|\-\-line-number] [\-p|\-\-print-license]
 [\-\-update
**pattern** ] [\-\-ignore-licenses
**spdx-name1,spdx-name2,...** ]  [\-\-ignore-languages
**lang1,lang2,...** ]  [\-\-only-licenses
**spdx-name1,spdx-name2,...** ]  [\-\-only-languages
**lang1,lang2,...** ]  [\-\-output-json
**file** ] [\-\-output-xml
**file** ]  [--templates
**file|directory** ] *files|directories* 

## DESCRIPTION

*spdx-tool* scans the source files to identify licenses and allows to
update them in order to use the SPDX license format.  It can be used to:

* identify the licenses used in source files of a project,

* produce a JSON/XML report for the licenses found with the list of files,

* replace a license header by the SPDX license tag header.

The tool uses a collection of license templates to identify
the license used in source files.  The builtin repository contains arround 600
license templates and it can be completed by your own templates as long as you
use the SPDX license description format described in
**The Software Package Data Exchange® (SPDX®) Specification Version 2.3**.

The
*spdx-tool* scans the directory or files passed as parameter.  Directories are scanned
recursively and the
*.gitignore* file is first looked in each directory to take into account files which are
ignored in the project.  For each file, the **spdx-tool** tries to:

* identify the language of the source file,

* extract the license header text at beginning of the source file,

* identify the license by using several algorithms.

Language detection is the first step to be able to know which comment
format is used and extract the license header text from the header file
comment.  The license identification is made in several steps:

* first we look for a
*SPDX-License-Identifier* tag.  When it was found, the match report indicates
**SPDX** , 
* then we look for an exact template match from the license templates
builtin repository or from the templates configured for the tool.
When this succeeds, the match report indicates
**TMPL** , 
* last, we guess the best matching license by using an inverted index of license tokens.
The tool then uses a classical **term frequency inverse document frequency**
algorithm to find the best matching license.  The report will indicate the
highest **Cosine** similarity found.

The first step to use the tool to replace license headers by the equivalent
*SPDX-License-Identifier* tag, consists in getting a summary of licenses used in the project.

```
spdx-tool .
```

Having identified the licenses that must be replaced, you can identify the files
which are using the license by using the
*--only-licenses* and
*--files* options:

```
spdx-tool --only-licenses=Apache-2.0,MIT --files .
```

Before deciding to replace the license header of those files, it is good
practice to have a look at the license header that is identified by the tool
in order to double check before the replacement.  For this, you can use the
*--print-license* option:

```
spdx-tool --only-licenses=Apache-2.0,MIT \fB--print-license \\
   --line-number\fR .
```

The replacement step consists in using the
*--update* option which uses a replacement pattern that gives you some control
on the replacement.  The
*pattern* string controls the replacement to allow keeping some lines from the existing
license header.  It indicates which lines must be kept before and after the
SPDX tag.  The pattern has the following format:

```
[number[..number].]spdx[.number[..number]]
```

Line numbers are relative to the first line representing the license header.
The
*--print-license* together with the
*--line-number* options provide good hints to know how the tool identifies the license
and decide which lines must be kept.

To replace the license header and keep the two first lines, use the command:

```
spdx-tool --only-licenses=Apache-2.0,MIT --update=1..2,spdx .
```

if you want to put the license tag before the two lines to keep, use:

```
spdx-tool --only-licenses=Apache-2.0,MIT --update=spdx,1..2 .
```

It is also possible to replace the header in a single file before applying
the command to the whole project:

```
spdx-tool --only-licenses=Apache-2.0,MIT --update=spdx,1..2 file...
```


## OPTIONS

The following options are recognized by **spdx-tool**:


*\-c* config Load the
*spdx-tool* configuration file to configure default filters, languages and license templates.


*\-\-no-color* Disable colors in output.


*\-\-no-builtin-licenses* Disable the builtin repository licenses used by the tool.


*\-t* count Defines the number of threads for the encryption and decryption process.
By default, it uses the number of system CPU cores.


*\-V* Prints the
*spdx-tool* version.


*\-v* Enable the verbose mode.


*\-vv* Enable a more verbose execution mode.


*\-vvv* Enable debugging output.


*\-\-files* Check and gather licenses used in source files.  The report indicates the list of files grouped by the
license SPDX name.


*\-\-identify* After identifying the license, print a single line report with the path and license tag found.
The output is intended to be easily parsed by tools such as
**sed** (1) or
**grep** (1). 

*\-\-languages* Print the report about the languages identified in source files.
The report contains the list of files grouped by the language identified.
It can be used to identify and understand why some files have no license header.


*\-\-licenses* Print the report about the licenses identified in source files.
The report indicates a list of license with their SPDX name,
the number of files found and the overall ratio of files per-license.


*\-\-mimes* Produce a report with the list of files grouped by the mime type that is identified.  This option is
useful to understand why some files have no license header.


*\-\-line-number* Emit line number when printing the license text that is extracted.
Line number are relative to the license text since they are intended to help
for the definition of the
*\-\-update* pattern to decide which line must be kept.


*\-\-print-license* Print the license which was identified from the source file after the analysis.


*\-\-update* pattern Update the license header found by the equivalent SPDX license with the
*SPDX-License-Identifier* tag.  The
*pattern* string allows to control the replacement to allow keeping some lines from the existing license header.


*\-\-ignore\-licenses* spdx\-name1,spdx\-name2,... When printing report or updating files, ignore the licenses which correspond to one
of the SPDX license tag defined in the parameter.


*\-\-ignore\-languages* lang1,lang2,... When printing report or updating files, ignore the languages which correspond to one
of the name defined in the parameter.


*\-\-only\-licenses* spdx-name1,spdx-name2,... When printing report or updating files, only take into account the licenses which correspond to one
of the SPDX license tag defined in the parameter.


*\-\-only\-languages* lang1,lang2,... When printing report or updating files, only take into account the languages which correspond to one
of the name defined in the parameter.


*\-\-output\-json* file Produce a JSON report in the given file with a summary of licenses, languages and files found
during the analysis.


*\-\-output\-xml* file Produce a XML report in the given file with a summary of licenses, languages and files found
during the analysis.

## CONFIGURATION

A TOML configuration file can be specified either by creating a
*.spdxtool* file in the root directory of a project or by using the
*--config* option.


*color=* {"yes"|"no"} Controls whether the terminal colors are used.


*ignore=* [patterns] Define a list of patterns representing files that must be ignored for the license identification.


*ignore-files=* [paths] Define a list of paths representing files with patterns representing files that must be ignored for the license identification.
When the path starts with the prefix
*spdx-tool:* the file is considered being provided and embedded by the
*spdx-tool* . 
Example of configuration file:
```
[default]
color="no"
ignore-files=[
"spdx-tool:ignore.txt",
"spdx-tool:ignore-docs.txt"
]
ignore=[
"*.md",
"*.html",
"*.xml",
".readthedocs.yaml",
"docs/pagebreak.tex"
]
```

## SEE ALSO

**file** (1) 
## AUTHOR

Written by Stephane Carrez.

