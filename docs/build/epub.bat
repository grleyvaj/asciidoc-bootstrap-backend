@ECHO OFF

REM ---
REM --- Windows CMD script
REM --- to build AsciiDoc-Bootstrap backend documentation in HTML chunked / HTML Help / ePUB / PDF (a4 and us) format
REM ---
REM --- Released under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
REM --- (c) 2014 Laurent Laville
REM ---

IF "%ASCIIDOC%"==""       SET "ASCIIDOC=C:\asciidoc-8.6.9"
IF "%ASCIIDOC_BIN%"==""   SET "ASCIIDOC_BIN=%ASCIIDOC%\asciidoc.py"
IF "%A2X_BIN%"==""        SET "A2X_BIN=%ASCIIDOC%\a2x.py"
IF "%ASCIIDOC_THEME%"=="" SET "ASCIIDOC_THEME=readable"
IF "%HHC_BIN%"==""        SET "HHC_BIN=C:\Program Files\HTML Help Workshop\hhc.exe"

REM --
REM -- WEB HTML CHUNKED FORMAT
REM --
ECHO GENERATING WEB HTML CHUNKED FORMAT ...

"%A2X_BIN%" %1 --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f chunked -D . asciidocbootstrap-book.asciidoc

REM --
REM -- HTML HELP FORMAT
REM --
ECHO GENERATING HTML HELP FORMAT ...

"%A2X_BIN%" %1 --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f htmlhelp -D . asciidocbootstrap-book.asciidoc

"%HHC_BIN%" asciidocbootstrap-book.hhp

REM --
REM -- PDF A4 FORMAT
REM --
ECHO GENERATING PDF A4 FORMAT ...

"%A2X_BIN%" %1 %2 --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f pdf --fop asciidocbootstrap-book.asciidoc

MOVE /Y asciidocbootstrap-book.pdf asciidocbootstrap-book-a4.pdf

REM --
REM -- PDF US FORMAT
REM --
ECHO GENERATING PDF US FORMAT ...

"%A2X_BIN%" %1 %2 --xsl-file="%ASCIIDOC%"/docbook-xsl/fo-custom.xsl --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f pdf --fop asciidocbootstrap-book.asciidoc

MOVE /Y asciidocbootstrap-book.pdf asciidocbootstrap-book-us.pdf

REM --
REM -- ePUB FORMAT
REM --
ECHO GENERATING ePUB FORMAT ...

"%A2X_BIN%" %1 %2 -a docinfo --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f epub asciidocbootstrap-book.asciidoc

REM --
REM -- Single xHTML page FORMAT
REM --
ECHO GENERATING Single xHTML page FORMAT ...

"%A2X_BIN%" %1 %2 --resource=./images -L --icons --stylesheet=./stylesheets/docbook-xsl.css -d book -f xhtml asciidocbootstrap-book.asciidoc
