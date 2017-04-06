# You need protoc-gen-doc in PATH in order to generate docs
# See https://github.com/estan/protoc-gen-doc

# Frequent targets:
# code -- make all derived code
# docs -- make docs
# packages -- make packages (from code)


.SUFFIXES:
.DELETE_ON_ERROR:
.PHONY: FORCE

PATH:=${HOME}/opt/protoc-gen-doc:${PATH}


all: code docs packages


# TODO: Add support for c++, go, java, javascript
.PHONY: code
code: .code-built
.code-built: src/vmc.proto
	protoc --version
	protoc \
		--proto_path=${<D} \
		--python_out=python/vmc $^ \
	| tee $@


.PHONY: packages python-package
packages: python-package
python-package:
	make -C python bdist_wheel


.PHONY: docs
docs: $(foreach s,md html pdf,doc/vmc.$s)
doc/vmc.md: src/vmc.proto
	protoc --doc_out=markdown,${@F}:${@D} $^
doc/vmc.html: src/vmc.proto
	protoc --doc_out=html,${@F}:${@D} $^
doc/vmc.docbook: src/vmc.proto
	protoc --doc_out=docbook,${@F}:${@D} $^
doc/vmc.pdf: doc/vmc.docbook
	fop -xml $< \
		-xsl /usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl \
		-param use.extensions 0 \
		-param fop1.extensions 1 \
		-pdf $@


############################################################################
#= CLEANUP

#=> clean: remove temporary and backup files
.PHONY: clean
clean:
	find . \( -name \*~ -o -name \*.bak \) -print0 | xargs -0r rm
	make -C python $@

#=> cleaner: remove files and directories that are easily rebuilt
.PHONY: cleaner
cleaner: clean
	find . \( -name \*.orig -o -name \*.rej \) -print0 | xargs -0r rm
	make -C python $@

#=> cleanest: remove files and directories that require more time/network fetches to rebuild
.PHONY: cleanest
cleanest: cleaner
	make -C python $@

