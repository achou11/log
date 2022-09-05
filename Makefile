install-deps:
	jpm -l load-lockfile lockfile.jdn

bag-build: clean
	./jpm_tree/bin/bag index.janet

clean:
	rm -rf ./site/
