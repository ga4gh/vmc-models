# You need protoc-gen-doc in PATH in order to generate docs
# See https://github.com/estan/protoc-gen-doc

.SUFFIXES:
.DELETE_ON_ERROR:
.PHONY: FORCE

PATH:=${HOME}/opt/protoc-gen-doc:${PATH}


all: docs code packages


# TODO: add other languages
# See https://developers.google.com/protocol-buffers/docs/overview
.PHONY: code
code: .code-built
.code-built: src/vmc.proto
	protoc --proto_path=${<D} --python_out=python/vmc/models $^ | tee $@


packages:
	make -C python bdist_wheel


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
