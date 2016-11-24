# You need protoc-gen-doc in PATH in order to generate docs
# See https://github.com/estan/protoc-gen-doc

.SUFFIXES:
.DELETE_ON_ERROR:
.PHONY: FORCE

PATH:=${HOME}/opt/protoc-gen-doc:${PATH}
PROTO_SRC:=$(foreach f,types vmc, proto/$f.proto)


python: python/vmc/models/vmc_pb2.py
python/vmc/models/vmc_pb2.py:: FORCE;
python/vmc/models/vmc_pb2.py:: ${PROTO_SRC}
	protoc --proto_path=${<D} --python_out=${@D} $^



docs: $(foreach s,md html pdf,doc/vmc.$s)

doc/vmc.md: ${PROTO_SRC}
	protoc --proto_path=${<D} --doc_out=markdown,${@F}:${@D} $^
doc/vmc.html: ${PROTO_SRC}
	protoc --proto_path=${<D} --doc_out=html,${@F}:${@D} $^
doc/vmc.docbook: ${PROTO_SRC}
	protoc --proto_path=${<D} --doc_out=docbook,${@F}:${@D} $^
doc/vmc.pdf: doc/vmc.docbook
	fop -xml $< \
		-xsl /usr/share/xml/docbook/stylesheet/docbook-xsl/fo/docbook.xsl \
		-param use.extensions 0 \
		-param fop1.extensions 1 \
		-pdf $@
