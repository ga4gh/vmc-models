# You need protoc-gen-doc in PATH in order to generate docs
# See https://github.com/estan/protoc-gen-doc

.SUFFIXES:
.DELETE_ON_ERROR:
.PHONY: FORCE

PATH:=${HOME}/opt/protoc-gen-doc:${PATH}
PROTO_SRC:=$(sort $(wildcard proto/*.proto))

all: $(foreach s,md html,doc/vmc.$s)

doc/vmc.md: ${PROTO_SRC}
	protoc --doc_out=markdown,${@F}:${@D} $^
doc/vmc.html: ${PROTO_SRC}
	protoc --doc_out=html,${@F}:${@D} $^

#protoc --doc_out=docbook,example.docbook:doc proto/*.proto
#fop -xml doc/example.docbook \
#	-xsl /usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl \
#	-param use.extensions 0 \
#	-param fop1.extensions 1 \
#	-param paper.type A4 \
#	-param page.orientation landscape \
#	-pdf doc/example.pdf
