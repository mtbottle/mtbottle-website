watch:
	stack exec site watch

build:
	stack build
	stack exec site build

rebuild:
	stack exec site rebuild

clean:
	rm -rf _site _cache blog.tar.gz
	rm  -f ./site *.hi *.o
