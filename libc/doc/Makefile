UDO = udo

all: html/index.html

WHITESMITH_DOC = \
	whitesmith_idris_programmers_manual.u \
	preface.ui \
	whitesmithing.ui \
	system_interface.ui \
	programming_file_formats.ui \
	support_library.ui \
	$(empty)

html/index.html: $(WHITESMITH_DOC)
	$(UDO) --html -o $@ $<

