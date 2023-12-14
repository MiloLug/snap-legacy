OUT_DIR = dist
TRANSPILE = "./make-tools/transpile.sh"

SOURCES_JS := \
	$(wildcard locale/*.js) \
	$(wildcard src/*.js) \
	$(wildcard libraries/*.js) \
	$(wildcard libraries/TuneScope/*.js) \
	$(wildcard libraries/TuneScope/tonejs/package/dist/*.js) \
	$(wildcard libraries/TuneScope/tonejs/package/build/*.js)
OUT_SOURCES_JS := $(addprefix ${OUT_DIR}/,${SOURCES_JS})

SOURCES_STATIC := \
	$(wildcard libraries/*.xml) libraries/LIBRARIES \
	$(wildcard *.html)
OUT_SOURCES_STATIC := $(addprefix ${OUT_DIR}/,${SOURCES_STATIC})

ASSETS := \
	Sounds \
    Costumes \
    Backgrounds \
    Examples \
    img \
    manifest.json \
    sw.js \
    src/favicon.ico \
    help
OUT_ASSETS := $(addprefix ${OUT_DIR}/,${ASSETS})

${OUT_DIR}:
	mkdir -p $@
	mkdir -p $@/locale
	mkdir -p $@/libraries/TuneScope/tonejs/{dist,build}
	mkdir -p $@/src
	mkdir -p $@/help

${OUT_DIR}/locale/%.js: locale/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@

${OUT_DIR}/src/%.js: src/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@

${OUT_DIR}/libraries/%.js: libraries/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@

${OUT_DIR}/libraries/TuneScope/%.js: libraries/TuneScope/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@

${OUT_DIR}/libraries/TuneScope/tonejs/package/dist/%.js: libraries/TuneScope/tonejs/dist/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@

${OUT_DIR}/libraries/TuneScope/tonejs/package/build/%.js: libraries/TuneScope/tonejs/build/%.js | ${OUT_DIR}
	${TRANSPILE} $< $@


${OUT_DIR}/libraries/%.xml: libraries/%.xml | ${OUT_DIR}
	cp -r $< $@
	cp -r libraries/LIBRARIES ${OUT_DIR}/libraries/LIBRARIES

${OUT_DIR}/%.html: %.html | ${OUT_DIR}
	cp -r $< $@


${OUT_ASSETS}: ${ASSETS} | ${OUT_DIR}
	for asset in ${ASSETS}; do \
		cp -r $$asset ${OUT_DIR}/$$asset; \
	done


build: \
	${OUT_SOURCES_JS} \
	${OUT_SOURCES_STATIC} \
	${OUT_ASSETS} \
	| ${OUT_DIR}

clean:
	rm -rf ${OUT_DIR}

