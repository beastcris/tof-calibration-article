# Adapted from sadekovlar/misis-article-latex for this article.
LATEX ?= tectonic

.PHONY: all article dist clean

all: article

article:
	mkdir -p build
	$(LATEX) --keep-logs -o build article.tex

# Self-contained source archive for Overleaf (select XeLaTeX).
dist:
	rm -rf dist/tof-calibration-overleaf
	mkdir -p dist/tof-calibration-overleaf
	cp article.tex misisarticle.cls README.md LICENSE TEMPLATE.md dist/tof-calibration-overleaf/
	if [ -f metadata.tex ]; then cp metadata.tex dist/tof-calibration-overleaf/; fi
	for dir in sections figures LICENSES; do \
		if [ -d "$$dir" ]; then cp -R "$$dir" dist/tof-calibration-overleaf/; fi; \
	done
	rm -f dist/tof-calibration-overleaf.zip
	cd dist/tof-calibration-overleaf && zip -r ../tof-calibration-overleaf.zip .
	rm -rf dist/tof-calibration-overleaf

clean:
	rm -rf build .ci-fontcheck dist/tof-calibration-overleaf
	rm -f dist/tof-calibration-overleaf.zip
	rm -f article.aux article.log article.out article.toc article.bbl article.blg
	rm -f article.bcf article.run.xml article.xdv article.synctex.gz article.fls article.fdb_latexmk article.pdf
