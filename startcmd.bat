@echo off
REM Generated file, do not edit manually
echo "NOTE: The startcmd.bat has been deprecated, use the dita.bat command instead."
pause

REM Get the absolute path of DITAOT's home directory
set DITA_DIR=%~dp0

REM Set environment variables
set ANT_OPTS=-Xmx512m %ANT_OPTS%
set ANT_OPTS=%ANT_OPTS% -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl
set ANT_HOME=%DITA_DIR%
set PATH=%DITA_DIR%\bin;%PATH%
set CLASSPATH=%DITA_DIR%lib;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\Saxon-HE-12.4.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant-apache-resolver-1.10.14.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant-launcher.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\ant.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\commons-codec-1.15.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\commons-io-2.8.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\dost-configuration.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\dost.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\guava-32.1.1-jre.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\httpclient5-5.1.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\httpcore5-5.1.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\httpcore5-h2-5.1.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\icu4j-74.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\isorelax-20030108.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-annotations-2.16.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-core-2.16.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-databind-2.16.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jackson-dataformat-yaml-2.16.1.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\jing-20220510.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\logback-classic-1.4.14.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\logback-core-1.4.14.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\slf4j-api-2.0.12.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\snakeyaml-2.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xercesImpl-2.12.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-apis-1.4.01.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xml-resolver-1.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xmlresolver-5.2.3-data.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xmlresolver-5.2.3.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.htmlhelp\lib\htmlhelp.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2\lib\fo.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\com.elovirta.pdf\lib\pdf-generator-0.7.2.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.eclipsehelp\lib\eclipsehelp.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.index\lib\index.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.axf\lib\axf.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\batik-all-1.17.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\fontbox-2.0.28.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\fop-core-2.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\fop-events-2.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\fop-pdf-images-2.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\fop-util-2.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\jcl-over-slf4j-2.0.7.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\pdfbox-2.0.28.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\slf4j-api-2.0.7.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\xml-apis-ext-1.3.04.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.fop\lib\xmlgraphics-commons-2.9.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.dita.pdf2.xep\lib\xep.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\org.lwdita-5.7.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\htmlparser-1.4.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-abbreviation-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-admonition-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-anchorlink-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-attributes-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-autolink-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-definition-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-footnotes-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-gfm-strikethrough-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-jekyll-tag-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-ins-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-superscript-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-tables-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-typographic-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-ext-yaml-front-matter-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-format-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-ast-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-builder-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-dependency-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-html-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-sequence-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-collection-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-data-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-misc-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\flexmark-util-visitor-0.64.0.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%plugins\org.lwdita\lib\autolink-0.6.0.jar;%CLASSPATH%
start "DITA-OT" cmd.exe
