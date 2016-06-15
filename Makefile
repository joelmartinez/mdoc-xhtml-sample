assemble:
	mdoc assemble -o xhtml-test --format=xhtml TOC.html

install: assemble
	cp xhtml-test.* /Library/Frameworks/Mono.framework/External/monodoc