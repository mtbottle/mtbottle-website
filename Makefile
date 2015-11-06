watch:
	stack exec site watch

build:
	stack build
	stack exec site build

upload: build
	tar cfvz blog.tar.gz _site
	scp blog.tar.gz michtran@michtran.ca:~/

rebuild:
	stack exec site rebuild

clean:
	rm -rf _site _cache blog.tar.gz
	rm  -f ./site *.hi *.o
